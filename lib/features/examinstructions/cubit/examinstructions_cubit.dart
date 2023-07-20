import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

import '../../../config/routes/app_routes.dart';
import '../../../core/models/exam_instruction_model.dart';
import '../../../core/remote/service.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/show_dialog.dart';
import '../../../core/utils/toast_message_method.dart';

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

        // else{
        //   toastMessage(
        //     r.message,
        //     context,
        //     color: AppColors.error,
        //   );
        // }
      },
    );
  }
}
