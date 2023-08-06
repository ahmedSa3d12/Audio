import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:percent_indicator/percent_indicator.dart';
import '../../../core/models/applylessonexammodel.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/getsize.dart';
import '../../../core/widgets/title_with_circle_background_widget.dart';
import '../../homePage/widget/home_page_app_bar_widget.dart';
import '../cubit/lessonexamstate.dart';
import '../cubit/questionlessonexamcubit.dart';

class ResultExamLessonScreen extends StatefulWidget {
  ResultExamLessonScreen({required this.model, super.key});
  ResponseOfApplyLessonExmamData model;

  @override
  State<ResultExamLessonScreen> createState() => _ResultExamLessonScreenState();
}

class _ResultExamLessonScreenState extends State<ResultExamLessonScreen> {
  bool loadApplyExam = true;

  @override
  Widget build(BuildContext context) {
    List<String> parts = widget.model.degree.toString().split('/');
    double numerator = double.parse(parts[0].trim());
    double denominator = double.parse(parts[1].trim());
    double result = numerator / denominator;
    return BlocConsumer<QuestionsLessonExamCubit, QuestionsOfLessonExamState>(
      listener: (context, state) {
        if (state is LoadingApplyLessonExam) {
          loadApplyExam = true;
        } else {
          loadApplyExam = false;
        }
      },
      builder: (context, state) {
        return loadApplyExam
            ? Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              )
            : Scaffold(
                appBar: AppBar(
                  elevation: 0,
                  toolbarHeight: 0,
                  backgroundColor: AppColors.secondPrimary,
                ),
                body: Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: getSize(context) / 4),
                          TitleWithCircleBackgroundWidget(title: 'result_exam'),
                          Container(
                            width: double.infinity,
                            alignment: Alignment.center,
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Container(
                                    margin: EdgeInsets.only(
                                        top: getSize(context) / 4),
                                    width: getSize(context) / 1.2,
                                    height: getSize(context) / 1.3,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                            getSize(context) / 32),
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Color(0x3F000000),
                                            blurRadius: 20,
                                            offset: Offset(0, 4),
                                            spreadRadius: 0,
                                          )
                                        ])),
                                Positioned(
                                  top: 5,
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Container(
                                        alignment: Alignment.topCenter,
                                        margin: EdgeInsets.only(
                                            top: getSize(context) / 6),
                                        width: getSize(context) / 1.3,
                                        height: getSize(context) / 3,
                                        decoration: BoxDecoration(
                                          color: AppColors.blue5,
                                          borderRadius: BorderRadius.circular(
                                              getSize(context) / 44),
                                        ),
                                      ),
                                      Positioned(
                                        top: 5,
                                        child: Column(
                                          children: [
                                            Container(
                                              child: Stack(
                                                alignment: Alignment.center,
                                                children: [
                                                  CircleAvatar(
                                                    radius:
                                                        getSize(context) / 7,
                                                    backgroundColor:
                                                        AppColors.white,
                                                  ),
                                                  CircularPercentIndicator(
                                                    radius:
                                                        getSize(context) / 8,
                                                    animation: true,
                                                    animationDuration: 1200,
                                                    lineWidth: 15.0,
                                                    percent: result,
                                                    center: new Text(
                                                      widget.model.degree,
                                                      style: new TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize:
                                                              getSize(context) /
                                                                  32),
                                                    ),
                                                    circularStrokeCap:
                                                        CircularStrokeCap.butt,
                                                    backgroundColor:
                                                        AppColors.white,
                                                    progressColor:
                                                        AppColors.blue5,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: getSize(context) / 32,
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(
                                                  bottom:
                                                      getSize(context) / 32),
                                              padding: EdgeInsets.all(
                                                  getSize(context) / 44),
                                              height: getSize(context) / 8,
                                              width: getSize(context) / 1.6,
                                              decoration: BoxDecoration(
                                                  color: AppColors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          getSize(context) /
                                                              44)),
                                              child: Row(
                                                children: [
                                                  CircleAvatar(
                                                    backgroundColor: AppColors
                                                        .orangeThirdPrimary,
                                                    radius:
                                                        getSize(context) / 22,
                                                    child: Text(
                                                      widget.model.ordered
                                                          .toString(),
                                                      style: TextStyle(
                                                          fontSize:
                                                              getSize(context) /
                                                                  28,
                                                          color:
                                                              AppColors.white),
                                                    ),
                                                  ),
                                                  Text(
                                                    'ordered'.tr(),
                                                    style: TextStyle(
                                                      color: AppColors.black,
                                                      fontSize:
                                                          getSize(context) / 28,
                                                    ),
                                                  ),
                                                  Spacer(),
                                                  Text(
                                                    '${widget.model.motivationalWord}',
                                                    style: TextStyle(
                                                        fontSize:
                                                            getSize(context) /
                                                                28,
                                                        color: AppColors.black),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: getSize(context) / 32,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Positioned(
                                  top: getSize(context) / 1.9,
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: getSize(context) / 32,
                                      ),
                                      Container(
                                        width: getSize(context) / 1.3,
                                        height: getSize(context) / 7,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Column(
                                              children: [
                                                Flexible(
                                                  child: Container(
                                                    margin: EdgeInsets.only(
                                                        bottom:
                                                            getSize(context) /
                                                                100),
                                                    decoration: BoxDecoration(
                                                        color: AppColors
                                                            .greenDownloadColor,
                                                        borderRadius: BorderRadius
                                                            .circular(getSize(
                                                                    context) /
                                                                44)),
                                                    height:
                                                        getSize(context) / 12,
                                                    width:
                                                        getSize(context) / 12,
                                                    child: Text(
                                                      widget.model
                                                          .numOfCorrectQuestions
                                                          .toString(),
                                                      style: TextStyle(
                                                          color:
                                                              AppColors.white,
                                                          fontSize:
                                                              getSize(context) /
                                                                  36),
                                                    ),
                                                    alignment: Alignment.center,
                                                  ),
                                                ),
                                                Text(
                                                  'correct_answer'.tr(),
                                                  style: TextStyle(
                                                      fontSize:
                                                          getSize(context) /
                                                              36),
                                                ),
                                              ],
                                            ),
                                            Column(
                                              children: [
                                                Flexible(
                                                  child: Container(
                                                    margin: EdgeInsets.only(
                                                        bottom:
                                                            getSize(context) /
                                                                100),
                                                    alignment: Alignment.center,
                                                    height:
                                                        getSize(context) / 12,
                                                    width:
                                                        getSize(context) / 12,
                                                    decoration: BoxDecoration(
                                                        color: AppColors
                                                            .yellowColor,
                                                        borderRadius: BorderRadius
                                                            .circular(getSize(
                                                                    context) /
                                                                44)),
                                                    child: Text(
                                                      widget.model
                                                          .numOfLeaveQuestions
                                                          .toString(),
                                                      style: TextStyle(
                                                          color:
                                                              AppColors.white,
                                                          fontSize:
                                                              getSize(context) /
                                                                  36),
                                                    ),
                                                  ),
                                                ),
                                                Text(
                                                  'dont_solved'.tr(),
                                                  style: TextStyle(
                                                      fontSize:
                                                          getSize(context) /
                                                              36),
                                                ),
                                              ],
                                            ),
                                            Column(
                                              children: [
                                                Flexible(
                                                  child: Container(
                                                    margin: EdgeInsets.only(
                                                        bottom:
                                                            getSize(context) /
                                                                100),
                                                    height:
                                                        getSize(context) / 12,
                                                    width:
                                                        getSize(context) / 12,
                                                    decoration: BoxDecoration(
                                                        color: AppColors.red,
                                                        borderRadius: BorderRadius
                                                            .circular(getSize(
                                                                    context) /
                                                                44)),
                                                    child: Text(
                                                      widget.model
                                                          .numOfMistakeQuestions
                                                          .toString(),
                                                      style: TextStyle(
                                                          color:
                                                              AppColors.white,
                                                          fontSize:
                                                              getSize(context) /
                                                                  36),
                                                    ),
                                                    alignment: Alignment.center,
                                                  ),
                                                ),
                                                Text(
                                                  'un_correct_ans'.tr(),
                                                  style: TextStyle(
                                                      fontSize:
                                                          getSize(context) /
                                                              36),
                                                ),
                                              ],
                                            ),
                                            Column(
                                              children: [
                                                Flexible(
                                                  child: Container(
                                                    margin: EdgeInsets.only(
                                                        bottom:
                                                            getSize(context) /
                                                                100),
                                                    height:
                                                        getSize(context) / 12,
                                                    width:
                                                        getSize(context) / 12,
                                                    decoration: BoxDecoration(
                                                        color:
                                                            AppColors.purple1,
                                                        borderRadius: BorderRadius
                                                            .circular(getSize(
                                                                    context) /
                                                                44)),
                                                    child: Text(
                                                      widget.model.tryingNumber
                                                          .toString(),
                                                      style: TextStyle(
                                                          color:
                                                              AppColors.white,
                                                          fontSize:
                                                              getSize(context) /
                                                                  36),
                                                    ),
                                                    alignment: Alignment.center,
                                                  ),
                                                ),
                                                Text(
                                                  'trys'.tr(),
                                                  style: TextStyle(
                                                      fontSize:
                                                          getSize(context) /
                                                              36),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: getSize(context) / 32,
                                      ),
                                      Container(
                                        width: getSize(context) / 1.3,
                                        height: getSize(context) / 7,
                                        color: AppColors.red,
                                        child: Row(),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      top: 0,
                      right: 0,
                      left: 0,
                      child: HomePageAppBarWidget(isHome: false),
                    ),
                  ],
                ),
              );
      },
    );
  }
}
