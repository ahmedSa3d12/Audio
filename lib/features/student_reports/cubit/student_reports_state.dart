part of 'student_reports_cubit.dart';

@immutable
abstract class StudentReportsState {}

class StudentReportsInitial extends StudentReportsState {}
class StudentReportsPageLoaded extends StudentReportsState {}
class StudentReportsPageError extends StudentReportsState {}
class StudentReportsPageLoading extends StudentReportsState {}
