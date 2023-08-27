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
        ? Container(
            alignment: Alignment.center,
            height: getSize(context),
            child: Center(child: Text('rate_msg'.tr())))
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
                      body: Padding(
                    padding: EdgeInsets.all(getSize(context) / 32),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(
                            height: getSize(context) / 12,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('نتيجة الاختبار',
                                style: TextStyle(
                                  fontSize: getSize(context) / 32,
                                  fontWeight: FontWeight.w700,
                                )),
                          ),
                          Stack(
                            children: [
                              CircularPercentIndicator(
                                backgroundColor: AppColors.offWiite,
                                radius: getSize(context) / 8,
                                lineWidth: getSize(context) / 32,
                                percent: result > 1 ? 1 : result,
                                center: Text(cubit.resultData!.per),
                                progressColor: AppColors.greenDownloadColor,
                              )
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
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
                                          cubit
                                              .resultData!.numOfCorrectQuestions
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
                                          cubit
                                              .resultData!.numOfMistakeQuestions
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
                            shrinkWrap: true,
                            itemCount: cubit
                                .resultData!.examQuestions.questions.length,
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
                                  margin:
                                      EdgeInsets.all(getSize(context) / 100),
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
                            padding: EdgeInsets.all(getSize(context) / 32),
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
                                                vertical:
                                                    getSize(context) / 32),
                                            padding: EdgeInsets.all(
                                                getSize(context) / 44),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        getSize(context) / 32),
                                                color: cubit
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
                                                            .answerUser
                                                    ? (cubit
                                                                .resultData!
                                                                .examQuestions
                                                                .questions[
                                                                    currentQuestion]
                                                                .answers[index2]
                                                                .answerStatus ==
                                                            'correct'
                                                        ? AppColors
                                                            .greenDownloadColor
                                                        : AppColors.bink)
                                                    : AppColors.unselectedTabColor,
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
                                                                  .answers[
                                                                      index2]
                                                                  .answerStatus ==
                                                              'correct'
                                                          ? getSize(context) /
                                                              22
                                                          : getSize(context) /
                                                              30,
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
                                                                      .questions[currentQuestion]
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
                                                        const EdgeInsets.all(
                                                            8.0),
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
                                        padding: EdgeInsets.all(
                                            getSize(context) / 44),
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
                    ),
                  )),
                ),
              );
            },
          );
  }
}
