import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_mazoon/core/utils/toast_message_method.dart';
import 'package:new_mazoon/features/make_exam/cubit/state.dart';
import 'package:new_mazoon/features/make_exam/widget/dropdownfield.dart';

import '../../../config/routes/app_routes.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/getsize.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/title_with_circle_background_widget.dart';
import '../../homePage/widget/home_page_app_bar_widget.dart';
import '../cubit/cubit.dart';
import '../widget/dialog.dart';
import '../widget/dropdownfield2.dart';

class MakeYourExamScreen extends StatefulWidget {
  const MakeYourExamScreen({super.key});

  @override
  State<MakeYourExamScreen> createState() => _MakeYourExamScreenState();
}

class _MakeYourExamScreenState extends State<MakeYourExamScreen> {
  @override
  void initState() {
    context.read<MakeYourExamCubit>().getDataOfMakeExam();

    super.initState();
  }

  var key = GlobalKey<FormState>();

  bool isLoading = true; //true

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MakeYourExamCubit, MakeYourExamState>(
      listener: (context, state) {
        if (state is LoadingGetLessonAndClassOfMakeYourExam) {
          isLoading = true;
        } else {
          isLoading = false;
        }
      },
      builder: (context, state) {
        var cubit = context.read<MakeYourExamCubit>();
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
            Navigator.pop(context);
            return Future<bool>.value(false);
          },
          child: Scaffold(
            body: SafeArea(
                child: Stack(
              children: [
                isLoading
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : Form(
                        key: key,
                        child: ListView(
                          physics: const BouncingScrollPhysics(),
                          children: [
                            SizedBox(height: getSize(context) / 3.5),
                            TitleWithCircleBackgroundWidget(
                              title: 'make_exam'.tr(),
                            ),
                            SizedBox(height: getSize(context) / 30),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: getSize(context) / 22),
                              child: Text(
                                'choose_class'.tr(),
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                  color: AppColors.black,
                                  fontSize: getSize(context) / 24,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            Container(
                                height: getSize(context) / 3.5,
                                child: ListView.builder(
                                  physics: const BouncingScrollPhysics(),
                                  scrollDirection: Axis.horizontal,
                                  shrinkWrap: true,
                                  itemCount: cubit.allClassesAndLessons.length,
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                      onTap: () {
                                        cubit.currentClassID = cubit
                                            .allClassesAndLessons[index].id;
                                        cubit.classModel =
                                            cubit.allClassesAndLessons[index];
                                        print(cubit.currentClassID);
                                        setState(() {
                                          cubit.lessons.clear();

                                          cubit.selectedValueLesson = null;
                                          cubit.currentLesson = null;
                                          cubit.lessonId = null;
                                        });
                                        for (int i = 0;
                                            i <
                                                cubit
                                                    .allClassesAndLessons[index]
                                                    .lessons
                                                    .length;
                                            i++) {
                                          cubit.lessons.add(cubit
                                              .allClassesAndLessons[index]
                                              .lessons[i]);
                                          print(cubit
                                              .allClassesAndLessons[index]
                                              .lessons[i]
                                              .name);
                                          cubit.currentLesson = cubit
                                              .allClassesAndLessons[index]
                                              .lessons[i];
                                        }
                                      },
                                      child: Container(
                                        padding: EdgeInsets.all(
                                            getSize(context) / 100),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Flexible(
                                              fit: FlexFit.tight,
                                              child: CircleAvatar(
                                                radius: getSize(context) / 10,
                                                backgroundImage: NetworkImage(
                                                  cubit
                                                      .allClassesAndLessons[
                                                          index]
                                                      .image,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              height: getSize(context) / 8,
                                              width: getSize(context) / 4,
                                              child: Text(
                                                cubit
                                                    .allClassesAndLessons[index]
                                                    .name,
                                                textAlign: TextAlign.center,
                                                overflow: TextOverflow.clip,
                                                maxLines: 2,
                                                style: TextStyle(
                                                  color: AppColors.black,
                                                  fontSize:
                                                      getSize(context) / 28,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                )),
                            Container(
                              padding: EdgeInsets.all(getSize(context) / 22),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      showDilogofmakeexam(context, cubit);
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      width: getSize(context) / 2.5,
                                      height: getSize(context) / 6.5,
                                      decoration: ShapeDecoration(
                                        color: AppColors.switchColor,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                                      child: Text(
                                        'select_time'.tr(),
                                        textAlign: TextAlign.right,
                                        style: TextStyle(
                                          color: AppColors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: getSize(context) / 66),
                                  Text(
                                    '${cubit.currentMinutes < 10 ? '0' : ''}${cubit.currentMinutes} : ${cubit.currentHour < 10 ? '0' : ''}${cubit.currentHour}',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: AppColors.black,
                                      fontSize: getSize(context) / 20,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(getSize(context) / 22),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                      child: Text(
                                    'num_question'.tr(),
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                      color: AppColors.black,
                                      fontSize: getSize(context) / 20,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  )),
                                  SizedBox(width: getSize(context) / 32),
                                  IconButton(
                                      onPressed: () {
                                        cubit.deleteNewQuestion();
                                      },
                                      icon: Icon(
                                        CupertinoIcons.minus_circle,
                                        color: AppColors.primary,
                                        size: getSize(context) / 12,
                                      )),
                                  SizedBox(width: getSize(context) / 88),
                                  Flexible(
                                    child: Container(
                                        child: Text(
                                      cubit.questionNum.toString(),
                                      overflow: TextOverflow.fade,
                                      maxLines: 1,
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                        color: AppColors.black,
                                        fontSize: getSize(context) / 20,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    )),
                                  ),
                                  SizedBox(width: getSize(context) / 88),
                                  IconButton(
                                      onPressed: () {
                                        cubit.addNewQuestion();
                                      },
                                      icon: Icon(
                                        CupertinoIcons.add_circled,
                                        color: AppColors.primary,
                                        size: getSize(context) / 12,
                                      )),
                                ],
                              ),
                            ),
                            CustomDropDown2(
                              value: cubit.selectedValueLevel,
                              items: cubit.levels,
                              msg: 'level_msg'.tr(),
                              label: 'select_exam_level'.tr(),
                              onChanged: (v) {
                                setState(() {
                                  cubit.selectedValueLevel = v;
                                });
                                print(cubit.selectedValueLevel);
                              },
                            ),
                            SizedBox(height: getSize(context) / 44),
                            CustomDropDown2(
                              value: cubit.selectedValueExamtype,
                              items: cubit.examOn,
                              msg: 'exam_type_msg'.tr(),
                              label: 'exam_type'.tr(),
                              onChanged: (v) {
                                setState(() {
                                  cubit.selectedValueExamtype = v;
                                  print(cubit.selectedValueExamtype);
                                });
                              },
                            ),
                            SizedBox(height: getSize(context) / 44),
                            cubit.selectedValueExamtype == 'exam_on_lesson'.tr()
                                ? cubit.lessons.isEmpty
                                    ? Container()
                                    : CustomDropDown3(
                                        value: cubit.currentLesson,
                                        items: cubit.lessons,
                                        msg: 'choose_lesson_msg'.tr(),
                                        label: 'choose_lesson'.tr(),
                                        onChanged: (v) {
                                          setState(() {
                                            cubit.selectedValueLesson = v!.name;
                                            cubit.lessonId = v.id;
                                            cubit.currentLesson = v;

                                            ///
                                            print('............${v.id}..');
                                          });
                                        },
                                      )
                                : Container(),
                            SizedBox(height: getSize(context) / 22),
                            CustomButton(
                                height: getSize(context) / 8,
                                text: 'start_exam'.tr(),
                                textcolor: AppColors.white,
                                color: AppColors.switchColor,
                                paddingHorizontal: getSize(context) / 20,
                                borderRadius: getSize(context) / 24,
                                onClick: () {
                                  if (key.currentState!.validate()) {
                                    if (cubit.lessonId == null) {
                                      if (cubit.currentClassID != null) {
                                        ///apply exam on class
                                        if (cubit.questionNum == 0) {
                                          toastMessage(
                                              'msg_q_num'.tr(), context);
                                        } else {
                                          if (cubit.classModel!
                                                  .limitOfQuestions >
                                              cubit.questionNum) {
                                            if (cubit.totalMinutes() <= 0) {
                                              toastMessage(
                                                  'select_time'.tr(), context);
                                            } else {
                                              print(cubit.questionNum);
                                              print(cubit.classModel!
                                                  .limitOfQuestions);
                                              cubit.MakeYourExam(
                                                      context: context,
                                                      classId:
                                                          cubit.currentClassID)
                                                  .then((value) {
                                                print(
                                                    'exam level : ${cubit.selectedValueLevel}');
                                                print('class exam');
                                                Navigator.pushNamed(context,
                                                    Routes.startMakeExamScreen);

                                                ///set
                                                // cubit.currentLesson = null;
                                                // cubit.selectedValueLevel = null;
                                                // cubit.questionNum = 0;
                                                // cubit.currentClassID = null;
                                                // cubit.selectedValueLesson = null;
                                                // cubit.classModel = null;
                                                // cubit.currentHour = 0;
                                                // cubit.currentMinutes = 0;
                                                // cubit.selectedValueExamtype =
                                                //     null;
                                              });
                                            }

                                            ///apply exam on class
                                          } else {
                                            print(cubit.questionNum);
                                            print(cubit
                                                .classModel!.limitOfQuestions);
                                            toastMessage(
                                                'msg_num'.tr(), context);
                                          }
                                        }
                                      } else {
                                        toastMessage(
                                            'choose_class_msg'.tr(), context);
                                      }
                                    } else {
                                      ////////////////
                                      if (cubit.questionNum == 0) {
                                        toastMessage('msg_q_num'.tr(), context);
                                      } else {
                                        if (cubit.currentLesson!
                                                .limitOfQuestions >=
                                            cubit.questionNum) {
                                          //
                                          if (cubit.totalMinutes() <= 0) {
                                            toastMessage(
                                                'select_time'.tr(), context);
                                          } else {
                                            print(
                                                'your questions num ${cubit.questionNum}');
                                            print(
                                                'qestion available ${cubit.currentLesson!.limitOfQuestions}');
                                            cubit.MakeYourExam(
                                                    context: context,
                                                    lessonIdd: cubit.lessonId)
                                                .then((value) {
                                              print(
                                                  'exam level : ${cubit.selectedValueLevel}');
                                              print('class exam');
                                              Navigator.pushNamed(context,
                                                  Routes.startMakeExamScreen);
                                            });
                                          }
                                        } else {
                                          toastMessage('msg_num'.tr(), context);
                                        }
                                      }
                                    }
                                  }
                                }),
                            SizedBox(height: getSize(context) / 22),
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
            )),
          ),
        );
      },
    );
  }
}
