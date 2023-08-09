import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/utils/getsize.dart';
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
    context
        .read<ExamDegreeAccreditationCubit>()
        .comprehensiveExamsGradeAndRate();
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
                        gradeList: cubit.comprehensiveExamsGrade)
              ],
            ),
          ),
        ));
      },
    );
  }
}
