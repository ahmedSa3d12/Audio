import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_mazoon/config/routes/app_routes.dart';
import 'package:percent_indicator/percent_indicator.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/utils/assets_manager.dart';
import '../../../core/utils/getsize.dart';
import '../../../core/widgets/my_svg_widget.dart';
import '../cubit/cubit.dart';
import '../cubit/state.dart';

class ResultOfExamScreen extends StatefulWidget {
  const ResultOfExamScreen({super.key});

  @override
  State<ResultOfExamScreen> createState() => _ResultOfExamScreenState();
}

class _ResultOfExamScreenState extends State<ResultOfExamScreen> {
  bool isLoading = true;
  int currentQuestion = 0;

  @override
  Widget build(BuildContext context) {
    return context.read<MakeYourExamCubit>().resultData == null
        ? Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          )
        : BlocConsumer<MakeYourExamCubit, MakeYourExamState>(
            listener: (context, state) {
              if (state is LoadingApplyMakeYourExam) {
                isLoading = true;
              } else {
                isLoading = false;
              }
            },
            builder: (context, state) {
              var cubit = context.read<MakeYourExamCubit>();
              List<String> parts =
                  cubit.resultData!.studentDegree.toString().split('/');
              double numerator = double.parse(parts[0].trim());
              double denominator = double.parse(parts[1].trim());
              double result = numerator / denominator;
              return WillPopScope(
                onWillPop: () async {
                  cubit.currentLesson = null;
                  cubit.selectedValueLevel = null;
                  cubit.questionNum = 0;
                  cubit.currentClassID = null;
                  cubit.selectedValueLesson = null;
                  cubit.classModel = null;
                  cubit.currentHour = 0;
                  cubit.currentMinutes = 0;
                  cubit.selectedValueExamtype = null;
                  cubit.details.clear();
                  cubit.resultData = null;
                  Navigator.popAndPushNamed(context, Routes.makeYourExamScreen);
                  return false;
                },
                child: SafeArea(
                  child: Scaffold(
                      body: SingleChildScrollView(
                    child: Column(
                      children: [
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                                height: getSize(context) / 1.5,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    color: AppColors.primary,
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(
                                            getSize(context) / 22),
                                        bottomRight: Radius.circular(
                                            getSize(context) / 22)))),
                            Container(
                              height: getSize(context) / 1.5,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(height: getSize(context) / 22),
                                  CircleAvatar(
                                    radius: getSize(context) / 14,
                                    backgroundColor: AppColors.white,
                                    child: Center(
                                        child: Text(
                                      cubit.resultData!.per.toString(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: getSize(context) / 24,
                                          color: AppColors.primary),
                                    )),
                                  ),
                                  SizedBox(height: getSize(context) / 32),
                                  Text(
                                    cubit.resultData!.motivationalWord
                                        .toString(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: getSize(context) / 24,
                                        color: AppColors.white),
                                  ),
                                  // SizedBox(height: getSize(context) / 22),
                                ],
                              ),
                            ),
                            Positioned(
                              bottom: -getSize(context) / 8,
                              child: CircularPercentIndicator(
                                radius: getSize(context) / 8,
                                lineWidth: getSize(context) / 28,
                                animation: true,
                                arcType: ArcType.HALF,
                                percent: 0.7,
                                arcBackgroundColor: AppColors.red,
                                startAngle: 180,
                                circularStrokeCap: CircularStrokeCap.butt,
                                progressColor: AppColors.white,
                              ),
                            ),
                            Positioned(
                                top: getSize(context) / 44,
                                left: getSize(context) / 44,
                                child: IconButton(
                                    onPressed: () {
                                      cubit.currentLesson = null;
                                      cubit.selectedValueLevel = null;
                                      cubit.questionNum = 0;
                                      cubit.currentClassID = null;
                                      cubit.selectedValueLesson = null;
                                      cubit.classModel = null;
                                      cubit.currentHour = 0;
                                      cubit.currentMinutes = 0;
                                      cubit.selectedValueExamtype = null;
                                      cubit.details.clear();
                                      cubit.resultData = null;
                                      Navigator.popAndPushNamed(
                                          context, Routes.makeYourExamScreen);
                                    },
                                    icon: Icon(
                                      Icons.arrow_forward_ios,
                                      color: AppColors.white,
                                    ))),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.all(getSize(context) / 22),
                          child: Text(cubit.resultData!.motivationalWord,
                              style: TextStyle(
                                fontSize: getSize(context) / 32,
                                fontWeight: FontWeight.w200,
                              )),
                        ),
                        Padding(
                          padding: EdgeInsets.all(getSize(context) / 22),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                children: [
                                  Container(
                                    height: getSize(context) / 10,
                                    width: getSize(context) / 10,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                            getSize(context) / 66),
                                        color: AppColors.green),
                                    alignment: Alignment.center,
                                    child: Text(
                                        cubit.resultData!.numOfCorrectQuestions
                                            .toString(),
                                        style: TextStyle(
                                            fontSize: getSize(context) / 22,
                                            fontWeight: FontWeight.w500,
                                            color: AppColors.white)),
                                  ),
                                  Text('right'.tr(),
                                      style: TextStyle(
                                        fontSize: getSize(context) / 32,
                                        fontWeight: FontWeight.w500,
                                      )),
                                ],
                              ),
                              Column(
                                children: [
                                  Container(
                                    height: getSize(context) / 10,
                                    width: getSize(context) / 10,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                            getSize(context) / 66),
                                        color: AppColors.red),
                                    alignment: Alignment.center,
                                    child: Text(
                                        cubit.resultData!.numOfMistakeQuestions
                                            .toString(),
                                        style: TextStyle(
                                            fontSize: getSize(context) / 22,
                                            fontWeight: FontWeight.w500,
                                            color: AppColors.white)),
                                  ),
                                  Text('wrong'.tr(),
                                      style: TextStyle(
                                        fontSize: getSize(context) / 32,
                                        fontWeight: FontWeight.w500,
                                      )),
                                ],
                              ),
                              Column(
                                children: [
                                  Container(
                                    height: getSize(context) / 10,
                                    width: getSize(context) / 10,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                            getSize(context) / 66),
                                        color: AppColors.purple1),
                                    alignment: Alignment.center,
                                    child: Text(
                                        cubit.resultData!.numOfLeaveQuestions
                                            .toString(),
                                        style: TextStyle(
                                            fontSize: getSize(context) / 22,
                                            fontWeight: FontWeight.w500,
                                            color: AppColors.white)),
                                  ),
                                  Text('dont_solve'.tr(),
                                      style: TextStyle(
                                        fontSize: getSize(context) / 32,
                                        fontWeight: FontWeight.w500,
                                      )),
                                ],
                              )
                            ],
                          ),
                        ),
                        Text('اضغط  على اى سؤال بالاسفل لمراجعت اجابتك',
                            style: TextStyle(
                              fontSize: getSize(context) / 32,
                              fontWeight: FontWeight.w700,
                            )),
                        SizedBox(height: getSize(context) / 44),
                        GridView.builder(
                          padding: EdgeInsets.symmetric(
                              horizontal: getSize(context) / 22),
                          shrinkWrap: true,
                          itemCount:
                              cubit.resultData!.examQuestions.questions.length,
                          physics: const BouncingScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 10),
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                setState(() {
                                  currentQuestion = index;
                                });
                              },
                              child: Container(
                                margin: EdgeInsets.all(getSize(context) / 100),
                                child: CircleAvatar(
                                  radius: getSize(context) / 44,
                                  backgroundColor: cubit
                                              .resultData!
                                              .examQuestions
                                              .questions[index]
                                              .questionStatus ==
                                          true
                                      ? AppColors.greenDownloadColor
                                      : AppColors.red,
                                  child: Text('${index + 1}',
                                      style: TextStyle(
                                          fontSize: getSize(context) / 32,
                                          fontWeight: FontWeight.w700,
                                          color: AppColors.white)),
                                ),
                              ),
                            );
                          },
                        ),
                        SizedBox(height: getSize(context) / 44),
                        Container(
                          margin: EdgeInsets.all(getSize(context) / 32),
                          padding: EdgeInsets.all(getSize(context) / 22),
                          alignment: Alignment.center,
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
                              Text(
                                  cubit
                                              .resultData!
                                              .examQuestions
                                              .questions[currentQuestion]
                                              .questionType ==
                                          'choice'
                                      ? "${currentQuestion + 1} - اختر الاجابة الصحيحة "
                                      : "${currentQuestion + 1} - مقالي",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      fontSize: getSize(context) / 24,
                                      fontWeight: FontWeight.w900,
                                      color: AppColors.black)),
                              Text(
                                  cubit.resultData!.examQuestions
                                      .questions[currentQuestion].question,
                                  style: TextStyle(
                                      fontSize: getSize(context) / 28,
                                      fontWeight: FontWeight.w700,
                                      color: AppColors.black)),

                              ///
                              cubit
                                          .resultData!
                                          .examQuestions
                                          .questions[currentQuestion]
                                          .questionType ==
                                      'choice'
                                  ? ListView.builder(
                                      itemCount: cubit
                                          .resultData!
                                          .examQuestions
                                          .questions[currentQuestion]
                                          .answers
                                          .length,
                                      shrinkWrap: true,
                                      physics: const BouncingScrollPhysics(),
                                      itemBuilder: (context, index2) {
                                        return Container(
                                          margin: EdgeInsets.symmetric(
                                              vertical: getSize(context) / 32),
                                          padding: EdgeInsets.all(
                                              getSize(context) / 44),
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(
                                                  getSize(context) / 32),
                                              color: (cubit
                                                              .resultData!
                                                              .examQuestions
                                                              .questions[
                                                                  currentQuestion]
                                                              .answers[index2]
                                                              .id ==
                                                          cubit
                                                              .resultData!
                                                              .examQuestions
                                                              .questions[
                                                                  currentQuestion]
                                                              .answerUser &&
                                                      cubit
                                                              .resultData!
                                                              .examQuestions
                                                              .questions[
                                                                  currentQuestion]
                                                              .answers[index2]
                                                              .answerStatus !=
                                                          'correct')
                                                  ? AppColors.bink
                                                  : cubit
                                                              .resultData!
                                                              .examQuestions
                                                              .questions[
                                                                  currentQuestion]
                                                              .answers[index2]
                                                              .answerStatus ==
                                                          'un_correct'
                                                      ? AppColors.unselectedTabColor
                                                      : AppColors.greenDownloadColor,
                                              border: Border.all(
                                                  color: (cubit.resultData!.examQuestions.questions[currentQuestion].answers[index2].id == cubit.resultData!.examQuestions.questions[currentQuestion].answerUser && cubit.resultData!.examQuestions.questions[currentQuestion].answers[index2].answerStatus != 'correct')
                                                      ? AppColors.red
                                                      : cubit.resultData!.examQuestions.questions[currentQuestion].answers[index2].answerStatus == 'un_correct'
                                                          ? AppColors.gray7
                                                          : AppColors.greenDownloadColor,
                                                  width: 2)),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              CircleAvatar(
                                                backgroundColor:
                                                    AppColors.white,
                                                radius: cubit
                                                            .resultData!
                                                            .examQuestions
                                                            .questions[
                                                                currentQuestion]
                                                            .answers[index2]
                                                            .answerStatus ==
                                                        'un_correct'
                                                    ? getSize(context) / 22
                                                    : cubit
                                                                .resultData!
                                                                .examQuestions
                                                                .questions[
                                                                    currentQuestion]
                                                                .answers[index2]
                                                                .answerStatus ==
                                                            'correct'
                                                        ? getSize(context) / 22
                                                        : getSize(context) / 30,
                                                child: MySvgWidget(
                                                    path: (cubit.resultData!.examQuestions.questions[currentQuestion].answers[index2].id ==
                                                                cubit
                                                                    .resultData!
                                                                    .examQuestions
                                                                    .questions[
                                                                        currentQuestion]
                                                                    .answerUser &&
                                                            cubit
                                                                    .resultData!
                                                                    .examQuestions
                                                                    .questions[
                                                                        currentQuestion]
                                                                    .answers[
                                                                        index2]
                                                                    .answerStatus !=
                                                                'correct')
                                                        ? ImageAssets.wrong
                                                        : cubit.resultData!.examQuestions.questions[currentQuestion].answers[index2].answerStatus ==
                                                                'un_correct'
                                                            ? ImageAssets
                                                                .whiteimage
                                                            : ImageAssets
                                                                .doneIcon,
                                                    imageColor: (cubit
                                                                    .resultData!
                                                                    .examQuestions
                                                                    .questions[
                                                                        currentQuestion]
                                                                    .answers[
                                                                        index2]
                                                                    .id ==
                                                                cubit
                                                                    .resultData!
                                                                    .examQuestions
                                                                    .questions[
                                                                        currentQuestion]
                                                                    .answerUser &&
                                                            cubit
                                                                    .resultData!
                                                                    .examQuestions
                                                                    .questions[
                                                                        currentQuestion]
                                                                    .answers[
                                                                        index2]
                                                                    .answerStatus !=
                                                                'correct')
                                                        ? AppColors.red
                                                        : cubit
                                                                    .resultData!
                                                                    .examQuestions
                                                                    .questions[
                                                                        currentQuestion]
                                                                    .answers[index2]
                                                                    .answerStatus ==
                                                                'un_correct'
                                                            ? AppColors.white
                                                            : AppColors.greenDownloadColor,
                                                    size: getSize(context) / 24),
                                              ),
                                              Flexible(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(
                                                      cubit
                                                          .resultData!
                                                          .examQuestions
                                                          .questions[
                                                              currentQuestion]
                                                          .answers[index2]
                                                          .answer
                                                          .toString(),
                                                      style: TextStyle(
                                                        fontSize:
                                                            getSize(context) /
                                                                24,
                                                        fontWeight:
                                                            FontWeight.w400,

                                                        ///check status
                                                        color: (cubit
                                                                        .resultData!
                                                                        .examQuestions
                                                                        .questions[
                                                                            currentQuestion]
                                                                        .answers[
                                                                            index2]
                                                                        .id ==
                                                                    cubit
                                                                        .resultData!
                                                                        .examQuestions
                                                                        .questions[
                                                                            currentQuestion]
                                                                        .answerUser &&
                                                                cubit
                                                                        .resultData!
                                                                        .examQuestions
                                                                        .questions[
                                                                            currentQuestion]
                                                                        .answers[
                                                                            index2]
                                                                        .answerStatus !=
                                                                    'correct')
                                                            ? AppColors.white
                                                            : cubit
                                                                        .resultData!
                                                                        .examQuestions
                                                                        .questions[
                                                                            currentQuestion]
                                                                        .answers[
                                                                            index2]
                                                                        .answerStatus ==
                                                                    'un_correct'
                                                                ? AppColors
                                                                    .black
                                                                : AppColors
                                                                    .white,
                                                      )),
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    )
                                  : Container(
                                      margin: EdgeInsets.symmetric(
                                          vertical: getSize(context) / 32),
                                      padding:
                                          EdgeInsets.all(getSize(context) / 44),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                              getSize(context) / 32),
                                          color: AppColors.unselectedTabColor,
                                          border: Border.all(
                                              color: AppColors.gray7,
                                              width: 2)),
                                      child: Text(
                                        cubit
                                            .resultData!
                                            .examQuestions
                                            .questions[currentQuestion]
                                            .answerUser
                                            .toString(),
                                        style: TextStyle(
                                            fontSize: getSize(context) / 28,
                                            fontWeight: FontWeight.w700,
                                            color: AppColors.black),
                                      ))
                            ],
                          ),
                        )
                      ],
                    ),
                  )),
                ),
              );
            },
          );
  }
}
