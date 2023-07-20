part of 'lessons_class_cubit.dart';

@immutable
abstract class LessonsClassState {}

class LessonsClassInitial extends LessonsClassState {}

class LessonsClassLoading extends LessonsClassState {}

class LessonsClassLoaded extends LessonsClassState {}

class LessonsClassError extends LessonsClassState {}

class VideoLessonsLoading extends LessonsClassState {}

class VideoLessonsLoaded extends LessonsClassState {}

class VideoLessonsError extends LessonsClassState {}

class ChangeCurrentIndexTap extends LessonsClassState {}
