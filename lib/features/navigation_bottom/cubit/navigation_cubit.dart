import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../config/routes/app_routes.dart';
import '../../../core/models/paper_exam_details_model.dart';
import '../../../core/models/user_model.dart';
import '../../../core/preferences/preferences.dart';
import '../../../core/remote/service.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/show_dialog.dart';
import '../../../core/utils/toast_message_method.dart';

part 'navigation_state.dart';

class NavigationCubit extends Cubit<NavigationState> {
  NavigationCubit(this.api) : super(NavigationInitial()) {
    getUserData();
  }
  final ServiceApi api;
  UserModel? userModel;

  Future<void> getUserData() async {
    emit(NavigationGetUserLoading());
    userModel = await Preferences.instance.getUserModel();
    emit(NavigationGetUserData());
  }

  getTimes(BuildContext context) async {
    emit(ExamRegisterLoadingState());

    createProgressDialog(context, 'wait'.tr());
    final response = await api.paperExamDetails();
    response.fold(
      (error) {
        Navigator.of(context).pop();

        emit(ExamRegisterErrorState());
      },
      (response) {
        Navigator.of(context).pop();
        PaperExamDetialsModel data = response;
        if (data.code == 200) {
          Navigator.pushNamed(context, Routes.paperexamRegisterRoute,
              arguments: data);
        } else if (data.code == 201) {
          Navigator.pushNamed(context, Routes.paperdetialsexamRegisterRoute,
              arguments: data.data);
        } else {
          toastMessage(
            'no_exam'.tr(),
            context,
            color: AppColors.error,
          );
        }
        emit(ExamRegisterLoadedState());
        //data = response.data;
        //  emit(NotificationPageLoaded());
      },
    );
  }
}
