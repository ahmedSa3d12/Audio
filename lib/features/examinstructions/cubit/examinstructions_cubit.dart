import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

import '../../../core/models/exam_instruction_model.dart';
import '../../../core/remote/service.dart';

part 'examinstructions_state.dart';

class ExaminstructionsCubit extends Cubit<ExaminstructionsState> {
  final ServiceApi api;
  ExaminstructionsCubit(this.api) : super(ExaminstructionsInitial());
  Future<void> examInstructions(int exam_id, String type) async {
    emit(ExaminstructionsLoading());
    var response = await api.examInstructions(exma_id: exam_id, type: type);
    response.fold(
      (l) => emit(ExaminstructionsError()),
      (r) {
        emit(ExaminstructionsLoaded(r));
      },
    );
  }
}
