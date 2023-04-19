import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../features/login/models/communication_model.dart';
import '../api/base_api_consumer.dart';
import '../api/end_points.dart';
import '../error/exceptions.dart';
import '../error/failures.dart';
import '../models/ads_model.dart';
import '../models/class_lesson_model.dart';
import '../models/exam_classes_model.dart';
import '../models/final_review_model.dart';
import '../models/home_page_model.dart';
import '../models/on_boarding_model.dart';
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
}
