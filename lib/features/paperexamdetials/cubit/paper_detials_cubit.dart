import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

import '../../../core/remote/service.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/show_dialog.dart';
import '../../../core/utils/toast_message_method.dart';

part 'paper_detials_state.dart';

class PaperDetialsCubit extends Cubit<PaperDetialsState> {
  TextEditingController name = TextEditingController();
  TextEditingController examtime = TextEditingController();
  TextEditingController examPlace = TextEditingController();
  TextEditingController examHall = TextEditingController();

  final ServiceApi api;
  PaperDetialsCubit(this.api) : super(PaperDetialsInitial());
  Future<void> deleteexam(BuildContext context) async {
    createProgressDialog(context, 'wait'.tr());
    var response = await api.deleteregisterExam();
    response.fold(
          (l) =>  Navigator.of(context).pop(),
          (r) {
        Navigator.of(context).pop();
        if(r.code==200){
          toastMessage(
          'exam_cancel_suc'.tr(),
            context,
            color: AppColors.success,
          );
          Navigator.of(context).pop();
          //   Navigator.pushNamed(context, Routes.examRegisterRoute,arguments: data);
        }
        else{
          toastMessage(
            r.message,
            context,
            color: AppColors.error,
          );
        }

      },
    );
  }

}
