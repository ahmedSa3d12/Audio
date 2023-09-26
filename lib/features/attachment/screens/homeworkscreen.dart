import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_mazoon/core/utils/hex_color.dart';
import 'package:new_mazoon/features/attachment/cubit/attachmentcubit.dart';
import 'package:new_mazoon/features/attachment/cubit/attachmentstate.dart';

import '../../../config/routes/app_routes.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/assets_manager.dart';
import '../../../core/utils/getsize.dart';
import '../../../core/widgets/my_svg_widget.dart';
import '../../examinstructions/cubit/examinstructions_cubit.dart';

class HomeWorkScreen extends StatefulWidget {
  HomeWorkScreen({this.lessonId, super.key});
  int? lessonId;
  @override
  State<HomeWorkScreen> createState() => _HomeWorkScreenState();
}

class _HomeWorkScreenState extends State<HomeWorkScreen> {
  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AttachmentCubit, AttachmentState>(
      listener: (context, state) {
        if (state is LoadingHomeworkttchmentState) {
          isLoading = true;
        } else if (state is SucessHomeworkAttchmentState) {
          isLoading = false;
        } else {
          isLoading = false;
        }
      },
      builder: (context, state) {
        var cubit = context.read<AttachmentCubit>();

        return (isLoading && cubit.homeworkLessonData == null)
            ? Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: Column(
                  children: [
                    InkWell(
                      onTap: () {
                        context.read<ExaminstructionsCubit>().examInstructions(
                            cubit.homeworkLessonData!.id, "online_exam");
                        Navigator.pushNamed(
                            context, Routes.examInstructionsRoute,
                            arguments: [cubit.homeworkLessonData!.id, "video"]);
                      },
                      child: Container(
                          padding: EdgeInsets.all(getSize(context) / 22),
                          width: double.infinity,
                          child: Container(
                            padding: EdgeInsets.all(getSize(context) / 22),
                            margin: EdgeInsets.all(getSize(context) / 100),
                            decoration: BoxDecoration(
                                color: HexColor(
                                    cubit.homeworkLessonData!.backgroundColor),
                                borderRadius: BorderRadius.circular(
                                    getSize(context) / 32)),
                            width: double.infinity,
                            child: Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      cubit.homeworkLessonData!.name,
                                      overflow: TextOverflow.clip,
                                      maxLines: 1,
                                      style: TextStyle(
                                          color: darken(
                                              HexColor(cubit.homeworkLessonData!
                                                  .backgroundColor),
                                              0.4),
                                          fontWeight: FontWeight.w700,
                                          fontSize: getSize(context) / 22),
                                    ),
                                    Container(
                                        padding: EdgeInsets.symmetric(
                                            vertical: getSize(context) / 22,
                                            horizontal: 0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal:
                                                      getSize(context) / 100),
                                              child: CircleAvatar(
                                                  radius: getSize(context) / 22,
                                                  backgroundColor:
                                                      AppColors.gray7,
                                                  child: Text(
                                                    '${cubit.homeworkLessonData!.numOfQuestion} Q',
                                                    overflow: TextOverflow.clip,
                                                    maxLines: 1,
                                                    style: TextStyle(
                                                        color: AppColors.white,
                                                        fontSize:
                                                            getSize(context) /
                                                                44),
                                                  )),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal:
                                                      getSize(context) / 100),
                                              child: CircleAvatar(
                                                  radius: getSize(context) / 22,
                                                  backgroundColor:
                                                      AppColors.gray7,
                                                  child: Text(
                                                    "${cubit.homeworkLessonData!.totalTime} min",
                                                    overflow: TextOverflow.clip,
                                                    maxLines: 1,
                                                    style: TextStyle(
                                                        color: AppColors.white,
                                                        fontSize:
                                                            getSize(context) /
                                                                44),
                                                  )),
                                            ),
                                            InkWell(
                                              onTap: () {
                                                cubit.favourite(
                                                    'online_exam',
                                                    cubit.homeworkLessonData!
                                                                .examsFavorite ==
                                                            "un_favorite"
                                                        ? 'favorite'
                                                        : 'un_favorite',
                                                    cubit.homeworkLessonData!
                                                        .id);
                                                print('fav');
                                              },
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal:
                                                        getSize(context) / 100),
                                                child: CircleAvatar(
                                                  radius: getSize(context) / 22,
                                                  backgroundColor:
                                                      AppColors.purple1,
                                                  child: MySvgWidget(
                                                    path: ImageAssets.heartIcon,
                                                    imageColor: cubit
                                                                .homeworkLessonData!
                                                                .examsFavorite ==
                                                            "un_favorite"
                                                        ? AppColors.white
                                                        : AppColors.red,
                                                    size: getSize(context) / 22,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            // Padding(
                                            //   padding: EdgeInsets.symmetric(
                                            //       horizontal:
                                            //           getSize(context) / 100),
                                            //   child: CircleAvatar(
                                            //     radius: getSize(context) / 22,
                                            //     backgroundColor:
                                            //         AppColors.skyColor,
                                            //     child: MySvgWidget(
                                            //       path: ImageAssets.videoIcon,
                                            //       imageColor: AppColors.white,
                                            //       size: getSize(context) / 22,
                                            //     ),
                                            //   ),
                                            // )
                                          ],
                                        )),
                                  ],
                                ),
                                Spacer(),
                                CircleAvatar(
                                  //color from back
                                  backgroundColor: darken(
                                      HexColor(cubit
                                          .homeworkLessonData!.backgroundColor),
                                      0.4),
                                  child: MySvgWidget(
                                      //check if 100% done of lock
                                      path: ImageAssets.doneIcon,
                                      imageColor: AppColors.white,
                                      size: getSize(context) / 22),
                                )
                              ],
                            ),
                          )),
                    )
                  ],
                ),
              );
      },
    );
  }
}
