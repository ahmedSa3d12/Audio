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

  GradeAndRateModelData? homeworksGrade;
  homeworkGradeAndRate({required int lessonId}) async {
    if (homeworksGrade != null) {
      homeworksGrade!.degrees = [];
    }
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

  GradeAndRateModelData? lessonsExamGrade;
  lessonsExamGradeAndRate({required int lessonId}) async {
    if (lessonsExamGrade != null) {
      lessonsExamGrade!.degrees = [];
    }
    emit(LoadingGetLessonExamGrade());
    final response = await api.lessonsExamGradeAndRate(lessonId: lessonId);
    response.fold(
      (l) => emit(ErrorGetLessonExamGrade()),
      (r) {
        lessonsExamGrade = r.data;
        emit(SuccessGetLessonExamGrade());
      },
    );
  }

  GradeAndRateModelData? classesExamGrade;
  classesExamGradeAndRate({required int classId}) async {
    if (classesExamGrade != null) {
      classesExamGrade!.degrees = [];
    }
    emit(LoadingGetClassesExamGrade());
    final response = await api.classesExamGradeAndRate(classId: classId);
    response.fold(
      (l) => emit(ErrorGetClassesExamGrade()),
      (r) {
        classesExamGrade = r.data;
        emit(SuccessGetClassesExamGrade());
      },
    );
  }

  GradeAndRateModelData? comprehensiveExamsGrade;
  comprehensiveExamsGradeAndRate() async {
    if (comprehensiveExamsGrade != null) {
      comprehensiveExamsGrade!.degrees = [];
    }
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
