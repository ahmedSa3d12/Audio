part of 'paper_exam_register_cubit.dart';

@immutable
abstract class PaperExamRegisterState {}

class PaperExamRegisterInitial extends PaperExamRegisterState {}

class LoaadingPaperExamRegisterInitial extends PaperExamRegisterState {}

class LoaadedPaperExamRegisterInitial extends PaperExamRegisterState {}

class ErrorPaperExamRegisterInitial extends PaperExamRegisterState {}
