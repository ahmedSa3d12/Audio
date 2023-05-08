part of 'examinstructions_cubit.dart';

@immutable
abstract class ExaminstructionsState {}

class ExaminstructionsInitial extends ExaminstructionsState {}
class ExaminstructionsLoaded extends ExaminstructionsState {
  final ExamInstructionModel examInstructionModel;

  ExaminstructionsLoaded(this.examInstructionModel);
}
class ExaminstructionsError extends ExaminstructionsState {}
class ExaminstructionsLoading extends ExaminstructionsState {}

