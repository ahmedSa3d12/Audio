import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:new_mazoon/core/remote/service.dart';

import '../../../core/models/class_data.dart';
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
}
