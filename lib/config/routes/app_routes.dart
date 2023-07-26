import 'package:flutter/material.dart';
import 'package:new_mazoon/features/attachment/screens/attachmentscreen.dart';
import 'package:new_mazoon/features/lessons_of_class/screens/lesson_details.dart';
import 'package:new_mazoon/features/navigation_bottom/screens/navigation_bottom.dart';
import 'package:new_mazoon/features/onboarding/screens/onbordingscreen.dart';
import 'package:page_transition/page_transition.dart';

import '../../core/models/ads_model.dart';
import '../../core/models/lessons_model.dart';
import '../../core/models/paper_exam_data_model.dart';
import '../../core/models/paper_exam_details_model.dart';
import '../../core/models/videoModel.dart';
import '../../core/utils/app_strings.dart';
import '../../features/countdown/screens/countdown_screen.dart';
import '../../features/exam_hero/screens/exam_hero_screen.dart';
import '../../features/examinstructions/screen/examinstructions.dart';
import '../../features/lessonExamScreen/screens/lessonexamscreen.dart';
import '../../features/paperexamRegister/presentation/screens/paper_exam_register.dart';
import '../../features/lessons_of_class/screens/lesson_class.dart';
import '../../features/login/screens/login.dart';
import '../../features/monthplan/screen/monthplan.dart';
import '../../features/paperexamdetials/screens/paper_details_exam_register.dart';
import '../../features/sources_and_references/screens/source_references_details.dart';
import '../../features/splash/presentation/screens/pop_ads_screen.dart';
import '../../features/splash/presentation/screens/splash_screen.dart';
import '../../features/video_details/screens/video_details.dart';

class Routes {
  static const String initialRoute = '/';
  static const String loginRoute = '/login';
  static const String paperexamRegisterRoute = '/paperexamRegister';
  static const String paperdetialsexamRegisterRoute =
      '/paperdetailsexamRegister';
  static const String homePageScreenRoute = '/homePageScreen';
  static const String monthplanPageScreenRoute = '/monthplanPageScreen';
  static const String onboardingPageScreenRoute = '/onboardingPageScreen';
  static const String podAdsPageScreenRoute = '/podAdsPageScreen';
  static const String lessonClassScreenRoute = '/lessonClassPageScreen';
  static const String sourceReferencesDetailsRoute = '/sourceReferencesDetails';
  static const String examInstructionsRoute = '/examInstructions';
  static const String examHeroScreenRoute = '/examHeroScreen';
  static const String countdownScreenRoute = '/countdownScreen';
  static const String videoDetailsScreenRoute = '/videoDetailsScreen';

  static const String lessonDetails = '/lessonDetails';

  static const String attachmentScreen = '/AttachmentScreen';

  static const String lessonExamScreen = '/LessonExamScreen';
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
        int classId = settings.arguments as int;
        return MaterialPageRoute(
          builder: (context) => LessonsClassScreen(classId: classId),
        );
      case Routes.examInstructionsRoute:
        List<dynamic> data = settings.arguments as List<dynamic>;
        return MaterialPageRoute(
          builder: (context) =>
              ExamInstructions(exam_id: data[0], type: data[1]),
        );
      case Routes.paperexamRegisterRoute:
        PaperExamDetialsModel timeDataModel =
            settings.arguments as PaperExamDetialsModel;
        return MaterialPageRoute(
          builder: (context) =>
              PaperExmRegisterPage(timeDataModel: timeDataModel),
        );
      case Routes.paperdetialsexamRegisterRoute:
        PaperExam paperExamModel = settings.arguments as PaperExam;

        return MaterialPageRoute(
          builder: (context) =>
              PaperDetailsExmRegisterPage(paperExamModel: paperExamModel),
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
          child: OnBordingScreen(),
        );

      case Routes.sourceReferencesDetailsRoute:
        return PageTransition(
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 300),
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

      case Routes.examHeroScreenRoute:
        return PageTransition(
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 1300),
          child: ExamHeroScreen(),
        );

      case Routes.countdownScreenRoute:
        return PageTransition(
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 800),
          child: CountdownScreen(),
        );
      case Routes.lessonDetails:
        AllLessonsModel model = settings.arguments as AllLessonsModel;
        return PageTransition(
          child: LessonDetails(model: model),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 800),
        );
      case Routes.videoDetailsScreenRoute:
        Map<String, dynamic> data = settings.arguments as Map<String, dynamic>;
        return PageTransition(
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 800),
          child: VideoDetails(type: data['type'], videoId: data['videoId']),
        );
      case Routes.attachmentScreen:
        VideoModel model = settings.arguments as VideoModel;
        return PageTransition(
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 1300),
          child: AttachmentScreen(model: model),
        );
      case Routes.lessonExamScreen:
        Map<String, dynamic> data = settings.arguments as Map<String, dynamic>;

        return PageTransition(
          child: LessonExamScreen(
              exam_type: data['exam_type'], lessonId: data['lessonId']),
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 800),
          type: PageTransitionType.fade,
        );
//AttachmentScreen
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
