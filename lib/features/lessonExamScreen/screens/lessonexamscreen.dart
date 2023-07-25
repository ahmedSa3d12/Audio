import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:new_mazoon/core/utils/getsize.dart';
import 'package:new_mazoon/features/homePage/widget/home_page_app_bar_widget.dart';
import 'package:percent_indicator/percent_indicator.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/utils/assets_manager.dart';
import '../../../core/widgets/my_svg_widget.dart';

class LessonExamScreen extends StatefulWidget {
  const LessonExamScreen({super.key});

  @override
  State<LessonExamScreen> createState() => _LessonExamScreenState();
}

class _LessonExamScreenState extends State<LessonExamScreen> {
  List data = [
    '1',
    '2',
    '3',
    '4',
    '6',
    '2',
    '3',
    '4',
    '6',
    '2',
    '3',
    '4',
    '6',
    '2',
    '3',
    '4',
    '6',
    '2',
    '3',
    '4',
    '6',
    '2',
    '3',
    '4',
    '6',
    '2',
    '3',
    '4',
    '6'
  ];
  ScrollController _scrollController = ScrollController();

  void scrollToNextItem() {
    _scrollController.animateTo(
      _scrollController.position.pixels - 100,
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  void scrollToPreviousItem() {
    _scrollController.animateTo(
      _scrollController.position.pixels + 100,
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  String str =
      'عدد طرق اختيار عددين فرديين من 4 اعداد زوجية, 5 اعداد فردية = ..........';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 0,
        backgroundColor: AppColors.secondPrimary,
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: getSize(context) / 3.5),
                    Container(
                      alignment: Alignment.center,
                      child: Text(
                        'rest_time'.tr(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColors.black,
                          fontSize: getSize(context) / 22,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    SizedBox(height: getSize(context) / 44),
                    Container(
                      alignment: Alignment.center,
                      child: CircularPercentIndicator(
                        radius: 45.0,
                        lineWidth: 9.0,
                        percent: 0.60,
                        backgroundColor: Colors.transparent,
                        center: SizedBox(
                          width: 76.93,
                          height: 25.50,
                          child: Text(
                            '00:05:50',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: AppColors.blue5,
                              fontSize: getSize(context) / 28,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        progressColor: AppColors.blue5,
                      ),
                    ),
                    SizedBox(height: getSize(context) / 44),
                    Container(
                      alignment: Alignment.center,
                      child: Row(
                        children: [
                          IconButton(
                              color: AppColors.blue5,
                              onPressed: () {
                                setState(() {
                                  scrollToNextItem();
                                });
                              },
                              icon: Transform.rotate(
                                angle: 3,
                                alignment: Alignment.center,
                                child: Icon(
                                    color: AppColors.blue5,
                                    Icons.arrow_back_ios_new_outlined),
                              )),
                          Flexible(
                            child: Container(
                              alignment: Alignment.center,
                              height: getSize(context) / 8,
                              child: SingleChildScrollView(
                                controller: _scrollController,
                                physics: const BouncingScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: [
                                    ...data.map((e) => InkWell(
                                          onTap: () {
                                            setState(() {
                                              str = e;
                                            });
                                          },
                                          child: Padding(
                                            padding: EdgeInsets.all(
                                                getSize(context) / 100),
                                            child: CircleAvatar(
                                                backgroundColor:
                                                    AppColors.blue5,
                                                child: Text(
                                                  e,
                                                  style: TextStyle(
                                                      fontSize:
                                                          getSize(context) / 22,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: AppColors.white),
                                                )),
                                          ),
                                        ))
                                  ],
                                ),
                              ),
                            ),
                          ),
                          IconButton(
                              color: AppColors.blue5,
                              onPressed: () {
                                scrollToPreviousItem();
                              },
                              icon: Icon(
                                color: AppColors.blue5,
                                Icons.arrow_back_ios_new_outlined,
                              )),
                        ],
                      ),
                    ),
                    SizedBox(height: getSize(context) / 44),
                    Container(
                      margin: EdgeInsets.all(getSize(context) / 32),
                      padding: EdgeInsets.all(getSize(context) / 32),
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                offset: Offset(2, 3),
                                color: AppColors.gray4,
                                blurRadius: 8,
                                spreadRadius: 0.5)
                          ],
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("1- اختر الاجابة الصحيحة :",
                              style: TextStyle(
                                  fontSize: getSize(context) / 24,
                                  fontWeight: FontWeight.w900,
                                  color: AppColors.black)),
                          Text(str,
                              style: TextStyle(
                                  fontSize: getSize(context) / 28,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.black)),
                          Container(
                            margin: EdgeInsets.symmetric(
                                vertical: getSize(context) / 32),
                            padding: EdgeInsets.all(getSize(context) / 44),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    getSize(context) / 32),
                                color: AppColors.bink,
                                border: Border.all(
                                    color: Colors.red.shade400, width: 2)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  backgroundColor: AppColors.white,
                                  radius: getSize(context) / 22,
                                  child: MySvgWidget(
                                      path: ImageAssets.wrong,
                                      imageColor: AppColors.red,
                                      size: getSize(context) / 22),
                                ),
                                Flexible(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                        "simply dummy text of the printing and typesetting industry",
                                        style: TextStyle(
                                            fontSize: getSize(context) / 24,
                                            fontWeight: FontWeight.w900,

                                            ///check status
                                            color: AppColors.white)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(
                                vertical: getSize(context) / 32),
                            padding: EdgeInsets.all(getSize(context) / 44),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    getSize(context) / 32),
                                color: Color(0xffeeeeee),
                                border:
                                    Border.all(color: Colors.grey, width: 2)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  backgroundColor: AppColors.white,
                                  radius: getSize(context) / 22,
                                  child: MySvgWidget(
                                      path: ImageAssets.doneIcon,
                                      imageColor: AppColors.greenDownloadColor,
                                      size: getSize(context) / 22),
                                ),
                                Flexible(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                        "simply dummy  an  essentially unchanged. It was popularis",
                                        style: TextStyle(
                                            fontSize: getSize(context) / 24,
                                            fontWeight: FontWeight.w900,
                                            color: AppColors.black)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(
                                vertical: getSize(context) / 32),
                            padding: EdgeInsets.all(getSize(context) / 44),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    getSize(context) / 32),
                                color: AppColors.bink,
                                border: Border.all(
                                    color: Colors.red.shade400, width: 2)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  backgroundColor: AppColors.white,
                                  radius: getSize(context) / 22,
                                  child: MySvgWidget(
                                      path: ImageAssets.wrong,
                                      imageColor: AppColors.red,
                                      size: getSize(context) / 22),
                                ),
                                Flexible(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                        "simply dummy text of the printing and typesetting industry",
                                        style: TextStyle(
                                            fontSize: getSize(context) / 24,
                                            fontWeight: FontWeight.w900,

                                            ///check status
                                            color: AppColors.white)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            ///
            Positioned(
              top: 0,
              right: 0,
              left: 0,
              child: HomePageAppBarWidget(isHome: false),
            ),
          ],
        ),
      ),
    );
  }
}
