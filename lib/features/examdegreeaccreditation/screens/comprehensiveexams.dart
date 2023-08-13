import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/utils/getsize.dart';
import '../../../core/utils/string_to_double.dart';
import '../cubit/examdegreedependcubit.dart';
import '../cubit/examdegreedependstate.dart';
import '../widgets/items_of_exam.dart';

class ComprehensiveExamGradeAccredition extends StatefulWidget {
  const ComprehensiveExamGradeAccredition({super.key});

  @override
  State<ComprehensiveExamGradeAccredition> createState() =>
      _ComprehensiveExamGradeAccreditionState();
}

class _ComprehensiveExamGradeAccreditionState
    extends State<ComprehensiveExamGradeAccredition> {
  @override
  void initState() {
    // context
    //     .read<ExamDegreeAccreditationCubit>()
    //     .comprehensiveExamsGradeAndRate();
    super.initState();
  }

  bool isLoading = true;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ExamDegreeAccreditationCubit,
        ExamDegreeAccreditationState>(
      listener: (context, state) {
        if (state is LoadingGetComprehensiveExamsGrade) {
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
              cubit.comprehensiveExamsGradeAndRate();
            },
            child: Column(
              children: [
                Flexible(
                  fit: FlexFit.tight,
                  child: ListView(
                    children: [
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
                          : ItemsOfDegreeAndRateWidget(
                              gradeList: cubit.comprehensiveExamsGrade!.degrees)
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
                                      'المستوي العام',
                                      maxLines: 2,
                                      overflow: TextOverflow.clip,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          color: AppColors.white,
                                          fontSize: getSize(context) / 20),
                                    ),
                                  ),
                                  Text(
                                    cubit.comprehensiveExamsGrade!
                                        .motivationalWord,
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
                                        cubit.homeworksGrade!.totalPer) /
                                    100,
                                center: Text(
                                  cubit.comprehensiveExamsGrade!.totalPer,
                                  style: TextStyle(
                                      color: AppColors.white,
                                      fontWeight: FontWeight.w700,
                                      fontSize: getSize(context) / 22),
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
