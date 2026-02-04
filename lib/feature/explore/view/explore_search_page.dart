import 'package:driver_mate/core/utils/app_colors.dart';
import 'package:driver_mate/core/utils/app_constants.dart';
import 'package:driver_mate/core/utils/app_font_size.dart';
import 'package:driver_mate/core/utils/app_style.dart';
import 'package:driver_mate/core/utils/size.dart';
import 'package:driver_mate/feature/explore/data/explore_mock.dart';
import 'package:driver_mate/feature/explore/data/model/explore_model.dart';
import 'package:flutter/material.dart';

class ExploreSearchPage extends StatefulWidget {
  const ExploreSearchPage({super.key});

  @override
  State<ExploreSearchPage> createState() => _ExploreSearchPageState();
}

class _ExploreSearchPageState extends State<ExploreSearchPage> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  String _query = '';
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
    _recent.removeWhere((item) => item.toLowerCase() == value.toLowerCase());
    _recent.insert(0, value);
    if (_recent.length > 6) {
      _recent.removeRange(6, _recent.length);
    }
  }

  void _clearRecent() {
    setState(() => _recent.clear());
  }

  void _clearQuery() {
    _controller.clear();
    setState(() => _query = '');
  }

  List<CarItem> get _carResults {
    if (_query.isEmpty) return const <CarItem>[];
    final q = _query.toLowerCase();
    return mockCars.where((c) => c.title.toLowerCase().contains(q)).toList();
  }

  List<ServiceCenterItem> get _serviceResults {
    if (_query.isEmpty) return const <ServiceCenterItem>[];
    final q = _query.toLowerCase();
    return mockServices
        .where((s) => s.name.toLowerCase().contains(q))
        .toList();
  }

  Widget _sectionHeader(String title, {Widget? action}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: AppStyle.containerSubtitle.copyWith(
            color: AppColors.iconGrey,
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
      leading: const Icon(Icons.history, color: AppColors.iconGrey),
      title: Text(
        title,
        style: AppStyle.boldSmallText.copyWith(fontSize: AppFontSize.f13),
      ),
      onTap: () => _applyQuery(title),
    );
  }

  Widget _buildResultTile({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon, color: AppColors.cyanColor),
      title: Text(
        title,
        style: AppStyle.boldSmallText.copyWith(fontSize: AppFontSize.f13),
      ),
      subtitle: Text(
        subtitle,
        style: AppStyle.hintStyle.copyWith(fontSize: AppFontSize.f11),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final resultsEmpty =
        _query.isNotEmpty && _carResults.isEmpty && _serviceResults.isEmpty;
    final canClearRecent = _recent.isNotEmpty;

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          AppConstants.search,
          style: AppStyle.socialButtonTextStyle.copyWith(
            fontSize: AppFontSize.f20,
          ),
        ),
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
              TextField(
                controller: _controller,
                focusNode: _focusNode,
                cursorColor: AppColors.cyanColor,
                textInputAction: TextInputAction.search,
                onChanged: _onChanged,
                onSubmitted: _applyQuery,
                decoration: InputDecoration(
                  hintText: AppConstants.searchExploreHint,
                  hintStyle: AppStyle.hintStyle,
                  prefixIcon:
                      const Icon(Icons.search, color: AppColors.iconGrey),
                  suffixIcon: _query.isEmpty
                      ? const Icon(Icons.tune, color: AppColors.iconGrey)
                      : IconButton(
                          onPressed: _clearQuery,
                          icon: const Icon(
                            Icons.close,
                            color: AppColors.iconGrey,
                          ),
                        ),
                  filled: true,
                  fillColor: AppColors.white,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppFontSize.f12),
                    borderSide: BorderSide(color: AppColors.boarderWhiteColor),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppFontSize.f12),
                    borderSide: BorderSide(color: AppColors.cyanColor),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppFontSize.f12),
                    borderSide: BorderSide(color: AppColors.boarderWhiteColor),
                  ),
                ),
              ),
              SizedBox(height: SizeConfig.height(context) * 0.02),
              if (_query.isEmpty) ...[
                _sectionHeader(
                  AppConstants.recent,
                  action: TextButton(
                    onPressed: canClearRecent ? _clearRecent : null,
                    child: Text(
                      AppConstants.clearAll,
                      style: AppStyle.viewAll.copyWith(
                        color:
                            canClearRecent ? AppColors.cyanColor : AppColors.iconGrey,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                if (_recent.isEmpty)
                  Text(
                    AppConstants.noRecentSearches,
                    style: AppStyle.hintStyle,
                  )
                else
                  Column(
                    children: _recent.map(_buildRecentTile).toList(),
                  ),
                const SizedBox(height: 12),
                _sectionHeader(AppConstants.suggestions),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: _suggestions
                      .map(
                        (item) => ActionChip(
                          label: Text(item),
                          labelStyle: AppStyle.containerSubtitle.copyWith(
                            color: AppColors.textGrey,
                            fontSize: AppFontSize.f11,
                          ),
                          backgroundColor: AppColors.containerGrey,
                          shape: StadiumBorder(
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
                _sectionHeader(AppConstants.results),
                const SizedBox(height: 4),
                if (resultsEmpty)
                  Text(
                    AppConstants.noResults,
                    style: AppStyle.hintStyle,
                  )
                else ...[
                  for (final car in _carResults)
                    _buildResultTile(
                      icon: Icons.directions_car,
                      title: car.title,
                      subtitle:
                          '\$${car.price.toStringAsFixed(0)} - ${car.location}',
                    ),
                  for (final service in _serviceResults)
                    _buildResultTile(
                      icon: Icons.build_circle_outlined,
                      title: service.name,
                      subtitle:
                          '${service.distanceKm.toStringAsFixed(1)} km - ${service.rating.toStringAsFixed(1)}',
                    ),
                ],
              ],
            ],
          ),
        ),
      ),
    );
  }
}
