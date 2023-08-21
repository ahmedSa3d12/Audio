import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:new_mazoon/core/remote/service.dart';
import 'package:new_mazoon/features/invite_friends/cubit/state.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../../core/models/invitefriend.dart';
import '../../../core/utils/app_colors.dart';

class IniviteFreiendsCubit extends Cubit<InviteFreiendsState> {
  IniviteFreiendsCubit(this.api) : super(InitInviteFreiends());
  ServiceApi api;
  InviteFriendModelData? inviteFreiend;
  List<Color> colors = [AppColors.orange, AppColors.blue, AppColors.purple1];

  getInviteFreiend() async {
    emit(LoadingInitInviteFreiends());
    final response = await api.getInviteFreiend();
    response.fold(
      (l) => emit(ErrorInitInviteFreiends()),
      (r) {
        inviteFreiend = r.data;
        emit(SuccessInitInviteFreiends());
      },
    );
  }

  void shareApp() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    String url = '';
    String packageName = packageInfo.packageName;

    if (Platform.isAndroid) {
      url = "https://play.google.com/store/apps/details?id=${packageName}";
    } else if (Platform.isIOS) {
      url = 'https://apps.apple.com/us/app/${packageName}';
    }
    await FlutterShare.share(title: 'mazoon', linkUrl: url);
  }
}
//.tr()