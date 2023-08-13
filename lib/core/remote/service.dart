import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:new_mazoon/core/models/comment_data_model.dart';
import 'package:new_mazoon/core/models/datesofnotes.dart';
import 'package:new_mazoon/core/models/note_model.dart';
import 'package:new_mazoon/core/models/status_response_model.dart';
import '../../features/login/models/communication_model.dart';
import '../api/base_api_consumer.dart';
import '../api/end_points.dart';
import '../error/exceptions.dart';
import '../error/failures.dart';
import '../models/addnewexamtry.dart';
import '../models/ads_model.dart';
import '../models/applylessonexammodel.dart';
import '../models/audiolessonmodel.dart';
import '../models/class_lesson_model.dart';
import '../models/classes_exam_data_model.dart';
import '../models/dependexam.dart';
import '../models/exam_classes_model.dart';
import '../models/exam_instruction_model.dart';
import '../models/examlessonmodel.dart';
import '../models/grade_and_rate.dart';
import '../models/lessonexammodel.dart';
import '../models/paper_exam_details_model.dart';
import '../models/final_review_model.dart';
import '../models/home_page_model.dart';
import '../models/month_plan_model.dart';
import '../models/lessons_class_model.dart';
import '../models/notifications_model.dart';
import '../models/on_boarding_model.dart';
import '../models/questionmodel.dart';
import '../models/rate_your_self.dart';
import '../models/response_message.dart';
import '../models/single_comment.dart';
import '../models/single_replay.dart';
import '../models/sources_references_model.dart';
import '../models/sources_referenes_by_id_model.dart';
import '../models/times_model.dart';
import '../models/user_model.dart';
import '../models/video_data_model.dart';
import '../models/videolessonmodel.dart';
import '../preferences/preferences.dart';

class ServiceApi {
  final BaseApiConsumer dio;

  ServiceApi(this.dio);

