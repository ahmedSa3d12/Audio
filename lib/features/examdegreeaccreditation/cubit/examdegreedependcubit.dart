import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_mazoon/core/models/grade_and_rate.dart';

import '../../../core/remote/service.dart';
import 'examdegreedependstate.dart';

class ExamDegreeAccreditationCubit extends Cubit<ExamDegreeAccreditationState> {
  final ServiceApi api;
  ExamDegreeAccreditationCubit(this.api) : super(InitExamDegreeAccreditation());

  int currentIndex = 0;

  selectTap(int index) {
    currentIndex = index;
    emit(ChangeCurrentIndexTap());
  }

  List<GradeAndRateModelData> homeworksGrade = [];
  homeworkGradeAndRate({required int lessonId}) async {
    homeworksGrade = [];
    emit(LoadingGetHomeworkGrade());
    final response = await api.homwworkGradeAndRate(lessonId: lessonId);
    response.fold(
      (l) => emit(ErrorGetHomeworkGrade()),
      (r) {
        homeworksGrade = r.data;
        emit(SuccessGetHomeworkGrade());
      },
    );
  }

  List<GradeAndRateModelData> lessonsExamGrade = [];
  lessonsExamGradeAndRate({required int lessonId}) async {
    lessonsExamGrade = [];
    emit(ErrorGetLessonExamGrade());
    final response = await api.lessonsExamGradeAndRate(lessonId: lessonId);
    response.fold(
      (l) => emit(ErrorGetHomeworkGrade()),
      (r) {
        lessonsExamGrade = r.data;
        emit(SuccessGetLessonExamGrade());
      },
    );
  }

  List<GradeAndRateModelData> classesExamGrade = [];
  classesExamGradeAndRate({required int lessonId}) async {
    classesExamGrade = [];
    emit(LoadingGetClassesExamGrade());
    final response = await api.classesExamGradeAndRate(lessonId: lessonId);
    response.fold(
      (l) => emit(ErrorGetClassesExamGrade()),
      (r) {
        classesExamGrade = r.data;
        emit(SuccessGetClassesExamGrade());
      },
    );
  }

  List<GradeAndRateModelData> comprehensiveExamsGrade = [];
  comprehensiveExamsGradeAndRate() async {
    comprehensiveExamsGrade = [];
    emit(LoadingGetComprehensiveExamsGrade());
    final response = await api.comprehensiveExamsGradeAndRate();
    response.fold(
      (l) => emit(ErrorGetComprehensiveExamsGrade()),
      (r) {
        comprehensiveExamsGrade = r.data;
        emit(SuccessGetComprehensiveExamsGrade());
      },
    );
  }
}
