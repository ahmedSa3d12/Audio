import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart' as trans;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:new_mazoon/core/models/user_model.dart';
import 'package:new_mazoon/core/utils/assets_manager.dart';
import 'package:new_mazoon/core/utils/getsize.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:popover/popover.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../features/login/cubit/login_cubit.dart';
import '../preferences/preferences.dart';
import '../utils/app_colors.dart';
import 'RPSCustom_painter_widgte.dart';

class CallUsWidget extends StatefulWidget {
  CallUsWidget({Key? key}) : super(key: key);

  @override
  State<CallUsWidget> createState() => _CallUsWidgetState();
}

class _CallUsWidgetState extends State<CallUsWidget> {
  double _listHeight = 0;
  bool isHeight = false;
  UserModel? userModel;
  @override
  void initState() {
    context.read<LoginCubit>().getCommunicationData();
    Preferences.instance.getUserModel().then((value) {
      setState(() {
        userModel = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double _height = getSize(context) / 1.3;
    return BlocBuilder<LoginCubit, LoginState>(
      builder: (context, state) {
        LoginCubit cubit = context.read<LoginCubit>();

        return (userModel == null)
            ? Container(
                height: _height,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      AppColors.primary,
                      AppColors.litePrimary,
                      AppColors.white,
                    ],
                  ),
                ),
                child: Center(
                    child: CircularPercentIndicator(
                        radius: getSize(context) / 22)))
            : AnimatedContainer(
                height: _height,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(getSize(context) / 22),
                    topRight: Radius.circular(getSize(context) / 22),
                  ),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      AppColors.primary,
                      AppColors.litePrimary,
                      AppColors.white,
                    ],
                  ),
                ),
                duration: const Duration(milliseconds: 500),
                child: ListView(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: getSize(context) / 22),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: getSize(context) / 22),
                          child: Text(
                            trans.tr('welcome') + userModel!.data!.name,
                            style: TextStyle(
                                fontSize: getSize(context) / 22,
                                fontWeight: FontWeight.bold,
                                color: AppColors.white),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            Get.back();
                          },
                          icon: Icon(
                            Icons.close,
                            size: getSize(context) / 12,
                            color: AppColors.white,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: getSize(context) / 22),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        trans.tr('contact_us_from'),
                        style: TextStyle(
                            fontSize: getSize(context) / 22,
                            fontWeight: FontWeight.bold,
                            color: AppColors.white),
                      ),
                    ),
                    SizedBox(height: getSize(context) / 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(width: 0),
                        InkWell(
                          onTap: () {
                            _launchUrl(cubit.communicationData!.whatsApp);
                          },
                          child: Image.asset(
                            ImageAssets.callUsWhatsappImage,
                            width: getSize(context) / 6,
                            height: getSize(context) / 6,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            showPopover(
                              context: context,
                              bodyBuilder: (context) => Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Row(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        _launchUrlPhone(
                                            cubit.communicationData!.sms);
                                      },
                                      child: Icon(
                                        Icons.email_outlined,
                                        color: AppColors.red,
                                        size: getSize(context) / 16,
                                      ),
                                    ),
                                    SizedBox(width: getSize(context) / 32),
                                    Expanded(
                                      child: SingleChildScrollView(
                                        child: Container(
                                          margin: EdgeInsets.all(
                                              getSize(context) / 32),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(
                                                cubit.communicationData!.sms,
                                                style: TextStyle(
                                                  fontSize:
                                                      getSize(context) / 22,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Text(
                                                cubit.communicationData!
                                                    .smsMessage,
                                                style: TextStyle(
                                                    fontSize:
                                                        getSize(context) / 24),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              onPop: () => print('Popover was popped!'),
                              direction: PopoverDirection.bottom,
                              backgroundColor: Colors.white,
                              width: getSize(context) / 1.5,
                              arrowHeight: 40,
                              arrowWidth: 30,
                            );
                          },
                          child: Image.asset(
                            ImageAssets.callUsSmsImage,
                            width: getSize(context) / 6,
                            height: getSize(context) / 6,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            _launchUrl(cubit.communicationData!.facebookLink);
                          },
                          child: Image.asset(
                            ImageAssets.callUsMessengerImage,
                            width: getSize(context) / 6,
                            height: getSize(context) / 6,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            if (isHeight) {
                              setState(() {
                                _height = 300;
                                _listHeight = 0;
                                isHeight = !isHeight;
                              });
                            } else {
                              setState(() {
                                _height = 500;
                                _listHeight = getSize(context) / 1.8;
                                isHeight = !isHeight;
                              });
                            }
                          },
                          child: Image.asset(
                            ImageAssets.callUsCallImage,
                            width: getSize(context) / 6,
                            height: getSize(context) / 6,
                          ),
                        ),
                        SizedBox(width: 0),
                      ],
                    ),
                    // SizedBox(height: 30),
                    AnimatedContainer(
                      height: _listHeight,
                      duration: const Duration(milliseconds: 500),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Container(
                          decoration: BoxDecoration(
                              // color: AppColors.white,
                              borderRadius: BorderRadius.circular(18)),
                          padding: const EdgeInsets.all(6.0),
                          child: Stack(
                            children: [
                              Positioned(
                                top: 0,
                                bottom: 0,
                                left: 0,
                                right: 0,
                                child: CustomPaint(
                                  size: Size(
                                    MediaQuery.of(context).size.width,
                                    (MediaQuery.of(context).size.width *
                                            0.5573333333333333)
                                        .toDouble(),
                                  ),
                                  //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
                                  painter: RPSCustomPainter(),
                                ),
                              ),
                              Positioned(
                                top: 40,
                                bottom: 12,
                                left: 12,
                                right: 12,
                                child: Column(
                                  children: [
                                    Expanded(
                                      child: ListView.separated(
                                        itemBuilder: (context, index) {
                                          return Padding(
                                            padding: const EdgeInsets.all(12.0),
                                            child: Row(
                                              children: [
                                                InkWell(
                                                  onTap: () {
                                                    _launchUrlPhone2(cubit
                                                        .communicationData!
                                                        .phones[index]
                                                        .phone);
                                                  },
                                                  child: Icon(
                                                    Icons.call,
                                                    color:
                                                        AppColors.blueLiteColor,
                                                    size: 30,
                                                  ),
                                                ),
                                                SizedBox(width: 20),
                                                Expanded(
                                                  child: SingleChildScrollView(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        Text(
                                                          cubit
                                                              .communicationData!
                                                              .phones[index]
                                                              .phone,
                                                          style: TextStyle(
                                                            fontSize: getSize(
                                                                    context) /
                                                                22,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                        Text(
                                                          cubit
                                                              .communicationData!
                                                              .phones[index]
                                                              .note,
                                                          style: TextStyle(
                                                              fontSize: getSize(
                                                                      context) /
                                                                  26),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          );
                                        },
                                        separatorBuilder: (context, sIndex) =>
                                            Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.80,
                                          height: 1,
                                          color: AppColors.gray,
                                        ),
                                        itemCount: cubit
                                            .communicationData!.phones.length,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              );
      },
    );
  }

  Future<void> _launchUrl(url) async {
    if (!await launchUrl(Uri.parse(url),
        mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }

  Future<void> _launchUrlPhone(url) async {
    if (!await launchUrl(Uri(scheme: 'sms', path: url),
        mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }

  Future<void> _launchUrlPhone2(url) async {
    if (!await launchUrl(Uri(scheme: 'tel', path: url),
        mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }
}