  Future<Either<Failure, UserModel>> postUser(String code) async {
    String lan = await Preferences.instance.getSavedLang();
    try {
      final response = await dio.post(
        EndPoints.userUrl,
        formDataIsEnabled: true,
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

  Future<Either<Failure, NoteDataModel>> getNotes(String date) async {
    UserModel userModel = await Preferences.instance.getUserModel();
    String lan = await Preferences.instance.getSavedLang();
    print('lan : $lan');
    try {
      final response = await dio.get(
        EndPoints.notesUrl,
        queryParameters: {'date': date},
        options: Options(
          headers: {
            'Authorization': userModel.data!.token,
            'Accept-Language': lan
          },
        ),
      );
      return Right(NoteDataModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, DatesOfNotes>> getDatesOfNotes() async {
    UserModel userModel = await Preferences.instance.getUserModel();
    String lan = await Preferences.instance.getSavedLang();
    print('lan : $lan');
    try {
      final response = await dio.get(
        EndPoints.datesOfNotesUrl,
        options: Options(
          headers: {
            'Authorization': userModel.data!.token,
            'Accept-Language': lan
          },
        ),
      );
      return Right(DatesOfNotes.fromJson(response));
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

  Future<Either<Failure, StatusResponseModel>> deleteregisterExam() async {
    UserModel loginModel = await Preferences.instance.getUserModel();
    String lan = await Preferences.instance.getSavedLang();

    try {
      final response = await dio.delete(
        EndPoints.deleteregisterExamUrl,
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

  Future<Either<Failure, PaperExamDetialsModel>> paperExamDetails() async {
    UserModel loginModel = await Preferences.instance.getUserModel();
    String lan = await Preferences.instance.getSavedLang();

    try {
      final response = await dio.get(
        EndPoints.paperExamDetialsUrl,
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
      {required int exma_id, required String type}) async {
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

  Future<Either<Failure, VideoDataModel>> getVideoDetails(
      {required int video_id, required String type}) async {
    UserModel loginModel = await Preferences.instance.getUserModel();
    String lan = await Preferences.instance.getSavedLang();

    try {
      final response = await dio.get(
        EndPoints.videoDetailsUrl + video_id.toString(),
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
      return Right(VideoDataModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, CommentsDataModel>> getcomments(
      {required int video_id, required String type}) async {
    UserModel loginModel = await Preferences.instance.getUserModel();
    String lan = await Preferences.instance.getSavedLang();

    try {
      final response = await dio.get(
        EndPoints.commentsUrl + video_id.toString(),
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
      return Right(CommentsDataModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, StatusResponse>> addToFavourite(
      {required int video_id,
      required String type,
      required String action}) async {
    UserModel loginModel = await Preferences.instance.getUserModel();
    String lan = await Preferences.instance.getSavedLang();

    try {
      final response = await dio.post(
        EndPoints.addremovefavUrl,
        body: {
          "video_basic_id": type == 'video_basic' ? video_id : "",
          "video_resource_id": type == 'video_resource' ? video_id : "",
          "video_part_id": type == 'video_part' ? video_id : "",
          "favorite_type": type,
          "action": action,
        },
        options: Options(
          headers: {
            'Authorization': loginModel.data!.token,
            'Accept-Language': lan
          },
        ),
      );
      return Right(StatusResponse.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, SingleCommentModel>> addComments(
      {required int video_id,
      required String type,
      required String text,
      required String image,
      required String videoType,
      required String audio}) async {
    UserModel loginModel = await Preferences.instance.getUserModel();
    String lan = await Preferences.instance.getSavedLang();
    try {
      print("sssss");
      print(videoType);
      final response = await dio.post(
        EndPoints.addcommentsUrl,
        body: {
          "comment": text,
          "type": type,
          "video_resource_id": videoType == 'video_resource' ? video_id : "",
          "video_basic_id": videoType == 'video_basic' ? video_id : "",
          if (image.isNotEmpty) ...{
            'image': await MultipartFile.fromFile(image),
          },
          if (audio.isNotEmpty) ...{
            'audio': await MultipartFile.fromFile(audio),
          },
        },
        options: Options(
          headers: {
            'Authorization': loginModel.data!.token,
            'Accept-Language': lan
          },
        ),
      );
      return Right(SingleCommentModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, SingleCommentModel>> editComments(
      {required int comment_id,
      required String type,
      required String text}) async {
    UserModel loginModel = await Preferences.instance.getUserModel();
    String lan = await Preferences.instance.getSavedLang();

    try {
      final response = await dio.post(
        EndPoints.editcommentUrl + comment_id.toString(),
        formDataIsEnabled: true,
        body: {
          "comment": text,
          "type": type,
        },
        options: Options(
          headers: {
            'Authorization': loginModel.data!.token,
            'Accept-Language': lan
          },
        ),
      );
      return Right(SingleCommentModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, SingleReplayModel>> editReplay(
      {required int comment_id,
      required String type,
      required String text}) async {
    UserModel loginModel = await Preferences.instance.getUserModel();
    String lan = await Preferences.instance.getSavedLang();

    try {
      final response = await dio.post(
        EndPoints.editReplayUrl + comment_id.toString(),
        formDataIsEnabled: true,
        body: {
          "comment": text,
          "type": type,
        },
        options: Options(
          headers: {
            'Authorization': loginModel.data!.token,
            'Accept-Language': lan
          },
        ),
      );
      return Right(SingleReplayModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, StatusResponse>> delecomment(
      {required int commnet_id}) async {
    UserModel loginModel = await Preferences.instance.getUserModel();
    String lan = await Preferences.instance.getSavedLang();

    try {
      final response = await dio.delete(
        EndPoints.deletecommentUrl + commnet_id.toString(),
        options: Options(
          headers: {
            'Authorization': loginModel.data!.token,
            'Accept-Language': lan
          },
        ),
      );
      return Right(StatusResponse.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, StatusResponse>> addreport(
      {required int video_id,
      required String comment,
      required String type}) async {
    UserModel loginModel = await Preferences.instance.getUserModel();
    String lan = await Preferences.instance.getSavedLang();

    try {
      final response = await dio.post(
        EndPoints.reportUrl,
        body: {
          "type": type,
          "report": comment,
          "video_basic_id": type == 'video_basic' ? video_id : '',
          "video_resource_id": type == 'video_resource' ? video_id : '',
          "video_part_id": type == 'video_part' ? video_id : '',
        },
        options: Options(
          headers: {
            'Authorization': loginModel.data!.token,
            'Accept-Language': lan
          },
        ),
      );
      return Right(StatusResponse.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, StatusResponse>> updateVideoTime(
      {required int video_id, required String minutes}) async {
    UserModel loginModel = await Preferences.instance.getUserModel();
    String lan = await Preferences.instance.getSavedLang();

    try {
      final response = await dio.post(
        EndPoints.updateVideoTimeUrl + video_id.toString(),
        body: {
          "minutes": minutes,
        },
        options: Options(
          headers: {
            'Authorization': loginModel.data!.token,
            'Accept-Language': lan
          },
        ),
      );
      return Right(StatusResponse.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, StatusResponse>> delereplay(
      {required int replay_id}) async {
    UserModel loginModel = await Preferences.instance.getUserModel();
    String lan = await Preferences.instance.getSavedLang();

    try {
      final response = await dio.delete(
        EndPoints.deletereplayUrl + replay_id.toString(),
        options: Options(
          headers: {
            'Authorization': loginModel.data!.token,
            'Accept-Language': lan
          },
        ),
      );
      return Right(StatusResponse.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, SingleReplayModel>> addreplay(
      {required int comment_id,
      required String type,
      required String text,
      required String image,
      required String audio}) async {
    UserModel loginModel = await Preferences.instance.getUserModel();
    String lan = await Preferences.instance.getSavedLang();

    try {
      final response = await dio.post(
        EndPoints.addreplayUrl + comment_id.toString(),
        formDataIsEnabled: true,
        body: {
          "replay": text,
          "type": type,
          if (image.isNotEmpty) ...{
            'image': await MultipartFile.fromFile(image),
          },
          if (audio.isNotEmpty) ...{
            'audio': await MultipartFile.fromFile(audio),
          },
        },
        options: Options(
          headers: {
            'Authorization': loginModel.data!.token,
            'Accept-Language': lan
          },
        ),
      );
      return Right(SingleReplayModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, VideosofLessonModel>> videosOfLessonData(
      int lessonId) async {
    print("sssss");
    print(lessonId);
    UserModel loginModel = await Preferences.instance.getUserModel();
    String lan = await Preferences.instance.getSavedLang();
    try {
      final response = await dio.get(
        EndPoints.VideoByLessonUrl + "$lessonId",
        options: Options(
          headers: {
            'Authorization': loginModel.data!.token,
            'Accept-Language': lan
          },
        ),
      );
      return Right(VideosofLessonModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, LessonExamModel>> examOfLessonData(
      int lessonId) async {
    print("sssss");
    print(lessonId);
    UserModel loginModel = await Preferences.instance.getUserModel();
    String lan = await Preferences.instance.getSavedLang();
    try {
      final response = await dio.get(
        EndPoints.ExamByLessonUrl + "$lessonId",
        options: Options(
          headers: {
            'Authorization': loginModel.data!.token,
            'Accept-Language': lan
          },
        ),
      );
      return Right(LessonExamModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, AudioLessonModel>> audioOfLessonData(
      int lessonId) async {
    print("sssss");
    print(lessonId);
    UserModel loginModel = await Preferences.instance.getUserModel();
    String lan = await Preferences.instance.getSavedLang();
    try {
      final response = await dio.get(
        EndPoints.AudioOfLesson + "$lessonId",
        options: Options(
          headers: {
            'Authorization': loginModel.data!.token,
            'Accept-Language': lan
          },
        ),
      );
      return Right(AudioLessonModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, AudioLessonModel>> pdfOfLessonData(
      int lessonId) async {
    print("sssss");
    print(lessonId);
    UserModel loginModel = await Preferences.instance.getUserModel();
    String lan = await Preferences.instance.getSavedLang();
    try {
      final response = await dio.get(
        EndPoints.PdfOfLesson + "$lessonId",
        options: Options(
          headers: {
            'Authorization': loginModel.data!.token,
            'Accept-Language': lan
          },
        ),
      );
      return Right(AudioLessonModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, LessonExamModel2>> homeworkOfLessonData(
      int lessonId) async {
    print("sssss");
    print(lessonId);
    UserModel loginModel = await Preferences.instance.getUserModel();
    String lan = await Preferences.instance.getSavedLang();
    try {
      final response = await dio.get(
        EndPoints.homeworkOfLesson + "$lessonId",
        options: Options(
          headers: {
            'Authorization': loginModel.data!.token,
            'Accept-Language': lan
          },
        ),
      );
      return Right(LessonExamModel2.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, MainQuestionModel>> getQuestionsOfLessonExam(
      int lessonId, String exam_type) async {
    print("sssss");
    print(lessonId);
    UserModel loginModel = await Preferences.instance.getUserModel();
    String lan = await Preferences.instance.getSavedLang();
    try {
      final response = await dio.get(
        EndPoints.examsOflesson + "$lessonId?exam_type=$exam_type",
        options: Options(
          headers: {
            'Authorization': loginModel.data!.token,
            'Accept-Language': lan
          },
        ),
      );
      return Right(MainQuestionModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, ResponseOfApplyLessonExmam>> applyLessonExam(
      {required List<ApplyStudentExam> details,
      required String exam_type,
      required int lessonId}) async {
    UserModel loginModel = await Preferences.instance.getUserModel();
    String lan = await Preferences.instance.getSavedLang();
    try {
      Map<String, dynamic> requestBody = {};

      for (int i = 0; i < details.length; i++) {
        requestBody.addAll(details[i].toJson(i));
      }
      print("ahmed");
      print(requestBody);
      print("ahmed");
      final response = await dio.post(
        EndPoints.applyLessonExam + '$lessonId?exam_type=$exam_type',
        formDataIsEnabled: true,
        body: requestBody,
        options: Options(
          headers: {
            'Authorization': loginModel.data!.token,
            'Accept-Language': lan
          },
        ),
      );
      return Right(ResponseOfApplyLessonExmam.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  ///rateYourSelf
  Future<Either<Failure, RateYourselfModel>> rateYourSelfLessonExam(
      {required int lessonId}) async {
    UserModel loginModel = await Preferences.instance.getUserModel();
    String lan = await Preferences.instance.getSavedLang();
    try {
      final response = await dio.get(
        EndPoints.rateYourSelf + '$lessonId',
        options: Options(
          headers: {
            'Authorization': loginModel.data!.token,
            'Accept-Language': lan
          },
        ),
      );
      print(loginModel.data!.token);
      print('..............');

      return Right(RateYourselfModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  //
  Future<Either<Failure, AppendLessonExam>> appendDegreeLessonExam(
      {required int lessonId, required String exam_type}) async {
    UserModel loginModel = await Preferences.instance.getUserModel();
    String lan = await Preferences.instance.getSavedLang();
    try {
      final response = await dio.get(
        EndPoints.dependLessonExam + '$lessonId?exam_type=$exam_type',
        options: Options(
          headers: {
            'Authorization': loginModel.data!.token,
            'Accept-Language': lan
          },
        ),
      );
      print(loginModel.data!.token);
      print('..............');

      return Right(AppendLessonExam.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }
  //tryAtEndOfExam

  Future<Either<Failure, AddNewTryExam>> tryAtEndOfExam(
      {required int lessonId, required String type, required int time}) async {
    UserModel loginModel = await Preferences.instance.getUserModel();
    String lan = await Preferences.instance.getSavedLang();
    try {
      final response = await dio.post(
        EndPoints.tryAtEndOfExam + '$lessonId?type=$type&timer=$time',
        options: Options(
          headers: {
            'Authorization': loginModel.data!.token,
            'Accept-Language': lan
          },
        ),
      );
      return Right(AddNewTryExam.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  //GradeAndRateModel
  Future<Either<Failure, GradeAndRateModel>> homwworkGradeAndRate(
      {required int lessonId}) async {
    UserModel loginModel = await Preferences.instance.getUserModel();
    String lan = await Preferences.instance.getSavedLang();
    try {
      final response = await dio.get(
        EndPoints.homeworkGrade + '$lessonId',
        options: Options(
          headers: {
            'Authorization': loginModel.data!.token,
            'Accept-Language': lan
          },
        ),
      );
      print(loginModel.data!.token);
      print('..............');

      return Right(GradeAndRateModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, GradeAndRateModel>> lessonsExamGradeAndRate(
      {required int lessonId}) async {
    UserModel loginModel = await Preferences.instance.getUserModel();
    String lan = await Preferences.instance.getSavedLang();
    try {
      final response = await dio.get(
        EndPoints.lessonsExamGrade + '$lessonId',
        options: Options(
          headers: {
            'Authorization': loginModel.data!.token,
            'Accept-Language': lan
          },
        ),
      );
      print(loginModel.data!.token);
      print('..............');

      return Right(GradeAndRateModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, GradeAndRateModel>> classesExamGradeAndRate(
      {required int classId}) async {
    UserModel loginModel = await Preferences.instance.getUserModel();
    String lan = await Preferences.instance.getSavedLang();
    try {
      final response = await dio.get(
        EndPoints.classesExamsGrade + '$classId',
        options: Options(
          headers: {
            'Authorization': loginModel.data!.token,
            'Accept-Language': lan
          },
        ),
      );
      print(loginModel.data!.token);
      print('..............');

      return Right(GradeAndRateModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, GradeAndRateModel>>
      comprehensiveExamsGradeAndRate() async {
    UserModel loginModel = await Preferences.instance.getUserModel();
    String lan = await Preferences.instance.getSavedLang();
    try {
      final response = await dio.get(
        EndPoints.comprehensiveExamGrade,
        options: Options(
          headers: {
            'Authorization': loginModel.data!.token,
            'Accept-Language': lan
          },
        ),
      );
      print(loginModel.data!.token);
      print('..............');

      return Right(GradeAndRateModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
