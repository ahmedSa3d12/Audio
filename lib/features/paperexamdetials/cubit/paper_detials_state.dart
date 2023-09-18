part of 'paper_detials_cubit.dart';

@immutable
abstract class PaperDetialsState {}

class PaperDetialsInitial extends PaperDetialsState {}

class LoadingDeletePaperDetialsInitial extends PaperDetialsState {}

class LoadedDeletePaperDetialsInitial extends PaperDetialsState {}

class ErrorDeletePaperDetialsInitial extends PaperDetialsState {}
