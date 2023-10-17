import 'dart:async';
import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_mazoon/core/utils/getsize.dart';
import 'package:new_mazoon/core/widgets/music_animation.dart';
import '../../../core/models/applylessonexammodel.dart';
import '../../../core/utils/assets_manager.dart';
import '../../../core/widgets/audio_player_widget.dart';
import '../../../core/widgets/my_svg_widget.dart';
import '../../video_details/widget/choose_icon_dialog.dart';
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
  // List data = [];
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
          context.read<QuestionsLessonExamCubit>().tryAtEndOfExam(
              lessonId: widget.lessonId,
              context: context,
              type: widget.exam_type,
              time: _minutesLeft);
          context.read<QuestionsLessonExamCubit>().applyLessonExam(
              lessonId: widget.lessonId,
              minutesLeft: _minutesLeft,
              exam_type: widget.exam_type,
              context: context);

          setState(() {
            _isActive = true;
            _minutesLeft = context
                .read<QuestionsLessonExamCubit>()
                .questionOfLessonData!
                .quizMinute;
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

  bool isLoading = true;
  int index = 0;

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
        return WillPopScope(
          onWillPop: () {
            cubit.isRecording = false;
            cubit.imageFile = null;
            // cubit.questionOfLessonData = null;
            // cubit.imagePath = '';
            // cubit.audioPath = '';
            cubit.tryAtEndOfExam(
                lessonId: widget.lessonId,
                context: context,
                type: widget.exam_type,
                time: (cubit.questionOfLessonData!.quizMinute - _minutesLeft));
            Navigator.pop(context);
            return Future<bool>.value(true);
          },
          child: Scaffold(
            appBar: AppBar(
              elevation: 0,
              toolbarHeight: 0,
              backgroundColor: AppColors.secondPrimary,
            ),
            body: SafeArea(
              child: Stack(
                children: [
                  cubit.questionOfLessonData!.questions.isEmpty
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
                              // SizedBox(height: getSize(context) / 3.5),
                              SizedBox(height: getSize(context) / 8),
                              Flexible(
                                child: ListView(
                                  shrinkWrap: true,
                                  physics: const BouncingScrollPhysics(),
                                  children: [
                                    Container(
                                      height: getSize(context) / 12,
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
                                    Container(
                                      height: getSize(context) / 3,
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
                                        backgroundColor: Colors.transparent,
                                        center: SizedBox(
                                          width: getSize(context) / 4,
                                          height: getSize(context) / 12,
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
                                    ////number of questions >>>>>
                                    Container(
                                      height: getSize(context) / 10,
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
                                                        padding: EdgeInsets.all(
                                                            getSize(context) /
                                                                100),
                                                        child: CircleAvatar(
                                                            backgroundColor: (cubit
                                                                            .questionOfLessonData!
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
                                                                    : cubit.questionOfLessonData!.questions[index3].isSolving ==
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
                                                                      : (cubit.questionOfLessonData!.questions[index3].isSolving == false &&
                                                                              index3 <
                                                                                  index)
                                                                          ? AppColors
                                                                              .white
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
                                    ////questions >>>>>
                                    SingleChildScrollView(
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
                                                      "${index + 1}-${cubit.questionOfLessonData!.questions[index].questionType == 'choice' ? '${'choose_q'.tr()}' : '${'write_q'.tr()}'}",
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
                                                          .questionOfLessonData!
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
                                                  SizedBox(
                                                      height: getSize(context) /
                                                          44),

                                                  ///answer
                                                  cubit
                                                              .questionOfLessonData!
                                                              .questions[index]
                                                              .questionType ==
                                                          'text'
                                                      ? Container(
                                                          width:
                                                              double.infinity,
                                                          height:
                                                              getSize(context) /
                                                                  2,
                                                          decoration: BoxDecoration(
                                                              color: AppColors
                                                                  .unselectedTabColor,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          getSize(context) /
                                                                              22)),
                                                          child: ListView(
                                                            shrinkWrap: true,
                                                            physics:
                                                                const BouncingScrollPhysics(),
                                                            children: [
                                                              cubit
                                                                          .questionOfLessonData!
                                                                          .questions[
                                                                              index]
                                                                          .imagePath !=
                                                                      null
                                                                  ? Stack(
                                                                      alignment:
                                                                          Alignment
                                                                              .center,
                                                                      children: [
                                                                        Container(
                                                                          padding:
                                                                              EdgeInsets.symmetric(vertical: getSize(context) / 66),
                                                                          child:
                                                                              Image.file(
                                                                            File(
                                                                              cubit.questionOfLessonData!.questions[index].imagePath!,
                                                                            ),
                                                                            fit:
                                                                                BoxFit.contain,
                                                                            height:
                                                                                getSize(context) / 2.5,
                                                                          ),
                                                                        ),
                                                                        Positioned(
                                                                          top:
                                                                              5,
                                                                          right:
                                                                              5,
                                                                          child:
                                                                              IconButton(
                                                                            icon:
                                                                                Icon(
                                                                              Icons.delete,
                                                                              color: AppColors.red,
                                                                              size: getSize(context) / 18,
                                                                            ),
                                                                            onPressed:
                                                                                () {
                                                                              setState(() {
                                                                                cubit.questionOfLessonData!.questions[index].imagePath = null;
                                                                                cubit.questionOfLessonData!.questions[index].isSolving = false;
                                                                              });
                                                                            },
                                                                          ),
                                                                        )
                                                                      ],
                                                                    )
                                                                  : cubit.questionOfLessonData!.questions[index]
                                                                              .recordPath !=
                                                                          null
                                                                      ? Container(
                                                                          height:
                                                                              getSize(context) / 3,
                                                                          child:
                                                                              AudioPlayer(
                                                                            source:
                                                                                cubit.questionOfLessonData!.questions[index].recordPath!,
                                                                            onDelete:
                                                                                () {
                                                                              setState(() {
                                                                                cubit.questionOfLessonData!.questions[index].recordPath = null;
                                                                                cubit.questionOfLessonData!.questions[index].isSolving = false;
                                                                              });
                                                                            },
                                                                            type:
                                                                                'upload',
                                                                            color:
                                                                                Colors.red,
                                                                          ),
                                                                        )
                                                                      : TextField(
                                                                          controller: cubit
                                                                              .questionOfLessonData!
                                                                              .questions[index]
                                                                              .answerController,
                                                                          maxLines:
                                                                              3,
                                                                          decoration:
                                                                              InputDecoration(
                                                                            hintText:
                                                                                'enter_ans'.tr(),
                                                                            hintStyle:
                                                                                TextStyle(
                                                                              color: AppColors.black,
                                                                              fontSize: getSize(context) / 28,
                                                                              fontFamily: 'Cairo',
                                                                              fontWeight: FontWeight.w400,
                                                                              height: 0,
                                                                            ),
                                                                            border:
                                                                                InputBorder.none,
                                                                          ),
                                                                          onChanged:
                                                                              (value) {
                                                                            if (value.isNotEmpty) {
                                                                              cubit.solveQuestion(index);
                                                                              cubit.addUniqueApplyMakeExam(
                                                                                ApplyStudentExam(question: cubit.questionOfLessonData!.questions[index].id.toString(), timer: (cubit.questionOfLessonData!.quizMinute - _minutesLeft), answer: cubit.questionOfLessonData!.questions[index].answerController.text),
                                                                              );
                                                                            } else {
                                                                              setState(() {
                                                                                cubit.questionOfLessonData!.questions[index].isSolving = false;
                                                                              });
                                                                            }
                                                                          },
                                                                        ),
                                                              cubit
                                                                      .questionOfLessonData!
                                                                      .questions[
                                                                          index]
                                                                      .answerController
                                                                      .text
                                                                      .isNotEmpty
                                                                  ? Container()
                                                                  : Container(
                                                                      height:
                                                                          getSize(context) /
                                                                              10,
                                                                      child:
                                                                          Row(
                                                                        children: [
                                                                          SizedBox(
                                                                              width: getSize(context) / 44),
                                                                          cubit.questionOfLessonData!.questions[index].isSolving == true
                                                                              ? Container()
                                                                              : cubit.isRecording
                                                                                  ? InkWell(
                                                                                      onTap: () {
                                                                                        cubit.stopRecord(index);
                                                                                        cubit.questionOfLessonData!.questions[index].isSolving = false;
                                                                                      },
                                                                                      child: Container(
                                                                                        decoration: BoxDecoration(shape: BoxShape.circle, color: AppColors.white),
                                                                                        child: Padding(
                                                                                          padding: const EdgeInsets.all(8.0),
                                                                                          child: Icon(
                                                                                            Icons.close,
                                                                                            color: AppColors.red,
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                    )
                                                                                  : InkWell(
                                                                                      onTap: () {
                                                                                        showDialog(
                                                                                          context: context,
                                                                                          builder: (ctx) => AlertDialog(
                                                                                            title: Padding(
                                                                                              padding: const EdgeInsets.symmetric(vertical: 5),
                                                                                              child: Text(('choose'.tr())),
                                                                                            ),
                                                                                            contentPadding: EdgeInsets.zero,
                                                                                            content: SizedBox(
                                                                                              width: MediaQuery.of(context).size.width - 60,
                                                                                              child: Column(
                                                                                                mainAxisSize: MainAxisSize.min,
                                                                                                children: [
                                                                                                  ChooseIconDialog(
                                                                                                    title: ('camera'.tr()),
                                                                                                    icon: Icons.camera_alt,
                                                                                                    onTap: () {
                                                                                                      cubit.pickImage(
                                                                                                        index: index,
                                                                                                        type: 'camera',
                                                                                                        timer: (cubit.questionOfLessonData!.quizMinute - _minutesLeft),
                                                                                                      );
                                                                                                      Navigator.of(context).pop();
                                                                                                    },
                                                                                                  ),
                                                                                                  ChooseIconDialog(
                                                                                                    title: ('photo'.tr()),
                                                                                                    icon: Icons.photo,
                                                                                                    onTap: () {
                                                                                                      cubit.pickImage(
                                                                                                        index: index,
                                                                                                        type: 'photo',
                                                                                                        timer: (cubit.questionOfLessonData!.quizMinute - _minutesLeft),
                                                                                                      );
                                                                                                      Navigator.of(context).pop();
                                                                                                    },
                                                                                                  ),
                                                                                                ],
                                                                                              ),
                                                                                            ),
                                                                                            actions: [
                                                                                              TextButton(
                                                                                                onPressed: () {
                                                                                                  Navigator.pop(context);
                                                                                                },
                                                                                                child: Text(('cancel'.tr())),
                                                                                              )
                                                                                            ],
                                                                                          ),
                                                                                        );
                                                                                      },
                                                                                      child: CircleAvatar(
                                                                                        backgroundColor: AppColors.purple1,
                                                                                        child: MySvgWidget(path: ImageAssets.attachmentIcon, imageColor: AppColors.white, size: getSize(context) / 18),
                                                                                      ),
                                                                                    ),
                                                                          SizedBox(
                                                                              width: getSize(context) / 44),
                                                                          // Visibility(
                                                                          //     visible: cubit.isRecording,
                                                                          //     child: InkWell(
                                                                          //       onTap: () {
                                                                          //         cubit.stopRecord(index);
                                                                          //         cubit.questionOfLessonData!.questions[index].isSolving = false;
                                                                          //       },
                                                                          //       child: Container(
                                                                          //         decoration: BoxDecoration(shape: BoxShape.circle, color: AppColors.white),
                                                                          //         child: Padding(
                                                                          //           padding: const EdgeInsets.all(8.0),
                                                                          //           child: Icon(
                                                                          //             Icons.close,
                                                                          //             color: AppColors.red,
                                                                          //           ),
                                                                          //         ),
                                                                          //       ),
                                                                          //     )),
                                                                          cubit.questionOfLessonData!.questions[index].isSolving == true
                                                                              ? Container()
                                                                              : InkWell(
                                                                                  onTap: () {
                                                                                    cubit.questionOfLessonData!.questions[index].answerController.text.isNotEmpty
                                                                                        ? cubit.addUniqueApplyMakeExam(ApplyStudentExam(
                                                                                            question: cubit.questionOfLessonData!.questions[index].question,
                                                                                            timer: (cubit.questionOfLessonData!.quizMinute - _minutesLeft),
                                                                                          ))
                                                                                        : cubit.isRecording
                                                                                            ? cubit.stop(
                                                                                                index: index,
                                                                                                question: cubit.questionOfLessonData!.questions[index].question,
                                                                                                timer: (cubit.questionOfLessonData!.quizMinute - _minutesLeft),
                                                                                              )
                                                                                            : cubit.start();
                                                                                  },
                                                                                  child: Container(
                                                                                    decoration: BoxDecoration(shape: BoxShape.circle, color: AppColors.blue4),
                                                                                    child: Padding(
                                                                                      padding: const EdgeInsets.all(8.0),
                                                                                      child: Icon(
                                                                                        cubit.isRecording ? Icons.stop : Icons.mic,
                                                                                        color: AppColors.white,
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                          Flexible(
                                                                            child:
                                                                                Visibility(visible: cubit.isRecording, child: MusicList()),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                            ],
                                                          ),
                                                        )
                                                      //////////////options//////////////
                                                      : ListView.builder(
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
                                                                        ? cubit.addUniqueApplyMakeExam(ApplyStudentExam(
                                                                            timer: (cubit.questionOfLessonData!.quizMinute -
                                                                                _minutesLeft),
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
                                                                      Flexible(
                                                                        fit: FlexFit
                                                                            .tight,
                                                                        child: Text(
                                                                            cubit.questionOfLessonData!.questions[index].answers[index2].answer,
                                                                            style: TextStyle(fontSize: getSize(context) / 24, fontWeight: FontWeight.w900, color: AppColors.black)),
                                                                      ),
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
                                                minutesLeft: _minutesLeft,
                                                context: context,
                                                lessonId: widget.lessonId,
                                                exam_type: widget.exam_type,
                                              );
                                              cubit.tryAtEndOfExam(
                                                  lessonId: widget.lessonId,
                                                  context: context,
                                                  type: widget.exam_type,
                                                  time: cubit
                                                          .questionOfLessonData!
                                                          .quizMinute -
                                                      _minutesLeft);
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
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),

                  ///
                  // Positioned(
                  //   top: 0,
                  //   right: 0,
                  //   left: 0,
                  //   child: HomePageAppBarWidget(),
                  // ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
