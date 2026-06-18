import 'package:driver_mate/core/service/local_notification_service.dart';
import 'package:driver_mate/core/service/work_manger_service.dart';
import 'package:driver_mate/core/theme/theme.dart';
import 'package:driver_mate/core/theme/theme_cubit.dart';
import 'package:driver_mate/core/theme/theme_state.dart';
import 'package:driver_mate/feature/languge/manager/languge_cubit.dart';
import 'package:driver_mate/l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:driver_mate/feature/ai/manager/cubit/ai_diagnosis_response_cubit.dart';
import 'package:driver_mate/feature/ai/manager/cubit/get_diagnosis_history_cubit.dart';
import 'package:driver_mate/feature/auth/manager/auth/auth_cubit.dart';
import 'package:driver_mate/feature/community/data/repo/community_post_repo.dart';
import 'package:driver_mate/feature/community/manager/community_post_manager/community_post_cubit.dart';
import 'package:driver_mate/feature/maintance_booking/data/repo/maintenance_repo.dart';
import 'package:driver_mate/feature/maintance_booking/manager/cubit/maintenance_cubit.dart';
import 'package:driver_mate/feature/maintance_history/data/repo/maintance_history_repo.dart';
import 'package:driver_mate/feature/maintance_history/manager/cubit/maintence_history_cubit.dart';
import 'package:driver_mate/feature/mycars/data/repo/vechicle_repo.dart';
import 'package:driver_mate/feature/mycars/manager/vehical_cubit.dart';
import 'package:driver_mate/feature/profile/data/repo/edit_profile_repo.dart';
import 'package:driver_mate/feature/profile/manager/edit_profile_manager/edit_profile_cubit.dart';
import 'package:driver_mate/feature/saved_item/data/repo/saved_item_repo.dart';
import 'package:driver_mate/feature/saved_item/manager/cubit/saved_item_cubit.dart';
import 'package:driver_mate/feature/splach/view/splach_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Future.wait([
    LocalNotificationService.initialize(),
    WorkManagerService().init(),
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ThemeCubit>(
          create: (context) => ThemeCubit()..loadTheme(),
        ),
        BlocProvider(
          create: (context) => EditProfileCubit(repo: EditProfileRepo()),
        ),
        BlocProvider(create: (context) => AuthCubit()),
        BlocProvider(
          create: (context) => VehicalCubit(repo: VechicleRepo())..loadCar(),
        ),
        BlocProvider(
          create: (context) =>
              MaintenanceCubit(MaintenanceRepo())..loadCenters(),
        ),

        BlocProvider<CommunityPostCubit>(
          create: (context) =>
              CommunityPostCubit(repo: InMemoryCommunityPostRepository())
                ..loadPosts(),
        ),

        BlocProvider(create: (context) => AiDiagnosisCubit()),
        BlocProvider(create: (context) => GetDiagnosisHistoryCubit()),
        BlocProvider(
          create: (context) => SavedItemCubit(SavedItemRepo())..loadItems(),
        ),
        BlocProvider(create: (context) => LanguageCubit()..loadSavedLanguage()),
        BlocProvider(
          create: (context) =>
              MaintenceHistoryCubit(MaintanceHistoryRepo())..loadItems(),
        ),
      ],
      child: // main.dart — replace BlocBuilder with BlocConsumer
      BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, themeState) {
          return BlocConsumer<LanguageCubit, Locale>(
            listener: (context, locale) {
              Get.updateLocale(locale);
            },
            builder: (context, locale) {
              return GetMaterialApp(
                theme: context.read<ThemeCubit>().themeData,
                darkTheme: darkMode,
                themeMode: context.read<ThemeCubit>().themeData == lightMode
                    ? ThemeMode.light
                    : ThemeMode.dark,

                locale: locale,
                fallbackLocale: const Locale('en'),
                supportedLocales: const [Locale('en'), Locale('ar')],

                localizationsDelegates: const [
                  AppLocalizations.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],

                home: SafeArea(top: false, child: const SplachPage()),
              );
            },
          );
        },
      ),
    );
  }
}
