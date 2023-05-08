import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../features/login/models/communication_model.dart';
import '../api/base_api_consumer.dart';
import '../api/end_points.dart';
import '../error/exceptions.dart';
import '../error/failures.dart';
import '../models/ads_model.dart';
import '../models/class_lesson_model.dart';
import '../models/classes_exam_data_model.dart';
import '../models/exam_classes_model.dart';
import '../models/exam_instruction_model.dart';
import '../models/paper_exam_details_model.dart';
import '../models/paper_exam_model.dart';
import '../models/final_review_model.dart';
import '../models/home_page_model.dart';
import '../models/month_plan_model.dart';
import '../models/lessons_class_model.dart';
import '../models/notifications_model.dart';
import '../models/on_boarding_model.dart';
import '../models/response_message.dart';
import '../models/sources_references_model.dart';
import '../models/sources_referenes_by_id_model.dart';
import '../models/times_model.dart';
import '../models/user_model.dart';
import '../preferences/preferences.dart';

class ServiceApi {
  final BaseApiConsumer dio;

  ServiceApi(this.dio);

  Future<Either<Failure, UserModel>> postUser(String code) async {
    String lan = await Preferences.instance.getSavedLang();
    try {
      final response = await dio.post(
        EndPoints.userUrl,
        body: {
          'code': code,
        },
        options: Options(
          headers: {'Accept-Language': lan},
        ),
      );
      print(response);
      return Right(UserModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, HomePageModel>> getHomePageData() async {
    UserModel loginModel = await Preferences.instance.getUserModel();
    String lan = await Preferences.instance.getSavedLang();
    try {
      final response = await dio.get(
        EndPoints.homePageUrl,
        options: Options(headers: {
          'Authorization': loginModel.data!.token,
          'Accept-Language': lan
        }),
      );
      return Right(HomePageModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, CommunicationModel>> getCommunicationData() async {
    try {
      final response = await dio.get(EndPoints.communicationUrl);
      return Right(CommunicationModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, AdsModel>> getAppAds() async {
    UserModel loginModel = await Preferences.instance.getUserModel();
    String lan = await Preferences.instance.getSavedLang();
    try {
      final response = await dio.get(
        EndPoints.adsUrl,
        options: Options(
          headers: {
            'Authorization': loginModel.data!.token,
            'Accept-Language': lan
          },
        ),
      );
      return Right(AdsModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, OnBoardingModel>> onBoardingData() async {
    String lan = await Preferences.instance.getSavedLang();
    try {
      final response = await dio.get(
        EndPoints.onBoardingUrl,
        options: Options(
          headers: {'Accept-Language': lan},
        ),
      );
      return Right(OnBoardingModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, ClassLessonModel>> StartTripExplanationData() async {
    UserModel loginModel = await Preferences.instance.getUserModel();
    String lan = await Preferences.instance.getSavedLang();
    try {
      final response = await dio.get(
        EndPoints.explanationUrl,
        options: Options(
          headers: {
            'Authorization': loginModel.data!.token,
            'Accept-Language': lan
          },
        ),
      );
      return Right(ClassLessonModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, StartTripFinalReviewModel>>
      StartTripFinalReviewData() async {
    UserModel loginModel = await Preferences.instance.getUserModel();
    String lan = await Preferences.instance.getSavedLang();
    try {
      final response = await dio.get(
        EndPoints.finalReviewUrl,
        options: Options(
          headers: {
            'Authorization': loginModel.data!.token,
            'Accept-Language': lan
          },
        ),
      );
      return Right(StartTripFinalReviewModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, StartTripExamClassesModel>>
      StartTripExamClassesData() async {
    UserModel loginModel = await Preferences.instance.getUserModel();
    String lan = await Preferences.instance.getSavedLang();
    try {
      final response = await dio.get(
        EndPoints.examClassesUrl,
        options: Options(
          headers: {
            'Authorization': loginModel.data!.token,
            'Accept-Language': lan
          },
        ),
      );
      return Right(StartTripExamClassesModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, StartTripExamClassesModel>>
      StartTripAllExamClassesData() async {
    UserModel loginModel = await Preferences.instance.getUserModel();
    String lan = await Preferences.instance.getSavedLang();
    try {
      final response = await dio.get(
        EndPoints.allExamClassesUrl,
        options: Options(
          headers: {
            'Authorization': loginModel.data!.token,
            'Accept-Language': lan
          },
        ),
      );
      return Right(StartTripExamClassesModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, ClassesExamDataModel>> StartTripExamsClassByIdData(
      int id) async {
    UserModel loginModel = await Preferences.instance.getUserModel();
    String lan = await Preferences.instance.getSavedLang();
    try {
      final response = await dio.get(
        EndPoints.examsClassByIdUrl + id.toString(),
        options: Options(
          headers: {
            'Authorization': loginModel.data!.token,
            'Accept-Language': lan
          },
        ),
      );
      return Right(ClassesExamDataModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, TimeDataModel>> gettimes() async {
    UserModel userModel = await Preferences.instance.getUserModel();
    String lan = await Preferences.instance.getSavedLang();
    try {
      final response = await dio.get(
        EndPoints.timesUrl,
        options: Options(
          headers: {
            'Authorization': userModel.data!.token,
            'Accept-Language': lan
          },
        ),
      );
      return Right(TimeDataModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, NotificationsModel>> getAllNotification() async {
    UserModel userModel = await Preferences.instance.getUserModel();
    String lan = await Preferences.instance.getSavedLang();
    print('lan : $lan');
    try {
      final response = await dio.get(
        EndPoints.notificationUrl,
        options: Options(
          headers: {
            'Authorization': userModel.data!.token,
            'Accept-Language': lan
          },
        ),
      );
      return Right(NotificationsModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, MothPlanModel>> getMonthPlans(String date) async {
    UserModel userModel = await Preferences.instance.getUserModel();
    String lan = await Preferences.instance.getSavedLang();
    print('lan : $lan');
    try {
      final response = await dio.get(
        EndPoints.monthPlanUrl,
        queryParameters: {'date': date},
        options: Options(
          headers: {
            'Authorization': userModel.data!.token,
            'Accept-Language': lan
          },
        ),
      );
      return Right(MothPlanModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, LessonsClassModel>> lessonsByClassData(int id) async {
    UserModel loginModel = await Preferences.instance.getUserModel();
    String lan = await Preferences.instance.getSavedLang();
    try {
      final response = await dio.get(
        EndPoints.lessonsByClassUrl + id.toString(),
        options: Options(
          headers: {
            'Authorization': loginModel.data!.token,
            'Accept-Language': lan
          },
        ),
      );
      return Right(LessonsClassModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }


  Future<Either<Failure, PaperExamDetialsModel>> registerExam(
      {required int exma_id, required int time_id}) async {
    UserModel loginModel = await Preferences.instance.getUserModel();
    String lan = await Preferences.instance.getSavedLang();

    try {
      final response = await dio.post(
        EndPoints.registerExamUrl + exma_id.toString(),
        body: {
          'papel_sheet_exam_time_id': time_id,
        },
        options: Options(
          headers: {
            'Authorization': loginModel.data!.token,
            'Accept-Language': lan
          },
        ),
      );
      return Right(PaperExamDetialsModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }
  Future<Either<Failure, StatusResponseModel>> deleteregisterExam(
      ) async {
    UserModel loginModel = await Preferences.instance.getUserModel();
    String lan = await Preferences.instance.getSavedLang();

    try {
      final response = await dio.delete(
        EndPoints.deleteregisterExamUrl ,

        options: Options(
          headers: {
            'Authorization': loginModel.data!.token,
            'Accept-Language': lan
          },
        ),
      );
      return Right(StatusResponseModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }
 Future<Either<Failure, PaperExamDetialsModel>> paperExamDetails(
      ) async {
    UserModel loginModel = await Preferences.instance.getUserModel();
    String lan = await Preferences.instance.getSavedLang();

    try {
      final response = await dio.get(
        EndPoints.paperExamDetialsUrl ,

        options: Options(
          headers: {
            'Authorization': loginModel.data!.token,
            'Accept-Language': lan
          },
        ),
      );
      //print("dldlld");
     // print(response);
      return Right(PaperExamDetialsModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, SourcesReferencesModel>>
      sourcesAndReferencesData() async {
    UserModel loginModel = await Preferences.instance.getUserModel();
    String lan = await Preferences.instance.getSavedLang();
    try {
      final response = await dio.get(
        EndPoints.sourcesReferencesUrl,
        options: Options(
          headers: {
            'Authorization': loginModel.data!.token,
            'Accept-Language': lan
          },
        ),
      );
      return Right(SourcesReferencesModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, SourcesReferencesByIdModel>>
      sourcesAndReferencesByIdData(int referenceId, int classId) async {
    UserModel loginModel = await Preferences.instance.getUserModel();
    String lan = await Preferences.instance.getSavedLang();
    try {
      final response = await dio.get(
        '${EndPoints.sourcesReferencesByIdUrl}$referenceId/$classId',
        options: Options(
          headers: {
            'Authorization': loginModel.data!.token,
            'Accept-Language': lan
          },
        ),
      );
      return Right(SourcesReferencesByIdModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, ExamInstructionModel>> examInstructions(
      {required int exma_id,required String type}) async {
    UserModel loginModel = await Preferences.instance.getUserModel();
    String lan = await Preferences.instance.getSavedLang();

    try {
      final response = await dio.get(
        EndPoints.examInstructionsUrl + exma_id.toString(),
        queryParameters: {
          'type': type,
        },
        options: Options(
          headers: {
            'Authorization': loginModel.data!.token,
            'Accept-Language': lan
          },
        ),
      );
      return Right(ExamInstructionModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

}
