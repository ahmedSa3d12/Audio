import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:new_mazoon/features/monthplan/cubit/month_cubit.dart';
import 'package:quick_actions/quick_actions.dart';
// import 'package:screenshot_callback/screenshot_callback.dart';

import 'config/routes/app_routes.dart';
import 'config/themes/app_theme.dart';
import 'core/preferences/preferences.dart';
import 'core/utils/app_colors.dart';
import 'core/utils/app_strings.dart';
import 'package:new_mazoon/injector.dart' as injector;
import 'dart:developer' as developer;
import 'package:path/path.dart';

import 'core/utils/toast_message_method.dart';
// import 'features/downloads_videos/cubit/downloads_videos_cubit.dart';
import 'features/examRegister/cubit/exam_register_cubit.dart';
import 'features/homePage/cubit/home_page_cubit.dart';
import 'features/lessons_of_class/cubit/lessons_class_cubit.dart';
import 'features/login/cubit/login_cubit.dart';
import 'features/navigation_bottom/cubit/navigation_cubit.dart';
import 'features/onboarding/cubit/on_boarding_cubit.dart';
import 'features/splash/presentation/cubit/splash_cubit.dart';
import 'features/start_trip/cubit/start_trip_cubit.dart';

class Elmazoon extends StatefulWidget {
  const Elmazoon({Key? key}) : super(key: key);

  @override
  State<Elmazoon> createState() => _ElmazoonState();
}

class _ElmazoonState extends State<Elmazoon> {
  ConnectivityResult _connectionStatus = ConnectivityResult.none;

  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  bool isThemes = false;
  String shortcut = 'no action set';

  @override
  void initState() {
    super.initState();
    initConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen((event) {
      if (event.index == 4) {
        toastMessage(
          'no_internet_connection'.tr(),
          context,
          color: AppColors.error,
        );
      } else if (event == 1 || event == 3) {
        toastMessage(
          'internet_connection'.tr(),
          context,
          color: AppColors.success,
        );
      }
      _updateConnectionStatus(event);
    });

    const QuickActions quickActions = QuickActions();
    quickActions.initialize((String shortcutType) {
      setState(() {
        if (shortcutType != null) {
          shortcut = shortcutType;
        }
      });
    });

    quickActions.setShortcutItems(<ShortcutItem>[
      // NOTE: This first action icon will only work on iOS.
      // In a real world project keep the same file name for both platforms.
      const ShortcutItem(
        type: 'Clear Cache',
        localizedTitle: 'Action one',
        icon: 'AppIcon',
      ),
      // NOTE: This second action icon will only work on Android.
      // In a real world project keep the same file name for both platforms.
      const ShortcutItem(
        type: 'action_two',
        localizedTitle: 'Action two',
        icon: 'ic_launcher',
      ),
    ]).then((void _) {
      setState(() {
        if (shortcut == 'no action set') {

          // Preferences.instance.clearAllData();
          //
          // shortcut = 'actions ready';
        }
      });
    });
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  Future<void> initConnectivity() async {
    late ConnectivityResult result;
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      developer.log('Couldn\'t check connectivity status', error: e);
      return;
    }
    if (!mounted) {
      return Future.value(null);
    }
    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    setState(() {
      _connectionStatus = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    // print(text);

    Preferences.instance.savedLang(
      EasyLocalization.of(context)!.locale.languageCode,
    );
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => injector.serviceLocator<SplashCubit>(),
        ),
        BlocProvider(
          create: (_) => injector.serviceLocator<LoginCubit>(),
        ),
        BlocProvider(
          create: (_) => injector.serviceLocator<NavigationCubit>(),
        ),
        BlocProvider(
          create: (_) => injector.serviceLocator<HomePageCubit>(),
        ),
        BlocProvider(
          create: (_) => injector.serviceLocator<OnBoardingCubit>(),
        ),
        BlocProvider(
          create: (_) => injector.serviceLocator<StartTripCubit>(),
        ),
        // BlocProvider(
        //   create: (_) => injector.serviceLocator<DownloadsVideosCubit>(),
        // ),
        BlocProvider(
          create: (_) => injector.serviceLocator<LessonsClassCubit>(),
        ),
        BlocProvider(
          create: (_) => injector.serviceLocator<MonthPlanCubit>(),
        ),
        BlocProvider(
          create: (_) => injector.serviceLocator<ExamRegisterCubit>(),
        ),
      ],
      child: MaterialApp(
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        theme: appTheme(),
        localizationsDelegates: context.localizationDelegates,
        debugShowCheckedModeBanner: false,
        title: AppStrings.appName,
        onGenerateRoute: AppRoutes.onGenerateRoute,
      ),
    );
  }
}
