import 'package:bloc/bloc.dart';

import 'package:flutter/material.dart';
import 'package:new_mazoon/features/paperexamdetials/screens/paper_details_exam_register.dart';

import '../../../core/models/TimeModel.dart';
import '../../../core/models/paper_exam_details_model.dart';
import '../../../core/models/user_model.dart';
import '../../../core/preferences/preferences.dart';
import '../../../core/remote/service.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/toast_message_method.dart';

part 'paper_exam_register_state.dart';

class PaperExamRegisterCubit extends Cubit<PaperExamRegisterState> {
  TextEditingController studentName = TextEditingController();
  TextEditingController phoneName = TextEditingController();
  TextEditingController studentCode = TextEditingController();
  TextEditingController suggest = TextEditingController();
  Time? dropdownValue;
  List<Time> times = [];
  final ServiceApi api;
  PaperExamRegisterCubit(this.api) : super(PaperExamRegisterInitial()) {
    getProfileData();
  }

  UserModel? loginModel;

  getProfileData() async {
    loginModel = await Preferences.instance.getUserModel();
    studentName.text = loginModel!.data!.name;
    studentCode.text = loginModel!.data!.code;
    phoneName.text = loginModel!.data!.phone;
  }

  Future<void> openexam(PaperExamDetialsModel timeDataModel, Time dropdownValue,
      BuildContext context) async {
    emit(LoaadingPaperExamRegisterInitial());

    var response = await api.registerExam(
        exma_id: timeDataModel.data!.id, time_id: dropdownValue.id);
    response.fold(
      (l) {
        Navigator.of(context).pop();
        emit(ErrorPaperExamRegisterInitial());
      },
      (r) {
        if (r.code == 200) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    PaperDetailsExmRegisterPage(paperExamModel: r.data!)),
            (route) => true,
          );
        } else {
          Navigator.of(context).pop();
          toastMessage(
            r.message,
            context,
            color: AppColors.error,
          );
        }
        emit(LoaadedPaperExamRegisterInitial());
      },
    );
  }

  void settimevalue(Time? newValue) {
    dropdownValue = newValue;
    emit(PaperExamRegisterInitial());
  }
}
