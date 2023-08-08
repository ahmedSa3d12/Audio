import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_mazoon/core/utils/getsize.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/utils/assets_manager.dart';

import '../../start_trip/widgets/expansion_tile_widget.dart';
import '../cubit/examdegreedependcubit.dart';
import '../cubit/examdegreedependstate.dart';

class HomeWorksGradeAccredition extends StatefulWidget {
  const HomeWorksGradeAccredition({super.key});

  @override
  State<HomeWorksGradeAccredition> createState() =>
      _HomeWorksGradeAccreditionState();
}

class _HomeWorksGradeAccreditionState extends State<HomeWorksGradeAccredition> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExamDegreeAccreditationCubit,
        ExamDegreeAccreditationState>(
      builder: (context, state) {
        var cubit = context.read<ExamDegreeAccreditationCubit>();
        return Scaffold(
            body: Container(
          // decoration: (state is loadingGetHomeworksExamDegreeAccreditation ||
          //         cubit.homeworks.isNotEmpty)
          //     ? null
          //     : BoxDecoration(
          //         image: DecorationImage(
          //           image: AssetImage(ImageAssets.chooseClassMessageImage),
          //           fit: BoxFit.contain,
          //         ),
          //       ),
          child: RefreshIndicator(
            onRefresh: () async {
              cubit.homeworks = [];
              // cubit.getExamClassesData();
            },
            child: ListView(
              children: [
                SizedBox(height: getSize(context) / 22),
                ExpansionTileWidget(
                  title: 'اختر الفصل',
                  type: 'classes_exam',
                  isGray: true,
                ),
                SizedBox(height: getSize(context) / 22),
                ExpansionTileWidget(
                  title: 'اختر الفصل',
                  type: 'classes_exam',
                  isGray: true,
                ),
                SizedBox(height: getSize(context) / 22),
                state is loadingGetHomeworksExamDegreeAccreditation
                    ? SizedBox(
                        height: MediaQuery.of(context).size.height / 2,
                        child: Center(
                          child: CircularProgressIndicator(
                            color: AppColors.primary,
                          ),
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: GridView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio: 0.70,
                            mainAxisSpacing: 12,
                            crossAxisSpacing: 20,
                            crossAxisCount: 2,
                          ),
                          itemCount: cubit.homeworks.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              height: 20,
                              width: double.infinity,
                              color: AppColors.bink,
                            );
                          },
                        ),
                      ),
              ],
            ),
          ),
        ));
      },
    );
  }
}
