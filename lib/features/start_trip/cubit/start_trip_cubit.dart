import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:new_mazoon/core/remote/service.dart';
import 'package:path_provider/path_provider.dart';

import '../../../core/models/class_data.dart';
import '../../../core/models/classes_exam_data_model.dart';
import '../../../core/models/exam_classes_model.dart';
import '../../../core/models/home_page_model.dart';

part 'start_trip_state.dart';

class StartTripCubit extends Cubit<StartTripState> {
  StartTripCubit(this.api) : super(StartTripInitial()) {
    getExplanationData();
    getFinalReviewData();
    getExamClassesData();
  }

  final ServiceApi api;

  List<AllClasses> classesData = [];
  List<FinalReviewModel> finalReview = [];
  List<ExamClassesDatum> examClasses = [];
  List<ClassesExamDatumModel> examClassList = [];
  int currentIndex = 0;

  selectTap(int index) {
    currentIndex = index;
    emit(ChangeCurrentIndexTap());
  }

  getExplanationData() async {
    emit(StartTripExplanationLoading());
    final response = await api.StartTripExplanationData();
    response.fold(
      (l) => emit(StartTripExplanationError()),
      (r) {
        classesData = r.data!;
        emit(StartTripExplanationLoaded());
      },
    );
  }

  getFinalReviewData() async {
    emit(StartTripFinalReviewLoading());
    final response = await api.StartTripFinalReviewData();
    response.fold(
      (l) => emit(StartTripFinalReviewError()),
      (r) {
        finalReview = r.data!;
        emit(StartTripFinalReviewLoaded());
      },
    );
  }

  getExamClassesData() async {
    emit(StartTripExamClassesLoading());
    final response = await api.StartTripExamClassesData();
    response.fold(
      (l) => emit(StartTripExamClassesError()),
      (r) {
        examClasses = r.data!;
        emit(StartTripExamClassesLoaded());
      },
    );
  }

  getExamsClassByIdData(int id) async {
    examClassList = [];
    emit(StartTripExamsClassByIdLoading());
    final response = await api.StartTripExamsClassByIdData(id);
    response.fold(
      (l) => emit(StartTripExamsClassByIdError()),
      (r) {
        examClassList = r.data;
        emit(StartTripExamsClassByIdLoaded());
      },
    );
  }
  dowanload(FinalReviewModel model) async {
    int index=finalReview.indexOf(model);
    final dio = Dio();

    var dir = await (Platform.isIOS
        ? getApplicationSupportDirectory()
        : getApplicationDocumentsDirectory());
    await dio.download(
      model!.pathFile!,
      dir.path + "/pdf/" + model!.pathFile!.split("/").toList().last,
      onReceiveProgress: (count, total) {
        model.progress = (count / total);
        // print(progress);
        finalReview.removeAt(index);
        finalReview.insert(index, model);
        emit(StartTripFinalReviewLoaded());
      },
    ).whenComplete(
          () {
            model.progress = 0;
            // print(progress);
            finalReview.removeAt(index);
            finalReview.insert(index, model);
            emit(StartTripFinalReviewLoaded());
        // progress = 0;
        // emit(VideoDetailsLoaded());
      },
    );
  }



}
