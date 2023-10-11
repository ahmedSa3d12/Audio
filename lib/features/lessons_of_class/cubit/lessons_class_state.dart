
abstract class LessonsClassState {}

class LessonsClassInitial extends LessonsClassState {}

class LessonsClassLoading extends LessonsClassState {}

class LessonsClassLoaded extends LessonsClassState {}

class LessonsClassError extends LessonsClassState {}

class VideoLessonsLoading extends LessonsClassState {}

class VideoLessonsLoaded extends LessonsClassState {}

class VideoLessonsError extends LessonsClassState {}

class ChangeCurrentIndexTap extends LessonsClassState {}

class ExamLessonsLoading extends LessonsClassState {}

class ExamLessonsLoaded extends LessonsClassState {}

class ExamLessonsError extends LessonsClassState {}

class LessonExamClassesLoaded extends LessonsClassState {}

class LessonsOpenLessonLoading extends LessonsClassState {}

class LessonsOpenLessonLoaded extends LessonsClassState {}

class LessonsOpenLessonError extends LessonsClassState {}

class ErrorAddHomeWorkToFavorite extends LessonsClassState {}

class LoadedAddHomeWorkToFavorite extends LessonsClassState {}
