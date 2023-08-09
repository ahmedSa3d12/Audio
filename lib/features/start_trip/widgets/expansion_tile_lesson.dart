import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_mazoon/features/sources_and_references/cubit/source_references_cubit.dart';
import 'package:new_mazoon/features/start_trip/cubit/start_trip_cubit.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/assets_manager.dart';
import '../../../core/utils/toast_message_method.dart';
import '../../../core/widgets/my_svg_widget.dart';
import '../../examdegreeaccreditation/cubit/examdegreedependcubit.dart';
import '../../lessons_of_class/cubit/lessons_class_cubit.dart';

class ExpansionTilLessonWidget extends StatefulWidget {
  final String title;
  final String type;
  bool isGray;
  ExpansionTilLessonWidget(
      {super.key,
      this.isGray = false,
      required this.title,
      required this.type});

  @override
  State<ExpansionTilLessonWidget> createState() =>
      _ExpansionTilLessonWidgetState();
}

class _ExpansionTilLessonWidgetState extends State<ExpansionTilLessonWidget> {
  bool isExpanded = false;

  @override
  void initState() {
    super.initState();
    title = widget.title;
  }

  String title = '';
  UniqueKey keyTile = UniqueKey();

  void expandTile() {
    setState(() {
      isExpanded = true;
      keyTile = UniqueKey();
    });
  }

  void shrinkTile() {
    setState(() {
      isExpanded = true;
      keyTile = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LessonsClassCubit, LessonsClassState>(
      builder: (context, state) {
        LessonsClassCubit cubit = context.read<LessonsClassCubit>();
        return Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(25),
                  child: ExpansionTile(
                    iconColor:
                        widget.isGray ? AppColors.black : AppColors.white,
                    key: keyTile,
                    trailing: Icon(
                      Icons.arrow_drop_down_outlined,
                      size: 35,
                      color: widget.isGray ? AppColors.black : AppColors.white,
                    ),
                    backgroundColor: widget.isGray
                        ? AppColors.unselectedTabColor
                        : AppColors.orangeThirdPrimary,
                    collapsedBackgroundColor: darken(
                        widget.isGray
                            ? AppColors.unselectedTabColor
                            : AppColors.orangeThirdPrimary,
                        0.05),
                    // textColor: AppColors.white,
                    title: Text(
                      title,
                      style: TextStyle(
                          color: widget.isGray
                              ? AppColors.black
                              : AppColors.white),
                    ),
                    children: [
                      ...List.generate(
                        cubit.lessons.length,
                        (index) => ListTile(
                          title: Text(
                            cubit.lessons[index].title!,
                            style: TextStyle(
                              color: title == cubit.lessons[index].title!
                                  ? AppColors.primary
                                  : widget.isGray
                                      ? AppColors.black
                                      : AppColors.white,
                              fontSize: title == cubit.lessons[index].title!
                                  ? 20
                                  : 16,
                              fontWeight: title == cubit.lessons[index].title!
                                  ? FontWeight.bold
                                  : null,
                            ),
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              cubit.lessons[index].status == 'lock'
                                  ? MySvgWidget(
                                      size: 16,
                                      imageColor: widget.isGray
                                          ? AppColors.black
                                          : AppColors.white,
                                      path: ImageAssets.lockIcon,
                                    )
                                  : SizedBox(),
                              SizedBox(width: 8),
                              widget.type == 'source'
                                  ? SizedBox()
                                  : Container(
                                      width: 25,
                                      height: 25,
                                      padding: EdgeInsets.all(2),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(25),
                                        color:
                                            title == cubit.lessons[index].title!
                                                ? AppColors.primary
                                                : AppColors.white,
                                      ),
                                      child: Center(
                                        child: Text(
                                          cubit.lessons[index].numOfVideos
                                              .toString(),
                                          style: TextStyle(
                                            color: title ==
                                                    cubit.lessons[index].title!
                                                ? AppColors.white
                                                : AppColors.orangeThirdPrimary,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                    ),
                            ],
                          ),
                          onTap: () {
                            if (cubit.lessons[index].status != 'lock') {
                              isExpanded ? shrinkTile() : expandTile();
                              title = cubit.lessons[index].title!;
                              setState(() {
                                title = cubit.lessons[index].title!;
                              });

                              if (widget.type == 'source') {
                                context
                                    .read<SourceReferencesCubit>()
                                    .sourcesAndReferencesDataById(
                                      cubit.lessons[index].id!,
                                    );
                              } else {
                                ///
                                cubit.getLessonsClassData(cubit.oneClass.id!,
                                    cubit.lessons[index].id!, context, true);
                                context
                                    .read<ExamDegreeAccreditationCubit>()
                                    .homeworkGradeAndRate(
                                        lessonId: cubit.lessons[index].id!);
                              }
                            } else {
                              toastMessage(
                                'هذا الفصل لم يفتح بعد',
                                context,
                                color: AppColors.error,
                              );
                            }
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Container(
                            width: double.infinity,
                            height: 2,
                            color: widget.isGray
                                ? AppColors.black
                                : AppColors.white),
                      ),
                      ListTile(
                        title: Text(
                          'امتحانات شاملة على الفصول',
                          style: TextStyle(
                            color: title == 'امتحانات شاملة على الفصول'
                                ? AppColors.primary
                                : AppColors.liveExamGrayTextColor,
                            fontSize:
                                title == 'امتحانات شاملة على الفصول' ? 20 : 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onTap: () {
                          isExpanded ? shrinkTile() : expandTile();
                          title = 'امتحانات شاملة على الفصول';
                          setState(() {
                            title = 'امتحانات شاملة على الفصول';
                          });
                        },
                      )
                    ],
                    onExpansionChanged: (value) {
                      setState(() {});
                    },
                  ),
                ),
              ),
            ),
            Visibility(
              visible: state is StartTripExamClassesLoading,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: CircularProgressIndicator(
                  color: AppColors.orangeThirdPrimary,
                ),
              ),
            )
          ],
        );
      },
    );
  }
}
