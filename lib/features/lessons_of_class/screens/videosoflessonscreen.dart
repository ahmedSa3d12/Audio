import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:new_mazoon/config/routes/app_routes.dart';
import 'package:percent_indicator/percent_indicator.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/utils/assets_manager.dart';
import '../../../core/utils/getsize.dart';
import '../../../core/widgets/my_svg_widget.dart';
import '../cubit/lessons_class_cubit.dart';

///الشرح الخاص بالدروس need make get data
class VideoLessonScreen extends StatefulWidget {
  const VideoLessonScreen({super.key});

  @override
  State<VideoLessonScreen> createState() => _VideoLessonScreenState();
}

class _VideoLessonScreenState extends State<VideoLessonScreen> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LessonsClassCubit, LessonsClassState>(
      listener: (context, state) {
        if (state is VideoLessonsLoading) {
          isLoading = true;
        } else {
          isLoading = false;
        }
      },
      builder: (context, state) {
        var cubit = context.read<LessonsClassCubit>();

        return Scaffold(
          body: isLoading
              ? Center(
                  child: CircularPercentIndicator(
                    radius: 10,
                    progressColor: AppColors.bink,
                  ),
                )
              : ListView.builder(
                  itemCount:
                      cubit.videosofLessons.length, //cubit.lessons.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.pushNamed(
                            context, Routes.videoDetailsScreenRoute,
                            arguments: {
                              "videoId": cubit.videosofLessons[index].id,
                              "type": "video_part"
                            });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            // color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(12)),
                        margin: EdgeInsets.all(5),
                        height: MediaQuery.of(context).size.width / 3,
                        child: Column(
                          children: [
                            Expanded(
                              flex: 4,
                              child: Row(
                                children: [
                                  Container(
                                    alignment: Alignment.topCenter,
                                    padding: EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 5),
                                    child: Text(
                                      '${index < 9 ? 0 : ""}${index + 1}',
                                      style: TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.w700,
                                          color: AppColors.unselectedTabColor),
                                    ),
                                  ),
                                  Container(
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(
                                          getSize(context) / 44),
                                      child: Image.asset(
                                        'assets/images/videoex.png',
                                        width: getSize(context) / 3,
                                      ),
                                    ),
                                  ),
                                  Column(
                                    children: [
                                      SizedBox(height: getSize(context) / 22),
                                      Text(
                                        cubit.videosofLessons[index].name,
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      Spacer(),
                                      Row(
                                        children: [
                                          Container(
                                              child: Row(
                                            children: [
                                              Text(
                                                cubit.videosofLessons[index]
                                                    .totalWatch
                                                    .toString(),
                                                // cubit.videoModel!.totalWatch.toString(),
                                                style: TextStyle(
                                                    color: AppColors.gray1,
                                                    fontSize: 14),
                                              ),
                                              SizedBox(
                                                width: getSize(context) / 88,
                                              ),
                                              MySvgWidget(
                                                path: ImageAssets.eyeIcon,
                                                imageColor: AppColors.gray1,
                                                size: getSize(context) / 18,
                                              ),
                                              SizedBox(
                                                width: getSize(context) / 44,
                                              ),
                                              Container(
                                                  child: Row(
                                                children: [
                                                  Text(
                                                    cubit.videosofLessons[index]
                                                        .totalLike
                                                        .toString(),
                                                    style: TextStyle(
                                                        color: AppColors.gray1,
                                                        fontSize: 14),
                                                  ),
                                                  SizedBox(
                                                    width:
                                                        getSize(context) / 88,
                                                  ),
                                                  MySvgWidget(
                                                    path: ImageAssets.like1Icon,
                                                    imageColor: AppColors
                                                        .greenDownloadColor,
                                                    size: getSize(context) / 18,
                                                  )
                                                ],
                                              )),
                                            ],
                                          )),
                                        ],
                                      ),
                                      SizedBox(
                                        height: getSize(context) / 16,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: getSize(context) / 44),
                                child: Row(
                                  children: [
                                    Flexible(
                                      child: LinearPercentIndicator(
                                        // width: MediaQuery.of(context).size.width / 1.1,
                                        lineHeight: getSize(context) / 66,
                                        barRadius: Radius.circular(
                                            getSize(context) / 22),
                                        backgroundColor: AppColors.grey2,
                                        percent: cubit.videosofLessons[index]
                                                .progress /
                                            100,
                                        isRTL: true,

                                        progressColor: (cubit
                                                        .videosofLessons[index]
                                                        .progress >
                                                    0 &&
                                                cubit.videosofLessons[index]
                                                        .progress <=
                                                    30)
                                            ? AppColors.red
                                            : (cubit.videosofLessons[index]
                                                            .progress >
                                                        30 &&
                                                    cubit.videosofLessons[index]
                                                            .progress <
                                                        65)
                                                ? AppColors.orange
                                                : AppColors.greenDownloadColor,
                                      ),
                                    ),
                                    SizedBox(width: getSize(context) / 18),
                                    cubit.videosofLessons[index].progress >= 100
                                        ? CircleAvatar(
                                            backgroundColor: AppColors.white,
                                            child: SvgPicture.asset(
                                              ImageAssets.doneIcon,
                                            ),
                                          )
                                        : cubit.videosofLessons[index].status ==
                                                'lock'
                                            ? CircleAvatar(
                                                backgroundColor:
                                                    AppColors.primary,
                                                child: MySvgWidget(
                                                  path: ImageAssets.lockIcon,
                                                  imageColor: AppColors.white,
                                                  size: getSize(context) / 28,
                                                ),
                                              )
                                            : CircleAvatar(
                                                backgroundColor:
                                                    AppColors.white,
                                                child: Container())
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
        );
      },
    );
  }
}
