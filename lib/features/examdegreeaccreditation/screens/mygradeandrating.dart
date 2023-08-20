import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/widgets/title_with_circle_background_widget.dart';
import '../../homePage/widget/home_page_app_bar_widget.dart';

import '../cubit/examdegreedependcubit.dart';
import '../cubit/examdegreedependstate.dart';
import 'classexamsscreen.dart';
import 'comprehensiveexams.dart';
import 'homeworksscreen.dart';
import 'lessonexamsscreen.dart';

class MyGradeAndRating extends StatefulWidget {
  const MyGradeAndRating({super.key});

  @override
  State<MyGradeAndRating> createState() => _MyGradeAndRatingState();
}

class _MyGradeAndRatingState extends State<MyGradeAndRating>
    with TickerProviderStateMixin {
  List<String> titles = [
    'homeworks'.tr(),
    'lesson_exam'.tr(),
    'class_exam'.tr(),
    'comprehensive_exam'.tr()
  ];
  late TabController _tabController;
  @override
  void initState() {
    // context
    //     .read<ExamDegreeAccreditationCubit>()
    //     .homeworkGradeAndRate(lessonId: 1);
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _tabController
        .animateTo(context.read<ExamDegreeAccreditationCubit>().currentIndex);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExamDegreeAccreditationCubit,
        ExamDegreeAccreditationState>(
      builder: (context, state) {
        var cubit = context.read<ExamDegreeAccreditationCubit>();
        return Scaffold(
          appBar: AppBar(
            backgroundColor: AppColors.secondPrimary,
            toolbarHeight: 0,
          ),
          body: SafeArea(
            top: false,
            maintainBottomViewPadding: true,
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 105),
                    TitleWithCircleBackgroundWidget(title: 'grade_rate'),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          ...List.generate(
                            titles.length,
                            (index) => Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8.0,
                                vertical: 8,
                              ),
                              child: InkWell(
                                onTap: () {
                                  cubit.selectTap(index);
                                  print(cubit.currentIndex);
                                  _tabController.animateTo(index);
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 30,
                                    vertical: 10,
                                  ),
                                  decoration: BoxDecoration(
                                    color: cubit.currentIndex == index
                                        ? AppColors.orangeThirdPrimary
                                        : AppColors.unselectedTabColor,
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  child: Center(
                                    child: Text(
                                      titles[index],
                                      style: TextStyle(
                                        color: cubit.currentIndex == index
                                            ? AppColors.white
                                            : AppColors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: TabBarView(
                        controller: _tabController,
                        physics: NeverScrollableScrollPhysics(),
                        children: [
                          HomeWorksGradeAccredition(),
                          LessonExamsGradeAccredition(),
                          ClassExamsGradeAccredition(),
                          ComprehensiveExamGradeAccredition()
                        ],
                      ),
                    )
                  ],
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  left: 0,
                  child: HomePageAppBarWidget(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
