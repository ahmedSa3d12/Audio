import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_mazoon/config/routes/app_routes.dart';
import 'package:percent_indicator/percent_indicator.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/assets_manager.dart';
import '../../../core/utils/getsize.dart';
import '../../../core/utils/toast_message_method.dart';
import '../../../core/widgets/my_svg_widget.dart';
import '../../../core/widgets/show_loading_indicator.dart';
import '../cubit/lessons_class_cubit.dart';

///الشرح الخاص بالدروس need make get data
class VideoLessonScreen extends StatefulWidget {
  const VideoLessonScreen({super.key});

  @override
  State<VideoLessonScreen> createState() => _VideoLessonScreenState();
}

class _VideoLessonScreenState extends State<VideoLessonScreen> {
  bool isLoading = true;
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
              ? Center(child: ShowLoadingIndicator())
              : ListView.builder(
                  itemCount:
                      cubit.videosofLessons.length, //cubit.lessons.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        ///
                        if (cubit.videosofLessons[index].status == 'lock') {
                          toastMessage(
                            'open_lesson'.tr(),
                            context,
                            color: AppColors.error,
                          );
                        } else {
                          Navigator.pushNamed(
                              context, Routes.videoDetailsScreenRoute,
                              arguments: {
                                "videoId": cubit.videosofLessons[index].id,
                                "type": "video_part"
                              });
                        }
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
                                          fontSize: getSize(context) / 22,
                                          fontWeight: FontWeight.w700,
                                          color: AppColors.unselectedTabColor),
                                    ),
                                  ),
                                  Stack(
                                    children: [
                                      Container(
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                              getSize(context) / 44),
                                          child: Image.network(
                                            ///
                                            cubit.videosofLessons[index]
                                                .background_image,
                                            width: getSize(context) / 3,
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        bottom: getSize(context) / 38,
                                        left: getSize(context) / 38,
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: AppColors.black,
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      getSize(context) / 100)),
                                          padding: EdgeInsets.all(
                                              getSize(context) / 100),
                                          child: Text(
                                            cubit.videosofLessons[index]
                                                .videoMinutes,
                                            style: TextStyle(
                                                color: AppColors.white,
                                                fontSize:
                                                    getSize(context) / 44),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  Flexible(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Flexible(
                                          fit: FlexFit.tight,
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                                top: getSize(context) / 88,
                                                left: getSize(context) / 100,
                                                right: getSize(context) / 100),
                                            child: Text(
                                              cubit.videosofLessons[index].name,
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                fontSize: getSize(context) / 26,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: getSize(context) / 22,
                                              horizontal:
                                                  getSize(context) / 100),
                                          child: Row(
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
                                                    width:
                                                        getSize(context) / 88,
                                                  ),
                                                  MySvgWidget(
                                                    path: ImageAssets.eyeIcon,
                                                    imageColor: AppColors.gray1,
                                                    size: getSize(context) / 18,
                                                  ),
                                                  SizedBox(
                                                    width:
                                                        getSize(context) / 44,
                                                  ),
                                                  Container(
                                                      child: Row(
                                                    children: [
                                                      Text(
                                                        cubit
                                                            .videosofLessons[
                                                                index]
                                                            .totalLike
                                                            .toString(),
                                                        style: TextStyle(
                                                            color:
                                                                AppColors.gray1,
                                                            fontSize: 14),
                                                      ),
                                                      SizedBox(
                                                        width:
                                                            getSize(context) /
                                                                88,
                                                      ),
                                                      MySvgWidget(
                                                        path: ImageAssets
                                                            .like1Icon,
                                                        imageColor: AppColors
                                                            .greenDownloadColor,
                                                        size: getSize(context) /
                                                            18,
                                                      )
                                                    ],
                                                  )),
                                                ],
                                              )),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
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
                                        lineHeight: getSize(context) / 66,
                                        barRadius: Radius.circular(
                                            getSize(context) / 22),
                                        backgroundColor: AppColors.grey2,
                                        percent: cubit.videosofLessons[index]
                                                    .progress <
                                                0
                                            ? 0
                                            : cubit.videosofLessons[index]
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
                                            backgroundColor:
                                                AppColors.greenDownloadColor,
                                            child: MySvgWidget(
                                                path: ImageAssets.doneIcon,
                                                imageColor: AppColors.white,
                                                size: getSize(context) / 28))
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
                                                    AppColors.transparent,
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
