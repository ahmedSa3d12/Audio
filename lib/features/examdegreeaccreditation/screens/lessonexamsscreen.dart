import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/utils/getsize.dart';
import '../../../core/widgets/no_data_widget.dart';
import '../../start_trip/widgets/expansion_tile_lesson.dart';
import '../../start_trip/widgets/expansion_tile_widget.dart';
import '../cubit/examdegreedependcubit.dart';
import '../cubit/examdegreedependstate.dart';
import '../widgets/items_of_exam.dart';

class LessonExamsGradeAccredition extends StatefulWidget {
  const LessonExamsGradeAccredition({super.key});

  @override
  State<LessonExamsGradeAccredition> createState() =>
      _LessonExamsGradeAccreditionState();
}

class _LessonExamsGradeAccreditionState
    extends State<LessonExamsGradeAccredition> {
  @override
  void initState() {
    context
        .read<ExamDegreeAccreditationCubit>()
        .lessonsExamGradeAndRate(lessonId: 0);
    // context.read<ExamDegreeAccreditationCubit>().lessonsExamGrade!.degrees = [];
    super.initState();
  }

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ExamDegreeAccreditationCubit,
        ExamDegreeAccreditationState>(
      listener: (context, state) {
        if (state is LoadingGetLessonExamGrade) {
          isLoading = true;
        } else {
          isLoading = false;
        }
      },
      builder: (context, state) {
        var cubit = context.read<ExamDegreeAccreditationCubit>();
        return Scaffold(
            body: Container(
          child: RefreshIndicator(
            onRefresh: () async {
              cubit.homeworksGrade!.degrees = [];
            },
            child: Column(
              children: [
                Flexible(
                  fit: FlexFit.tight,
                  child: ListView(
                    children: [
                      SizedBox(height: getSize(context) / 22),
                      ExpansionTileWidget(
                        title: 'choose_class'.tr(),
                        type: 'classes_exam',
                        isGray: true,
                        isLesson: true,
                        isHaveLesson: true,
                      ),
                      SizedBox(height: getSize(context) / 22),
                      ExpansionTilLessonWidget(
                        title: 'choose_lesson'.tr(),
                        type: 'classes_exam',
                        isGray: true,
                        isLesson: true,
                      ),
                      SizedBox(height: getSize(context) / 22),
                      isLoading
                          ? SizedBox(
                              height: MediaQuery.of(context).size.height / 2,
                              child: Center(
                                child: CircularProgressIndicator(
                                  color: AppColors.primary,
                                ),
                              ),
                            )
                          : cubit.lessonsExamGrade!.degrees == null ||
                                  cubit.lessonsExamGrade!.degrees!.isEmpty
                              ? NoDataWidget(
                                  onclick: () {
                                    cubit.lessonsExamGradeAndRate(
                                        lessonId: cubit.lessonsExamGradeid);
                                  },
                                  title: 'no_exam'.tr())
                              : ItemsOfDegreeAndRateWidget(
                                  gradeList:
                                      cubit.lessonsExamGrade!.degrees ?? [])
                    ],
                  ),
                ),
                Stack(
                  children: [
                    Container(
                      height: getSize(context) / 5,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: AppColors.greenDownloadColor,
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(getSize(context) / 22),
                              topLeft: Radius.circular(getSize(context) / 22))),
                    ),
                    Positioned(
                        left: -30,
                        bottom: -30,
                        child: CircleAvatar(
                          radius: getSize(context) / 12,
                          backgroundColor: AppColors.green2,
                        )),
                    Positioned(
                        right: -20,
                        bottom: -20,
                        child: CircleAvatar(
                          radius: getSize(context) / 12,
                          backgroundColor: AppColors.green2,
                        )),
                    Container(
                      height: getSize(context) / 5,
                      alignment: Alignment.center,
                      child: Row(
                        children: [
                          Flexible(
                            fit: FlexFit.tight,
                            child: Container(
                              alignment: Alignment.centerRight,
                              padding: EdgeInsets.all(getSize(context) / 44),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Flexible(
                                    fit: FlexFit.tight,
                                    child: Text(
                                      'general_level'.tr(),
                                      maxLines: 2,
                                      overflow: TextOverflow.clip,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          color: AppColors.white,
                                          fontSize: getSize(context) / 24),
                                    ),
                                  ),
                                  Text(
                                    cubit.lessonsExamGrade!.motivationalWord ??
                                        '',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        color: AppColors.white,
                                        fontSize: getSize(context) / 22),
                                  ),
                                  SizedBox(height: getSize(context) / 44)
                                ],
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: getSize(context) / 22),
                            child: ClipRRect(
                              borderRadius:
                                  BorderRadius.circular(getSize(context) / 12),
                              child: CircularPercentIndicator(
                                radius: getSize(context) / 12,
                                animation: true,
                                fillColor: AppColors.greenDownloadColor,
                                animationDuration: 1200,
                                lineWidth: getSize(context) / 44,
                                percent: double.parse(
                                        cubit.homeworksGrade!.totalPer ?? '0') /
                                    100,
                                center: Text(
                                  cubit.lessonsExamGrade!.totalPer ?? '',
                                  style: TextStyle(
                                      color: AppColors.white,
                                      fontWeight: FontWeight.w700,
                                      fontSize: getSize(context) / 24),
                                ),
                                circularStrokeCap: CircularStrokeCap.butt,
                                backgroundColor: AppColors.greenDownloadColor,
                                progressColor: AppColors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ));
      },
    );
  }
}
