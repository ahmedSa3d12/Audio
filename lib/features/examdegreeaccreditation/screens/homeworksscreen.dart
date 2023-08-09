import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_mazoon/core/utils/getsize.dart';

import '../../../core/utils/app_colors.dart';
import '../../start_trip/widgets/expansion_tile_lesson.dart';
import '../../start_trip/widgets/expansion_tile_widget.dart';
import '../cubit/examdegreedependcubit.dart';
import '../cubit/examdegreedependstate.dart';
import '../widgets/items_of_exam.dart';

class HomeWorksGradeAccredition extends StatefulWidget {
  HomeWorksGradeAccredition({super.key});

  @override
  State<HomeWorksGradeAccredition> createState() =>
      _HomeWorksGradeAccreditionState();
}

class _HomeWorksGradeAccreditionState extends State<HomeWorksGradeAccredition> {
  @override
  void initState() {
    context.read<ExamDegreeAccreditationCubit>().homeworksGrade = [];
    super.initState();
  }

  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ExamDegreeAccreditationCubit,
        ExamDegreeAccreditationState>(
      listener: (context, state) {
        if (state is LoadingGetHomeworkGrade) {
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
              cubit.homeworksGrade = [];
            },
            child: ListView(
              children: [
                SizedBox(height: getSize(context) / 22),
                ExpansionTileWidget(
                  title: 'choose_class'.tr(),
                  type: 'classes_exam',
                  isGray: true,
                  isHaveLesson: true,
                ),
                SizedBox(height: getSize(context) / 22),
                ExpansionTilLessonWidget(
                  title: 'choose_lesson'.tr(),
                  type: 'classes_exam',
                  isGray: true,
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
                    : ItemsOfDegreeAndRateWidget(
                        gradeList: cubit.homeworksGrade)
              ],
            ),
          ),
        ));
      },
    );
  }
}
