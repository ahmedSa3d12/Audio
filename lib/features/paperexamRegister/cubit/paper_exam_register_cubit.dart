import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

import '../../../config/routes/app_routes.dart';
import '../../../core/models/TimeModel.dart';
import '../../../core/models/paper_exam_details_model.dart';
import '../../../core/models/times_model.dart';
import '../../../core/models/user_model.dart';
import '../../../core/preferences/preferences.dart';
import '../../../core/remote/service.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/show_dialog.dart';
import '../../../core/utils/toast_message_method.dart';

part 'paper_exam_register_state.dart';

class PaperExamRegisterCubit extends Cubit<PaperExamRegisterState> {
  TextEditingController studentName = TextEditingController();
  TextEditingController phoneName = TextEditingController();
  TextEditingController studentCode = TextEditingController();
  TextEditingController suggest = TextEditingController();
  Time? dropdownValue;
  List<Time> times=[];
  final ServiceApi api;
  PaperExamRegisterCubit(this.api) : super(PaperExamRegisterInitial()){
    getProfileData();
  }

   UserModel? loginModel;

  getProfileData() async {
    loginModel = await Preferences.instance.getUserModel();
    studentName.text = loginModel!.data!.name;
    studentCode.text = loginModel!.data!.code;
    phoneName.text = loginModel!.data!.phone;
   // suggest.clear();
    //emit(ProfileGetUserData());
  }

  Future<void> openexam(PaperExamDetialsModel timeDataModel,Time dropdownValue,BuildContext context) async {
    createProgressDialog(context, 'wait'.tr());
    var response = await api.registerExam(exma_id: timeDataModel.data!.id,time_id: dropdownValue.id);
    response.fold(
          (l) =>  Navigator.of(context).pop(),
          (r) {
          Navigator.of(context).pop();
        if(r.code==200){
          Navigator.pushNamed(
              context,
              Routes.paperdetialsexamRegisterRoute,

            arguments: r.data!);
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

  void settimevalue(Time? newValue) {
    dropdownValue=newValue;
    emit(PaperExamRegisterInitial());
  }



}
