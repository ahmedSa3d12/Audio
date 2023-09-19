import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../config/routes/app_routes.dart';
import '../../../core/remote/service.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/show_dialog.dart';
import '../../../core/utils/toast_message_method.dart';
import '../../navigation_bottom/cubit/navigation_cubit.dart';

part 'paper_detials_state.dart';

class PaperDetialsCubit extends Cubit<PaperDetialsState> {
  TextEditingController name = TextEditingController();
  TextEditingController examtime = TextEditingController();
  TextEditingController examPlace = TextEditingController();
  TextEditingController examHall = TextEditingController();

  final ServiceApi api;
  PaperDetialsCubit(this.api) : super(PaperDetialsInitial());
  Future<void> deleteexam(BuildContext context) async {
    emit(LoadingDeletePaperDetialsInitial());
    // createProgressDialog(context, 'wait'.tr());
    var response = await api.deleteregisterExam();
    response.fold(
      (l) {
        Navigator.of(context).pop();
        emit(ErrorDeletePaperDetialsInitial());
      },
      (r) {
        if (r.code == 200) {
          toastMessage('exam_cancel_suc'.tr(), context,
              color: AppColors.success);
          Navigator.pop(context);
          // Navigator.pop(context);
        } else {
          Navigator.pop(context);
          toastMessage(
            r.message,
            context,
            color: AppColors.error,
          );
        }
        emit(LoadedDeletePaperDetialsInitial());
      },
    );
  }
}
