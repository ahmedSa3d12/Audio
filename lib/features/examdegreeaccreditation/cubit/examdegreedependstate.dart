abstract class ExamDegreeAccreditationState {}

class InitExamDegreeAccreditation extends ExamDegreeAccreditationState {}

class ChangeCurrentIndexTap extends ExamDegreeAccreditationState {}

class loadingGetHomeworksExamDegreeAccreditation
    extends ExamDegreeAccreditationState {}

class LoadingGetHomeworkGrade extends ExamDegreeAccreditationState {}

class SuccessGetHomeworkGrade extends ExamDegreeAccreditationState {}

class ErrorGetHomeworkGrade extends ExamDegreeAccreditationState {}

//

class LoadingGetLessonExamGrade extends ExamDegreeAccreditationState {}

class SuccessGetLessonExamGrade extends ExamDegreeAccreditationState {}

class ErrorGetLessonExamGrade extends ExamDegreeAccreditationState {}

///

class LoadingGetClassesExamGrade extends ExamDegreeAccreditationState {}

class SuccessGetClassesExamGrade extends ExamDegreeAccreditationState {}

class ErrorGetClassesExamGrade extends ExamDegreeAccreditationState {}

class LoadingGetComprehensiveExamsGrade extends ExamDegreeAccreditationState {}

class SuccessGetComprehensiveExamsGrade extends ExamDegreeAccreditationState {}

class ErrorGetComprehensiveExamsGrade extends ExamDegreeAccreditationState {}
