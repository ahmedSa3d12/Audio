import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:new_mazoon/core/remote/service.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import 'rate_app_state.dart';

class RateAppCubit extends Cubit<RateAppState> {
  RateAppCubit(this.api) : super(RateAppInitial());
  ServiceApi api;
  rateApp() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String url = '';
    String packageName = packageInfo.packageName;

    if (Platform.isAndroid) {
      url = "https://play.google.com/store/apps/details?id=${packageName}";
    } else if (Platform.isIOS) {
      url = 'https://apps.apple.com/us/app/${packageName}';
    }
    if (!await launchUrl(Uri.parse(url),
        mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }
}
