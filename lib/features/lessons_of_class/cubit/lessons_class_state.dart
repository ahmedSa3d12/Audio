part of 'lessons_class_cubit.dart';

@immutable
abstract class LessonsClassState {}

class LessonsClassInitial extends LessonsClassState {}


class LessonsClassLoading extends LessonsClassState {}
class LessonsClassLoaded extends LessonsClassState {}
class LessonsClassError extends LessonsClassState {}
