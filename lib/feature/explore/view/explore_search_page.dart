import 'package:driver_mate/core/utils/app_colors.dart';
import 'package:driver_mate/core/utils/app_font_size.dart';
import 'package:driver_mate/core/utils/app_strings.dart';
import 'package:driver_mate/core/utils/app_style.dart';
import 'package:driver_mate/core/utils/size.dart';
import 'package:driver_mate/feature/car_details/view/car_details_page.dart';
import 'package:driver_mate/feature/cartips/view/cartips_page.dart';
import 'package:driver_mate/feature/explore/data/explore_filter.dart';
import 'package:driver_mate/feature/explore/data/explore_mock.dart';
import 'package:driver_mate/feature/explore/data/model/explore_model.dart';
import 'package:driver_mate/feature/explore/view/widget/explore_filter_sheet.dart';
import 'package:driver_mate/feature/maintance_booking/data/model/service_center_model.dart';
import 'package:driver_mate/feature/maintance_booking/manager/cubit/maintenance_cubit.dart';
import 'package:driver_mate/feature/maintance_booking/manager/state/maintenance_state.dart';
import 'package:driver_mate/feature/maintance_booking/view/service_center_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExploreSearchPage extends StatefulWidget {
  const ExploreSearchPage({super.key});

  @override
  State<ExploreSearchPage> createState() => _ExploreSearchPageState();
}

