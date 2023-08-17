import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_mazoon/core/models/grade_and_rate.dart';

import '../../../core/remote/service.dart';
import 'examdegreedependstate.dart';

class ExamDegreeAccreditationCubit extends Cubit<ExamDegreeAccreditationState> {
  final ServiceApi api;
  ExamDegreeAccreditationCubit(this.api) : super(InitExamDegreeAccreditation());
int lessonHomeid=0;
int lessonsExamGradeid=0;
int classid=0;
  int currentIndex = 0;

  selectTap(int index) {
    currentIndex = index;
    emit(ChangeCurrentIndexTap());
  }

  GradeAndRateModelData? homeworksGrade=GradeAndRateModelData();

  homeworkGradeAndRate({required int lessonId}) async {
    this.lessonHomeid=lessonId;
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

  GradeAndRateModelData?  lessonsExamGrade=GradeAndRateModelData();
  lessonsExamGradeAndRate({required int lessonId}) async {
    this.lessonsExamGradeid=lessonId;

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

  GradeAndRateModelData?classesExamGrade=GradeAndRateModelData();
  classesExamGradeAndRate({required int classId}) async {
this.classid=classId;
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

  GradeAndRateModelData?  comprehensiveExamsGrade=GradeAndRateModelData();
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

  void setlesson() {
    lessonsExamGrade!.degrees = [];
    emit(SuccessGetLessonExamGrade());

  }

  void setHomeGrade() {
    homeworksGrade!.degrees = [];
    emit(SuccessGetHomeworkGrade());

  }
}
