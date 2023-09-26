import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_mazoon/core/utils/app_colors.dart';

import '../../../config/routes/app_routes.dart';
import '../../../core/models/lessons_model.dart';
import '../../../core/utils/assets_manager.dart';
import '../../../core/widgets/pdf_screen.dart';
import '../../examinstructions/cubit/examinstructions_cubit.dart';
import '../cubit/lessons_class_cubit.dart';
import '../widgets/lessonexamwidgey3.dart';

class LessonExamScreen extends StatefulWidget {
  LessonExamScreen({required this.model, Key? key}) : super(key: key);
  AllLessonsModel model;

  @override
  State<LessonExamScreen> createState() => _LessonExamScreenState();
}

class _LessonExamScreenState extends State<LessonExamScreen> {
  bool isloading = false;
  @override
  void initState() {
    context.read<LessonsClassCubit>().getExamsofLessonsData(widget.model.id!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LessonsClassCubit, LessonsClassState>(
      listener: (context, state) {
        if (state is ExamLessonsLoading) {
          isloading = true;
        } else {
          isloading = false;
        }
      },
      builder: (context, state) {
        LessonsClassCubit cubit = context.read<LessonsClassCubit>();
        return Container(
          decoration:
              (state is ExamLessonsLoading || cubit.examsofLessons.isNotEmpty)
                  ? null
                  : BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(ImageAssets.chooseClassMessageImage),
                        fit: BoxFit.contain,
                      ),
                    ),
          child: RefreshIndicator(
            onRefresh: () async {
              cubit.examsofLessons = [];
              cubit.getExamsofLessonsData(widget.model.id!);
            },
            child: ListView(
              children: [
                SizedBox(height: 20),
                state is ExamLessonsLoading
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
                          itemCount: cubit.examsofLessons.length,
                          itemBuilder: (BuildContext context, int index) {
                            return InkWell(
                              onTap: () {
                                if (cubit.examsofLessons[index].type ==
                                    'online') {
                                  context
                                      .read<ExaminstructionsCubit>()
                                      .examInstructions(
                                          cubit.examsofLessons[index].id,
                                          "online_exam");
                                  Navigator.pushNamed(
                                      context, Routes.examInstructionsRoute,
                                      arguments: [
                                        cubit.examsofLessons[index].id,
                                        "lesson"
                                      ]);
                                } else {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => PdfScreen(
                                        pdfTitle:
                                            cubit.examsofLessons[index].name,
                                        pdfLink: cubit.examsofLessons[index]
                                            .pdfExamUpload!,
                                      ),
                                    ),
                                  );
                                }
                              },
                              child: LessonsExamItemWidget(
                                index: index,
                                model: cubit.examsofLessons[index],
                              ),
                            );
                          },
                        ),
                      ),
              ],
            ),
          ),
        );
      },
    );
  }
}
