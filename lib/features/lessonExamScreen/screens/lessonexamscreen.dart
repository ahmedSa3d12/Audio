import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_mazoon/config/routes/app_routes.dart';
import 'package:new_mazoon/core/utils/getsize.dart';
import 'package:new_mazoon/features/homePage/widget/home_page_app_bar_widget.dart';
import '../../../core/models/applylessonexammodel.dart';
import '../cubit/lessonexamstate.dart';
import 'package:percent_indicator/percent_indicator.dart';

import '../../../core/utils/app_colors.dart';
import '../cubit/questionlessonexamcubit.dart';

class LessonExamScreen extends StatefulWidget {
  LessonExamScreen(
      {required this.exam_type, required this.lessonId, super.key});
  int lessonId;
  String exam_type;
  @override
  State<LessonExamScreen> createState() => _LessonExamScreenState();
}

class _LessonExamScreenState extends State<LessonExamScreen> {
  List data = [];
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

  int _minutesLeft = 0;
  int _secondsLeft = 0;
  bool _isActive = false;
  Timer? _timer;

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_minutesLeft == 0 && _secondsLeft == 0) {
          _isActive = false;
          _timer!.cancel();
        } else if (_secondsLeft == 0) {
          _minutesLeft--;
          _secondsLeft = 59;
        } else {
          _secondsLeft--;
        }
      });
    });
  }

  @override
  void initState() {
    context.read<QuestionsLessonExamCubit>().getQuestionsOfLessonExam(
        lessonId: widget.lessonId, exam_type: widget.exam_type);

    setState(() {
      _isActive = true;
      _minutesLeft = context
          .read<QuestionsLessonExamCubit>()
          .questionOfLessonData!
          .quizMinute;
      _secondsLeft = 0;
    });
    _startTimer();
    super.initState();
  }

  @override
  void dispose() {
    _timer!.cancel();
    _scrollController.dispose();
    super.dispose();
  }

  bool isLoading = false;
  int index = 0;
  String str =
      'عدد طرق اختيار عددين فرديين من 4 اعداد زوجية, 5 اعداد فردية = ..........';
  // bool loadApplyExam = false;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<QuestionsLessonExamCubit, QuestionsOfLessonExamState>(
      listener: (context, state) {
        if (state is LoadingLessonExam) {
          isLoading = true;
        } else {
          isLoading = false;
        }
      },
      builder: (context, state) {
        var cubit = context.read<QuestionsLessonExamCubit>();
        return isLoading
            ? Scaffold(
                body: CircularPercentIndicator(radius: 25),
              )
            : Scaffold(
                appBar: AppBar(
                  elevation: 0,
                  toolbarHeight: 0,
                  backgroundColor: AppColors.secondPrimary,
                ),
                body: SafeArea(
                  child: Stack(
                    children: [
                      cubit.questionOfLessonData!.questions.isEmpty
                          ? Container(
                              ///
                              child: Center(child: Text('notfound')),
                            )
                          : Container(
                              width: double.infinity,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: getSize(context) / 4),
                                  Flexible(
                                    child: Column(
                                      children: [
                                        Expanded(
                                          child: Container(
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
                                        ),
                                        Expanded(
                                          flex: 3,
                                          child: Container(
                                            alignment: Alignment.center,
                                            child: CircularPercentIndicator(
                                              radius: 45.0,
                                              lineWidth: 9.0,
                                              percent: ((_minutesLeft * 60 +
                                                              _secondsLeft) -
                                                          (cubit.questionOfLessonData!
                                                                  .quizMinute *
                                                              60))
                                                      .abs() /
                                                  (cubit.questionOfLessonData!
                                                          .quizMinute *
                                                      60),
                                              backgroundColor:
                                                  Colors.transparent,
                                              center: SizedBox(
                                                width: 76.93,
                                                height: 25.50,
                                                child: Text(
                                                  '$_minutesLeft:${_secondsLeft.toString().padLeft(2, '0')}',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    color: AppColors.blue5,
                                                    fontSize:
                                                        getSize(context) / 28,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                              ),
                                              progressColor: AppColors.blue5,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Container(
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
                                                      alignment:
                                                          Alignment.center,
                                                      child: Icon(
                                                          color:
                                                              AppColors.blue5,
                                                          Icons
                                                              .arrow_back_ios_new_outlined),
                                                    )),
                                                Flexible(
                                                    fit: FlexFit.tight,
                                                    child: Container(
                                                      alignment:
                                                          Alignment.center,
                                                      child: ListView.builder(
                                                        shrinkWrap: true,
                                                        scrollDirection:
                                                            Axis.horizontal,
                                                        controller:
                                                            _scrollController,
                                                        physics:
                                                            const BouncingScrollPhysics(),
                                                        itemCount: cubit
                                                            .questionOfLessonData!
                                                            .questions
                                                            .length,
                                                        itemBuilder:
                                                            (context, index3) {
                                                          return Container(
                                                              child: InkWell(
                                                            onTap: () {
                                                              setState(() {
                                                                index = index3;
                                                              });
                                                            },
                                                            child: Padding(
                                                              padding: EdgeInsets
                                                                  .all(getSize(
                                                                          context) /
                                                                      100),
                                                              child: CircleAvatar(
                                                                  backgroundColor: (cubit.questionOfLessonData!.questions[index3].isSolving == false && index3 < index)
                                                                      ? AppColors.red
                                                                      : index3 == index
                                                                          ? AppColors.blue5
                                                                          : cubit.questionOfLessonData!.questions[index3].isSolving == true
                                                                              ? AppColors.greenDownloadColor
                                                                              : AppColors.unselectedTabColor,
                                                                  child: Text(
                                                                    index3
                                                                        .toString(),
                                                                    style: TextStyle(
                                                                        fontSize: getSize(context) / 22,
                                                                        fontWeight: FontWeight.bold,
                                                                        color: index3 == index
                                                                            ? AppColors.white
                                                                            : (cubit.questionOfLessonData!.questions[index3].isSolving == false && index3 < index)
                                                                                ? AppColors.white
                                                                                : cubit.questionOfLessonData!.questions[index3].isSolving == true
                                                                                    ? AppColors.white
                                                                                    : AppColors.primary),
                                                                  )),
                                                            ),
                                                          ));
                                                        },
                                                      ),
                                                    )),
                                                IconButton(
                                                    color: AppColors.blue5,
                                                    onPressed: () {
                                                      scrollToPreviousItem();
                                                    },
                                                    icon: Icon(
                                                      color: AppColors.blue5,
                                                      Icons
                                                          .arrow_back_ios_new_outlined,
                                                    )),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 10,
                                          child: SingleChildScrollView(
                                            child: Column(
                                              children: [
                                                Container(
                                                  margin: EdgeInsets.all(
                                                      getSize(context) / 32),
                                                  padding: EdgeInsets.all(
                                                      getSize(context) / 32),
                                                  decoration: BoxDecoration(
                                                      boxShadow: [
                                                        BoxShadow(
                                                            offset:
                                                                Offset(2, 3),
                                                            color:
                                                                AppColors.gray4,
                                                            blurRadius: 8,
                                                            spreadRadius: 0.5)
                                                      ],
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      color: Colors.white),
                                                  child: SingleChildScrollView(
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                            "${index + 1}-${cubit.questionOfLessonData!.questions[index].questionType == 'choice' ? '${'choose_q'.tr()}' : '${'write_q'.tr()}'}",
                                                            style: TextStyle(
                                                                fontSize: getSize(
                                                                        context) /
                                                                    24,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w900,
                                                                color: AppColors
                                                                    .black)),
                                                        Text(
                                                            cubit
                                                                .questionOfLessonData!
                                                                .questions[
                                                                    index]
                                                                .question,
                                                            style: TextStyle(
                                                                fontSize: getSize(
                                                                        context) /
                                                                    24,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w900,
                                                                color: AppColors
                                                                    .black)),
                                                        ListView.builder(
                                                          shrinkWrap: true,
                                                          physics:
                                                              const BouncingScrollPhysics(),
                                                          itemCount: cubit
                                                              .questionOfLessonData!
                                                              .questions[index]
                                                              .answers
                                                              .length,
                                                          itemBuilder: (context,
                                                              index2) {
                                                            return Container(
                                                                margin: EdgeInsets.symmetric(
                                                                    vertical:
                                                                        getSize(context) /
                                                                            32),
                                                                padding:
                                                                    EdgeInsets.all(
                                                                        getSize(context) /
                                                                            44),
                                                                decoration: BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius.circular(getSize(context) /
                                                                            32),
                                                                    color: AppColors
                                                                        .unselectedTabColor,
                                                                    border: Border.all(
                                                                        color: AppColors
                                                                            .gray7,
                                                                        width:
                                                                            2)),
                                                                child:
                                                                    RadioListTile(
                                                                  activeColor:
                                                                      AppColors
                                                                          .blue5,
                                                                  value: cubit
                                                                      .questionOfLessonData!
                                                                      .questions[
                                                                          index]
                                                                      .answers[
                                                                          index2]
                                                                      .answer,
                                                                  groupValue: cubit
                                                                      .questionOfLessonData!
                                                                      .questions[
                                                                          index]
                                                                      .answers[
                                                                          index2]
                                                                      .selectedValue,
                                                                  onChanged:
                                                                      (e) {
                                                                    setState(
                                                                        () {
                                                                      cubit
                                                                          .questionOfLessonData!
                                                                          .questions[
                                                                              index]
                                                                          .answers
                                                                          .forEach(
                                                                              (answer) {
                                                                        answer.selectedValue =
                                                                            e.toString();
                                                                      });
                                                                    });
                                                                    cubit.solveQuestion(
                                                                        index);

                                                                    cubit.questionOfLessonData!.questions[index].answers[index2].selectedValue !=
                                                                            ''
                                                                        ? cubit.details.add(ApplyStudentExam(
                                                                            timer:
                                                                                _minutesLeft,
                                                                            question:
                                                                                cubit.questionOfLessonData!.questions[index].id.toString(),
                                                                            answer: cubit.questionOfLessonData!.questions[index].answers[index2].id.toString()))
                                                                        : null;
                                                                  },
                                                                  title: Row(
                                                                    children: [
                                                                      Text(
                                                                          cubit
                                                                              .questionOfLessonData!
                                                                              .questions[
                                                                                  index]
                                                                              .answers[
                                                                                  index2]
                                                                              .answerNumber,
                                                                          style: TextStyle(
                                                                              fontSize: getSize(context) / 28,
                                                                              fontWeight: FontWeight.w900,
                                                                              color: AppColors.black)),
                                                                      SizedBox(
                                                                        width: getSize(context) /
                                                                            88,
                                                                      ),
                                                                      Text(
                                                                          cubit
                                                                              .questionOfLessonData!
                                                                              .questions[
                                                                                  index]
                                                                              .answers[
                                                                                  index2]
                                                                              .answer,
                                                                          style: TextStyle(
                                                                              fontSize: getSize(context) / 24,
                                                                              fontWeight: FontWeight.w900,
                                                                              color: AppColors.black)),
                                                                    ],
                                                                  ),
                                                                ));
                                                          },
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    cubit.applyLessonExam(
                                                      lessonId: widget.lessonId,
                                                      exam_type: "lesson",
                                                    );

                                                    Navigator.pushReplacementNamed(
                                                        context,
                                                        arguments: cubit
                                                            .responseOfApplyLessonExmamData,
                                                        Routes
                                                            .resultOfLessonExam);
                                                  },
                                                  child: Container(
                                                      margin: EdgeInsets.all(
                                                          getSize(context) /
                                                              22),
                                                      decoration: BoxDecoration(
                                                          color: AppColors
                                                              .greenDownloadColor,
                                                          borderRadius: BorderRadius
                                                              .circular(getSize(
                                                                      context) /
                                                                  22)),
                                                      padding: EdgeInsets.all(
                                                          getSize(context) /
                                                              28),
                                                      child: Text(
                                                        'إنهاء الامتحان',
                                                        style: TextStyle(
                                                            color: AppColors
                                                                .white),
                                                      )),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
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
      },
    );
  }
}
