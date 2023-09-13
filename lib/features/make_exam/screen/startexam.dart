import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_mazoon/config/routes/app_routes.dart';
import 'package:new_mazoon/features/make_exam/cubit/cubit.dart';
import 'package:new_mazoon/features/make_exam/cubit/state.dart';
import 'package:percent_indicator/percent_indicator.dart';
import '../../../core/models/applaymakeexammodel.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/getsize.dart';
import '../../homePage/widget/home_page_app_bar_widget.dart';

class StartMakeExamScreen extends StatefulWidget {
  const StartMakeExamScreen({super.key});

  @override
  State<StartMakeExamScreen> createState() => _StartMakeExamScreenState();
}

class _StartMakeExamScreenState extends State<StartMakeExamScreen> {
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
        } else if (_minutesLeft == 0 && _secondsLeft == 1) {
          Navigator.pop(context);
          context.read<MakeYourExamCubit>().currentLesson = null;
          context.read<MakeYourExamCubit>().selectedValueLevel = null;
          context.read<MakeYourExamCubit>().questionNum = 0;
          context.read<MakeYourExamCubit>().currentClassID = null;
          context.read<MakeYourExamCubit>().selectedValueLesson = null;
          context.read<MakeYourExamCubit>().classModel = null;
          context.read<MakeYourExamCubit>().currentHour = 0;
          context.read<MakeYourExamCubit>().currentMinutes = 0;
          context.read<MakeYourExamCubit>().selectedValueExamtype = null;

          ///nav pop
          setState(() {
            _isActive = true;
            _minutesLeft = context.read<MakeYourExamCubit>().totalMinutes();
            _secondsLeft = 0;
          });
        } else {
          _secondsLeft--;
        }
      });
    });
  }

  @override
  void initState() {
    setState(() {
      _isActive = true;
      _minutesLeft = context.read<MakeYourExamCubit>().totalMinutes();
      _secondsLeft = 0;
    });
    _startTimer();
    super.initState();
  }

  @override
  void dispose() {
    _timer!.cancel();
    _scrollController.dispose();
    //pop
    super.dispose();
  }

  bool isLoading = true;
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MakeYourExamCubit, MakeYourExamState>(
      listener: (context, state) {
        if (state is LoadingPostLessonAndClassOfMakeYourExam) {
          isLoading = true;
        } else {
          isLoading = false;
        }
      },
      builder: (context, state) {
        var cubit = context.read<MakeYourExamCubit>();
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            toolbarHeight: 0,
            backgroundColor: AppColors.secondPrimary,
          ),
          body: SafeArea(
            child: Stack(
              children: [
                cubit.allData!.questions.isEmpty
                    ? Scaffold(
                        body: Center(
                          child: Text('have_q'.tr()),
                        ),
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
                                                    (cubit.totalMinutes() * 60))
                                                .abs() /
                                            (cubit.totalMinutes() * 60),
                                        backgroundColor: Colors.transparent,
                                        center: SizedBox(
                                          width: 76.93,
                                          height: 25.50,
                                          child: Text(
                                            '$_minutesLeft:${_secondsLeft.toString().padLeft(2, '0')}',
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
                                                alignment: Alignment.center,
                                                child: Icon(
                                                    color: AppColors.blue5,
                                                    Icons
                                                        .arrow_back_ios_new_outlined),
                                              )),
                                          Flexible(
                                              fit: FlexFit.tight,
                                              child: Container(
                                                alignment: Alignment.center,
                                                child: ListView.builder(
                                                  shrinkWrap: true,
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  controller: _scrollController,
                                                  physics:
                                                      const BouncingScrollPhysics(),
                                                  itemCount: cubit.allData!
                                                      .questions.length,
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
                                                        padding: EdgeInsets.all(
                                                            getSize(context) /
                                                                100),
                                                        child: CircleAvatar(
                                                            backgroundColor: (cubit
                                                                            .allData!
                                                                            .questions[
                                                                                index3]
                                                                            .isSolving ==
                                                                        false &&
                                                                    index3 <
                                                                        index)
                                                                ? AppColors.red
                                                                : index3 ==
                                                                        index
                                                                    ? AppColors
                                                                        .blue5
                                                                    : cubit.allData!.questions[index3].isSolving ==
                                                                            true
                                                                        ? AppColors
                                                                            .greenDownloadColor
                                                                        : AppColors
                                                                            .unselectedTabColor,
                                                            child: Text(
                                                              (index3 + 1)
                                                                  .toString(),
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      getSize(context) /
                                                                          22,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: index3 ==
                                                                          index
                                                                      ? AppColors
                                                                          .white
                                                                      : (cubit.allData!.questions[index3].isSolving == false &&
                                                                              index3 <
                                                                                  index)
                                                                          ? AppColors
                                                                              .white
                                                                          : cubit.allData!.questions[index3].isSolving == true
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
                                                      offset: Offset(2, 3),
                                                      color: AppColors.gray4,
                                                      blurRadius: 8,
                                                      spreadRadius: 0.5)
                                                ],
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color: Colors.white),
                                            child: SingleChildScrollView(
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                      "${index + 1}-${cubit.allData!.questions[index].questionType == 'choice' ? '${'choose_q'.tr()}' : '${'write_q'.tr()}'}",
                                                      style: TextStyle(
                                                          fontSize:
                                                              getSize(context) /
                                                                  24,
                                                          fontWeight:
                                                              FontWeight.w900,
                                                          color:
                                                              AppColors.black)),
                                                  Text(
                                                      cubit
                                                          .allData!
                                                          .questions[index]
                                                          .question,
                                                      style: TextStyle(
                                                          fontSize:
                                                              getSize(context) /
                                                                  24,
                                                          fontWeight:
                                                              FontWeight.w900,
                                                          color:
                                                              AppColors.black)),
                                                  ListView.builder(
                                                    shrinkWrap: true,
                                                    physics:
                                                        const BouncingScrollPhysics(),
                                                    itemCount: cubit
                                                        .allData!
                                                        .questions[index]
                                                        .answers
                                                        .length,
                                                    itemBuilder:
                                                        (context, index2) {
                                                      return Container(
                                                          margin: EdgeInsets
                                                              .symmetric(
                                                                  vertical:
                                                                      getSize(context) /
                                                                          32),
                                                          padding: EdgeInsets.all(
                                                              getSize(context) /
                                                                  44),
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius.circular(
                                                                      getSize(context) /
                                                                          32),
                                                              color: AppColors
                                                                  .unselectedTabColor,
                                                              border: Border.all(
                                                                  color:
                                                                      AppColors
                                                                          .gray7,
                                                                  width: 2)),
                                                          child: RadioListTile(
                                                            activeColor:
                                                                AppColors.blue5,
                                                            value: cubit
                                                                .allData!
                                                                .questions[
                                                                    index]
                                                                .answers[index2]
                                                                .answer,
                                                            groupValue: cubit
                                                                .allData!
                                                                .questions[
                                                                    index]
                                                                .answers[index2]
                                                                .selectedValue,
                                                            onChanged: (e) {
                                                              setState(() {
                                                                cubit
                                                                    .allData!
                                                                    .questions[
                                                                        index]
                                                                    .answers
                                                                    .forEach(
                                                                        (answer) {
                                                                  answer.selectedValue =
                                                                      e.toString();
                                                                });
                                                              });
                                                              cubit
                                                                  .solveQuestion(
                                                                      index);
                                                              if (cubit
                                                                      .allData!
                                                                      .questions[
                                                                          index]
                                                                      .answers[
                                                                          index2]
                                                                      .selectedValue !=
                                                                  '') {
                                                                cubit.addUniqueApplyMakeExam(
                                                                    ApplyMakeExam(
                                                                  id: cubit
                                                                      .allData!
                                                                      .questions[
                                                                          index]
                                                                      .id,
                                                                  question: cubit
                                                                      .allData!
                                                                      .questions[
                                                                          index]
                                                                      .id
                                                                      .toString(),
                                                                  answer: cubit
                                                                      .allData!
                                                                      .questions[
                                                                          index]
                                                                      .answers[
                                                                          index2]
                                                                      .id
                                                                      .toString(),
                                                                ));
                                                              }
                                                            },
                                                            title: Row(
                                                              children: [
                                                                Text(
                                                                    cubit
                                                                        .allData!
                                                                        .questions[
                                                                            index]
                                                                        .answers[
                                                                            index2]
                                                                        .answerNumber,
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            getSize(context) /
                                                                                28,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w900,
                                                                        color: AppColors
                                                                            .black)),
                                                                SizedBox(
                                                                  width: getSize(
                                                                          context) /
                                                                      88,
                                                                ),
                                                                Text(
                                                                    cubit
                                                                        .allData!
                                                                        .questions[
                                                                            index]
                                                                        .answers[
                                                                            index2]
                                                                        .answer,
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            getSize(context) /
                                                                                24,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w900,
                                                                        color: AppColors
                                                                            .black)),
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
                                              if (cubit.allData!.questions
                                                      .length ==
                                                  cubit.details.length) {
                                                Navigator.pushReplacementNamed(
                                                    context,
                                                    Routes.resultOfExamScreen);
                                                print(
                                                    'all questions solved....................');
                                              } else {
                                                for (int i = 0;
                                                    i <
                                                        (cubit.allData!
                                                            .questions.length);
                                                    i++) {
                                                  for (int j = 0;
                                                      j < cubit.details.length;
                                                      j++) {
                                                    if (cubit.allData!
                                                            .questions[i].id ==
                                                        cubit.details[j].id) {
                                                      continue;
                                                    } else {
                                                      cubit.addUniqueApplyMakeExam(
                                                          ApplyMakeExam(
                                                              answer: '',
                                                              question: cubit
                                                                  .allData!
                                                                  .questions[i]
                                                                  .id
                                                                  .toString()));
                                                    }
                                                  }
                                                }
                                                print(cubit.details);
                                                Navigator.pushReplacementNamed(
                                                    context,
                                                    Routes.resultOfExamScreen);
                                              }

                                              // if (cubit.details.isEmpty) {
                                              //   errorGetBar(
                                              //       'answer_all_questions'
                                              //           .tr());
                                              // }
                                              // else if (cubit.details.length <
                                              //     cubit.questionNum) {
                                              //   errorGetBar(
                                              //       'answer_all_questions'
                                              //           .tr());
                                              // }
                                              // else {
                                              //   cubit.applyMakeExam(
                                              //       context: context,
                                              //       detailss: cubit.details);
                                              // }
                                            },
                                            child: Container(
                                                margin: EdgeInsets.all(
                                                    getSize(context) / 22),
                                                decoration: BoxDecoration(
                                                    color: AppColors
                                                        .greenDownloadColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            getSize(context) /
                                                                22)),
                                                padding: EdgeInsets.all(
                                                    getSize(context) / 28),
                                                child: Text(
                                                  'finish_exam'.tr(),
                                                  style: TextStyle(
                                                      color: AppColors.white),
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
