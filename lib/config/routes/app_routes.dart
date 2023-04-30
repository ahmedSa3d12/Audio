import 'package:flutter/material.dart';
import 'package:new_mazoon/features/navigation_bottom/screens/navigation_bottom.dart';
import 'package:new_mazoon/features/onboarding/screens/onboarding_screen.dart';
import 'package:page_transition/page_transition.dart';

import '../../core/models/ads_model.dart';
import '../../core/models/times_model.dart';
import '../../core/utils/app_strings.dart';
import '../../features/examRegister/presentation/screens/exam_register.dart';
import '../../features/lessons_of_class/screens/lesson_class.dart';
import '../../features/login/screens/login.dart';
import '../../features/monthplan/screen/monthplan.dart';
import '../../features/sources_and_references/screens/source_references_details.dart';
import '../../features/splash/presentation/screens/pop_ads_screen.dart';
import '../../features/splash/presentation/screens/splash_screen.dart';

class Routes {
  static const String initialRoute = '/';
  static const String loginRoute = '/login';
  static const String examRegisterRoute = '/examregister';
  static const String homePageScreenRoute = '/homePageScreen';
  static const String monthplanPageScreenRoute = '/monthplanPageScreen';
  static const String onboardingPageScreenRoute = '/onboardingPageScreen';
  static const String podAdsPageScreenRoute = '/podAdsPageScreen';
  static const String lessonClassScreenRoute = '/lessonClassPageScreen';
  static const String sourceReferencesDetailsRoute = '/sourceReferencesDetails';
}

class AppRoutes {
  static String route = '';

  static Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.initialRoute:
        return MaterialPageRoute(
          builder: (context) => const SplashScreen(),
        );
      case Routes.loginRoute:
        return MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        );
      case Routes.lessonClassScreenRoute:
        int classId=settings.arguments as int;
        return MaterialPageRoute(
          builder: (context) => LessonsClassScreen(classId: classId),
        );
      case Routes.examRegisterRoute:
        TimeDataModel timeDataModel = settings.arguments as TimeDataModel;

        return MaterialPageRoute(
          builder: (context) => ExmRegisterPage(timeDataModel: timeDataModel),
        );
      case Routes.monthplanPageScreenRoute:
        return PageTransition(
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 1300),
          child: MonthPlan(),
        );
      case Routes.homePageScreenRoute:
        return PageTransition(
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 1300),
          child: Zoom(),
        );
      case Routes.onboardingPageScreenRoute:
        return PageTransition(
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 1300),
          child: OnBoardingScreen(),
        );

      case Routes.sourceReferencesDetailsRoute:
        return PageTransition(
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 1300),
          child: SourceReferencesDetails(),
        );

      case Routes.podAdsPageScreenRoute:
        AdsModelDatum adsModelDatum = settings.arguments as AdsModelDatum;

        return PageTransition(
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 1300),
          child: PopAdsScreen(
            adsDatum: adsModelDatum,
          ),
        );
      //  MaterialPageRoute(
      //   builder: (context) => const OnBoardingScreen(),
      // );

      default:
        return undefinedRoute();
    }
  }

  static Route<dynamic> undefinedRoute() {
    return MaterialPageRoute(
      builder: (context) => const Scaffold(
        body: Center(
          child: Text(AppStrings.noRouteFound),
        ),
      ),
    );
  }
}
