import 'package:flutter/material.dart';

import '../../core/models/exam_answer_model.dart';
import '../../core/models/exam_model.dart';
import '../../core/models/lessons_details_model.dart';
import '../../core/models/month_plan_model.dart';
import '../../core/utils/app_strings.dart';
import '../../features/login/screens/login.dart';
import '../../features/splash/presentation/screens/splash_screen.dart';

class Routes {
  static const String initialRoute = '/';
  static const String loginRoute = '/login';
  static const String myDegreeRoute = '/mydegree';
  static const String examRegisterRoute = '/examregister';
  static const String verificationScreenRoute = '/verificationScreen';
  static const String homePageScreenRoute = '/homePageScreen';
  static const String paymentRoute = '/paymentRoute';
  static const String suggestRoute = '/suggestRoute';
  static const String examRoute = '/examRoute';
  static const String examdegreeDetialsRoute = '/examdegreeDetialsRoute';
  static const String monthplansRoute = '/monthplansRoute';
  static const String monthplanDetialsRoute = '/monthplandetialsRoute';
  static const String confirmexamRegisterRoute = '/confirmexamregister';
  static const String downloadsRoute = '/downloads';
  static const String downloadvideoplayRoute = '/downloadvideoplay';
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