class _ExploreSearchPageState extends State<ExploreSearchPage> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  String _query = '';
  ExploreFilter _filter = ExploreFilter.initial;

  final List<String> _recent = [
    'Toyota Camry',
    'Oil change service',
    'Brake noise problem',
    'Best tires Dubai',
    'Car inspection centers',
  ];

  final List<String> _suggestions = const [
    'Tires',
    'Oil change',
    'Brake noise',
    'Nearby centers',
    'Battery replacement',
  ];

  @override
  void initState() {
    super.initState();
    // Auto-focus the search field when the page opens
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _onChanged(String value) {
    setState(() => _query = value.trim());
  }

  void _applyQuery(String value) {
    final trimmed = value.trim();
    if (trimmed.isEmpty) return;

    _controller.text = trimmed;
    _controller.selection = TextSelection.collapsed(offset: trimmed.length);
    _focusNode.requestFocus();

    _addRecent(trimmed);
    setState(() => _query = trimmed);
  }

  void _addRecent(String value) {
    setState(() {
      _recent.removeWhere((item) => item.toLowerCase() == value.toLowerCase());
      _recent.insert(0, value);
      if (_recent.length > 6) {
        _recent.removeRange(6, _recent.length);
      }
    });
  }

  void _clearRecent() {
    setState(() => _recent.clear());
  }

  void _clearQuery() {
    _controller.clear();
    setState(() => _query = '');
    _focusNode.requestFocus();
  }

  void _openFilterSheet() async {
    final result = await showModalBottomSheet<ExploreFilter>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (_) => ExploreFilterSheet(initial: _filter),
    );
    if (result != null) setState(() => _filter = result);
  }

  // ── Search results ──────────────────────────────────────────────────────────

  List<CarItem> get _carResults {
    if (_query.isEmpty) return const <CarItem>[];
    if (_filter.category != 'All' && _filter.category != 'Cars') return [];
    final q = _query.toLowerCase();
    return mockCars
        .where(
          (c) =>
              c.title.toLowerCase().contains(q) ||
              c.subtitle.toLowerCase().contains(q) ||
              c.location.toLowerCase().contains(q),
        )
        .where(
          (c) => c.price >= _filter.minPrice && c.price <= _filter.maxPrice,
        )
        .toList();
  }

  List<TipItem> get _tipResults {
    if (_query.isEmpty) return const <TipItem>[];
    if (_filter.category != 'All' && _filter.category != 'Tips') return [];
    final q = _query.toLowerCase();
    return mockTips
        .where(
          (t) =>
              t.title.toLowerCase().contains(q) ||
              t.category.toLowerCase().contains(q) ||
              t.excerpt.toLowerCase().contains(q),
        )
        .toList();
  }

  List<ServiceCenterModel> _serviceResults(List<ServiceCenterModel> all) {
    if (_query.isEmpty) return [];
    if (_filter.category != 'All' && _filter.category != 'Maintenance') {
      return [];
    }
    final q = _query.toLowerCase();
    return all
        .where(
          (s) =>
              s.name.toLowerCase().contains(q) ||
              s.address.toLowerCase().contains(q),
        )
        .where((s) => s.distance <= _filter.maxDistanceKm)
        .toList();
  }

  bool get _hasActiveFilter =>
      _filter.category != 'All' ||
      _filter.sortBy != 'Recommended' ||
      _filter.minPrice > 0 ||
      _filter.maxPrice < 100000 ||
      _filter.maxDistanceKm < 50;

  // ── Navigation helpers ──────────────────────────────────────────────────────

  void _navigateToCar(CarItem car) {
    _addRecent(car.title);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => CarDetailsPage(
          carName: car.title,
          carYear: car.subtitle,
          carType: car.category,
          carDescription: car.details,
          carImagePath: car.image,
          isNew: car.isNew,
        ),
      ),
    );
  }

  void _navigateToTip(TipItem tip) {
    _addRecent(tip.title);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => CarTipsPage(
          imagePath: tip.image,
          hintText: tip.readTime,
          labelText: tip.title,
        ),
      ),
    );
  }

  void _navigateToService(ServiceCenterModel center) {
    _addRecent(center.name);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ServiceCenterPage(
          serviceCenterName: center.name,
          workingHours: center.workingHours,
          address: center.address,
          phoneNumber: center.phone,
          imagePath: center.imagePath,
          serviceProvided: center.services,
          holiday: 'Friday',
        ),
      ),
    );
  }

  // ── Widgets ─────────────────────────────────────────────────────────────────

  Widget _sectionHeader(String title, {Widget? action}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: AppStyle.containerSubtitle.copyWith(
            color: Theme.of(context).colorScheme.onSurface,
            fontSize: AppFontSize.f11,
          ),
        ),
        if (action != null) action,
      ],
    );
  }

  Widget _buildRecentTile(String title) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(
        Icons.history,
        color: Theme.of(context).colorScheme.onSurface,
      ),
      title: Text(
        title,
        style: AppStyle.boldSmallText.copyWith(
          fontSize: AppFontSize.f13,
          color: Theme.of(context).colorScheme.onSurface,
        ),
      ),
      trailing: IconButton(
        icon: Icon(
          Icons.north_west,
          size: 16,
          color: Theme.of(context).iconTheme.color,
        ),
        onPressed: () => _applyQuery(title),
        tooltip: 'Fill in search field',
      ),
      onTap: () => _applyQuery(title),
    );
  }

  Widget _buildCarResultTile(CarItem car) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: CircleAvatar(
        backgroundColor: Theme.of(
          context,
        ).colorScheme.primary.withValues(alpha: 0.1),
        child: Icon(
          Icons.directions_car,
          color: Theme.of(context).colorScheme.primary,
          size: 20,
        ),
      ),
      title: Text(
        car.title,
        style: AppStyle.boldSmallText.copyWith(fontSize: AppFontSize.f13),
      ),
      subtitle: Text(
        '\$${car.price.toStringAsFixed(0)} · ${car.location}',
        style: AppStyle.hintStyle.copyWith(fontSize: AppFontSize.f11),
      ),
      trailing: car.isNew
          ? Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: AppColors.cyanColor.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(999),
              ),
              child: Text(
                'NEW',
                style: TextStyle(
                  color: AppColors.cyanColor,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          : null,
      onTap: () => _navigateToCar(car),
    );
  }

  Widget _buildServiceResultTile(ServiceCenterModel center) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: CircleAvatar(
        backgroundColor: AppColors.orange.withValues(alpha: 0.1),
        child: Icon(
          Icons.build_circle_outlined,
          color: AppColors.orange,
          size: 20,
        ),
      ),
      title: Text(
        center.name,
        style: AppStyle.boldSmallText.copyWith(fontSize: AppFontSize.f13),
      ),
      subtitle: Text(
        '${center.distance.toStringAsFixed(1)} km away',
        style: AppStyle.hintStyle.copyWith(fontSize: AppFontSize.f11),
      ),
      trailing: Icon(
        Icons.chevron_right,
        color: Theme.of(context).iconTheme.color,
      ),
      onTap: () => _navigateToService(center),
    );
  }

  Widget _buildTipResultTile(TipItem tip) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: CircleAvatar(
        backgroundColor: AppColors.green.withValues(alpha: 0.1),
        child: Icon(Icons.lightbulb_outline, color: AppColors.green, size: 20),
      ),
      title: Text(
        tip.title,
        style: AppStyle.boldSmallText.copyWith(fontSize: AppFontSize.f13),
      ),
      subtitle: Text(
        '${tip.category} · ${tip.readTime}',
        style: AppStyle.hintStyle.copyWith(fontSize: AppFontSize.f11),
      ),
      trailing: Icon(
        Icons.chevron_right,
        color: Theme.of(context).iconTheme.color,
      ),
      onTap: () => _navigateToTip(tip),
    );
  }

  Widget _buildFilterBadge() {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 200),
      child: _hasActiveFilter
          ? Container(
              key: const ValueKey('badge'),
              margin: const EdgeInsets.only(bottom: 8),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.cyanColor.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(999),
                border: Border.all(color: AppColors.cyanColor, width: 1),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.tune, size: 14, color: AppColors.cyanColor),
                  const SizedBox(width: 6),
                  Text(
                    'Filtered: ${_filter.category}${_filter.sortBy != "Recommended" ? " · ${_filter.sortBy}" : ""}',
                    style: TextStyle(
                      color: AppColors.cyanColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: () =>
                        setState(() => _filter = ExploreFilter.initial),
                    child: Icon(
                      Icons.close,
                      size: 14,
                      color: AppColors.cyanColor,
                    ),
                  ),
                ],
              ),
            )
          : const SizedBox.shrink(key: ValueKey('no-badge')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MaintenanceCubit, MaintenanceState>(
      builder: (context, maintenanceState) {
        final serviceCenters = maintenanceState is MaintenanceLoaded
            ? maintenanceState.centers
            : <ServiceCenterModel>[];

        final carResults = _carResults;
        final tipResults = _tipResults;
        final serviceResults = _serviceResults(serviceCenters);

        final totalResults =
            carResults.length + tipResults.length + serviceResults.length;
        final resultsEmpty = _query.isNotEmpty && totalResults == 0;

        return Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          appBar: AppBar(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            elevation: 0,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Theme.of(context).colorScheme.onSurface,
              ),
              onPressed: () => Navigator.pop(context),
            ),
            title: Text(
              AppStrings.of(context).search,
              style: AppStyle.socialButtonTextStyle.copyWith(
                fontSize: AppFontSize.f20,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            actions: [
              Stack(
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.tune,
                      color: Theme.of(context).iconTheme.color,
                    ),
                    onPressed: _openFilterSheet,
                    tooltip: 'Filter results',
                  ),
                  if (_hasActiveFilter)
                    Positioned(
                      top: 8,
                      right: 8,
                      child: Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: AppColors.cyanColor,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
          body: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: SizeConfig.width(context) * 0.05,
                vertical: SizeConfig.height(context) * 0.015,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ── Search field ──────────────────────────────────────────
                  TextField(
                    controller: _controller,
                    focusNode: _focusNode,
                    cursorColor: AppColors.cyanColor,
                    textInputAction: TextInputAction.search,
                    onChanged: _onChanged,
                    onSubmitted: _applyQuery,
                    decoration: InputDecoration(
                      hintText: AppStrings.of(context).searchExploreHint,
                      hintStyle: AppStyle.hintStyle,
                      prefixIcon: const Icon(
                        Icons.search,
                        color: AppColors.iconGrey,
                      ),
                      suffixIcon: _query.isNotEmpty
                          ? IconButton(
                              onPressed: _clearQuery,
                              icon: Icon(
                                Icons.close,
                                color: Theme.of(context).iconTheme.color,
                              ),
                            )
                          : null,
                      filled: true,
                      fillColor: Theme.of(context).scaffoldBackgroundColor,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(AppFontSize.f12),
                        borderSide: const BorderSide(
                          color: AppColors.boarderWhiteColor,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(AppFontSize.f12),
                        borderSide: const BorderSide(
                          color: AppColors.cyanColor,
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(AppFontSize.f12),
                        borderSide: const BorderSide(
                          color: AppColors.boarderWhiteColor,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: SizeConfig.height(context) * 0.015),

                  // ── Active filter badge ───────────────────────────────────
                  _buildFilterBadge(),

                  // ── Empty state / Recent / Suggestions ───────────────────
                  if (_query.isEmpty) ...[
                    _sectionHeader(
                      AppStrings.of(context).recent,
                      action: TextButton(
                        onPressed: _recent.isNotEmpty ? _clearRecent : null,
                        child: Text(
                          AppStrings.of(context).clearAll,
                          style: AppStyle.viewAll.copyWith(
                            color: _recent.isNotEmpty
                                ? Theme.of(context).colorScheme.primary
                                : Theme.of(context).iconTheme.color,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    if (_recent.isEmpty)
                      Text(
                        AppStrings.of(context).noRecentSearches,
                        style: AppStyle.hintStyle,
                      )
                    else
                      Column(children: _recent.map(_buildRecentTile).toList()),
                    const SizedBox(height: 16),
                    _sectionHeader(AppStrings.of(context).suggestions),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: _suggestions
                          .map(
                            (item) => ActionChip(
                              label: Text(item),
                              labelStyle: AppStyle.containerSubtitle.copyWith(
                                color: Theme.of(context).colorScheme.onSurface,
                                fontSize: AppFontSize.f11,
                              ),
                              backgroundColor: Theme.of(
                                context,
                              ).scaffoldBackgroundColor,
                              shape: const StadiumBorder(
                                side: BorderSide(
                                  color: AppColors.boarderWhiteColor,
                                ),
                              ),
                              onPressed: () => _applyQuery(item),
                            ),
                          )
                          .toList(),
                    ),
                  ] else ...[
                    // ── Results header with count ─────────────────────────
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _sectionHeader(AppStrings.of(context).results),
                        if (totalResults > 0)
                          Text(
                            '$totalResults found',
                            style: AppStyle.hintStyle.copyWith(
                              fontSize: AppFontSize.f11,
                              color: AppColors.cyanColor,
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 8),

                    if (resultsEmpty)
                      Column(
                        children: [
                          const SizedBox(height: 40),
                          Icon(
                            Icons.search_off,
                            size: 48,
                            color: Theme.of(context).iconTheme.color,
                          ),
                          const SizedBox(height: 12),
                          Text(
                            AppStrings.of(context).noResults,
                            style: AppStyle.hintStyle,
                          ),
                        ],
                      )
                    else ...[
                      // ── Car results ─────────────────────────────────────
                      if (carResults.isNotEmpty) ...[
                        _SectionLabel(
                          icon: Icons.directions_car_outlined,
                          label: 'Cars (${carResults.length})',
                        ),
                        ...carResults.map(_buildCarResultTile),
                        const Divider(height: 24),
                      ],

                      // ── Service Center results ──────────────────────────
                      if (serviceResults.isNotEmpty) ...[
                        _SectionLabel(
                          icon: Icons.build_outlined,
                          label: 'Service Centers (${serviceResults.length})',
                        ),
                        ...serviceResults.map(_buildServiceResultTile),
                        const Divider(height: 24),
                      ],

                      // ── Tip results ─────────────────────────────────────
                      if (tipResults.isNotEmpty) ...[
                        _SectionLabel(
                          icon: Icons.lightbulb_outline,
                          label: 'Tips (${tipResults.length})',
                        ),
                        ...tipResults.map(_buildTipResultTile),
                      ],
                    ],
                  ],
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _SectionLabel extends StatelessWidget {
  const _SectionLabel({required this.icon, required this.label});
  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        children: [
          Icon(icon, size: 14, color: AppColors.iconGrey),
          const SizedBox(width: 6),
          Text(
            label,
            style: AppStyle.containerSubtitle.copyWith(
              fontSize: AppFontSize.f11,
              color: AppColors.iconGrey,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
