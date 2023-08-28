import 'dart:developer';

import 'package:easy_localization/easy_localization.dart' as translate;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_mazoon/config/routes/app_routes.dart';
import 'package:new_mazoon/core/preferences/preferences.dart';
import 'package:new_mazoon/core/utils/app_colors.dart';
import 'package:new_mazoon/features/onboarding/cubit/on_boarding_cubit.dart';
import 'package:new_mazoon/features/splash/presentation/cubit/splash_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../core/utils/assets_manager.dart';
import '../../../core/utils/getsize.dart';
import 'onBordingWidget.dart';

class OnBordingScreen extends StatefulWidget {
  const OnBordingScreen({super.key});

  @override
  State<OnBordingScreen> createState() => _OnBordingScreenState();
}

class _OnBordingScreenState extends State<OnBordingScreen> {
  bool isLastIndex = false;
  final controller = PageController();
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Future<void> onDonePress() async {
    log("End of slides");
    Preferences.instance.setFirstInstall();
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (prefs.getString('user') != null) {
      if (context.read<SplashCubit>().adsList.isNotEmpty) {
        Navigator.pushReplacementNamed(context, Routes.podAdsPageScreenRoute,
            arguments: context.read<SplashCubit>().adsList.first);
      } else {
        Navigator.pushReplacementNamed(
          context,
          Routes.homePageScreenRoute,
        );
      }
    } else {
      Navigator.pushNamedAndRemoveUntil(
        context,
        Routes.loginRoute,
        ModalRoute.withName(
          Routes.initialRoute,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnBoardingCubit, OnBoardingState>(
      builder: (context, state) {
        var cubit = BlocProvider.of<OnBoardingCubit>(context);
        return Scaffold(
          body: Container(
            padding: const EdgeInsets.only(bottom: 80),
            child: PageView(
              reverse: true,
              controller: controller,
              onPageChanged: (value) {
                setState(() {
                  isLastIndex = value == cubit.listBorderData.length - 1;
                });
              },
              children: [
                ...cubit.listBorderData.map(
                  (e) => OnBordingModel(
                      color: Colors.blueGrey.shade50,
                      image: e.image!,
                      title: e.title!,
                      subtitle: e.description!),
                )
                // OnBordingModel()
                //     color: Colors.blueGrey.shade100,
                //     image: 'assets/images/test1.png',
                //     title: 'اشترك واحصل على المراجعات',
                //     subtitle: 'ادخل كود الاشتراك , وابدأ رحلتك التعليمية'),
                // OnBordingModel(
                //     color: Colors.grey.shade300,
                //     image: 'assets/images/test1.png',
                //     title: 'الفيزياء بطريقة جديدة وممتعة',
                //     subtitle: 'أفضل نظام متابعة من متتخصصين معاك لحظة بلحظة'),
              ],
            ),
          ),
          bottomSheet: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                color: Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                height: 80,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                        onPressed: () {
                          isLastIndex
                              ? onDonePress()
                              : controller.nextPage(
                                  duration: const Duration(milliseconds: 500),
                                  curve: Curves.easeInOut);
                        },
                        child: Container(
                          width: 110,
                          height: 45,
                          alignment: Alignment.center,
                          // padding:
                          //     EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                          decoration: BoxDecoration(
                              color: AppColors.blue5,
                              borderRadius: BorderRadius.circular(12)),
                          child: Text(
                            isLastIndex
                                ? translate.tr('done')
                                : translate.tr('next'),
                            style:
                                TextStyle(color: AppColors.white, fontSize: 20),
                          ),
                        )),
                    Center(
                      child: SmoothPageIndicator(
                        controller: controller,
                        count: cubit.listBorderData.length,
                        onDotClicked: (index) {
                          controller.animateToPage(index,
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeInOut);
                        },
                        textDirection: TextDirection.ltr,
                        effect: SlideEffect(
                            spacing: 8.0,
                            radius: 4.0,
                            dotWidth:
                                cubit.listBorderData.length <= 3 ? 30.0 : 10,
                            dotHeight: 7.0,
                            paintStyle: PaintingStyle.stroke,
                            strokeWidth: 1.5,
                            dotColor: AppColors.grey2,
                            activeDotColor: AppColors.blue5),
                      ),
                    ),
                    isLastIndex
                        ? Container(
                            width: 80,
                          )
                        : TextButton(
                            onPressed: () {
                              onDonePress();
                              // controller.animateToPage(
                              //     cubit.listBorderData.length - 1,
                              //     duration: const Duration(milliseconds: 500),
                              //     curve: Curves.easeInOut);
                            },
                            child: Text(
                              translate.tr('skip'),
                              style: TextStyle(
                                  color: AppColors.descriptionBoardingColor,
                                  fontSize: 20),
                            )),
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                color: AppColors.white,
                child: Image.asset(
                  ImageAssets.copyRight,
                  // height: getSize(context) / 8,
                  width: getSize(context) / 1.2,
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
