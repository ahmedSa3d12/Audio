import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_mazoon/core/widgets/custom_button.dart';
import 'package:new_mazoon/core/widgets/my_svg_widget.dart';
import 'package:new_mazoon/features/video_details/cubit/video_details_cubit.dart';
import 'package:new_mazoon/features/video_details/widget/comments.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/utils/assets_manager.dart';
import '../../../core/widgets/circle_image_widget.dart';
import '../../../core/widgets/custom_textfield.dart';
import '../../../core/widgets/no_data_widget.dart';
import '../../../core/widgets/show_loading_indicator.dart';
import '../../../core/widgets/video_widget.dart';

class VideoDetails extends StatefulWidget {
  const VideoDetails({Key? key}) : super(key: key);

  @override
  State<VideoDetails> createState() => _VideoDetailsState();
}

class _VideoDetailsState extends State<VideoDetails> {
  @override
  Widget build(BuildContext context) {
    VideoDetailsCubit cubit = context.read<VideoDetailsCubit>();
    return BlocBuilder<VideoDetailsCubit, VideoDetailsState>(
      builder: (context, state) {
        if (state is VideoDetailsLoading) {
          return ShowLoadingIndicator();
        }
        if (state is VideoDetailsError) {
          return NoDataWidget(onclick: () {}, title: 'no_date');
        } else {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: AppColors.primary,
              title: Text(
                cubit.videoModel!.name??'',
                style: TextStyle(color: AppColors.white),
              ),
            ),
            body: Stack(
              children: [
                Positioned(
                  top: 0,
                  right: 0,
                  left: 0,
                  bottom: 50,
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      VideoWidget(
                        videoLink: cubit.videoModel!.link,
                        videoId: cubit.videoModel!.id,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Flexible(
                                child: Text(
                              cubit.videoModel!.name,
                              style: TextStyle(
                                  color: AppColors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            )),
                            Container(
                                child: Row(
                              children: [
                                Text(
                                  cubit.videoModel!.totalWatch.toString(),
                                  style: TextStyle(
                                      color: AppColors.gray1, fontSize: 14),
                                ),
                                SizedBox(
                                  width: 7,
                                ),
                                MySvgWidget(
                                  path: ImageAssets.eyeIcon,
                                  imageColor: AppColors.gray1,
                                  size: 30,
                                )
                              ],
                            )),
                            SizedBox(
                              width: 20,
                            ),
                            Container(
                                child: Row(
                              children: [
                                Text(
                                  cubit.videoModel!.totalLike.toString(),
                                  style: TextStyle(
                                      color: AppColors.gray1, fontSize: 14),
                                ),
                                SizedBox(
                                  width: 7,
                                ),
                                MySvgWidget(
                                  path: ImageAssets.like1Icon,
                                  imageColor: AppColors.greenDownloadColor,
                                  size: 20,
                                )
                              ],
                            )),
                            SizedBox(
                              width: 20,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 10,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.unselectedTabColor,
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: Row(
                              children: [
                                Flexible(
                                  child: Center(
                                    child: Column(
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: AppColors.blue),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: MySvgWidget(
                                              path: ImageAssets.like1Icon,
                                              imageColor: AppColors.white,
                                              size: 20,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 4,
                                        ),
                                        Text(
                                          "like".tr(),
                                          style: TextStyle(
                                            fontSize: 12,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Flexible(
                                  child: Center(
                                    child: Column(
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: AppColors.orange),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: MySvgWidget(
                                              path: ImageAssets.heartIcon,
                                              imageColor: AppColors.white,
                                              size: 20,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 4,
                                        ),
                                        Text(
                                          "favourite".tr(),
                                          style: TextStyle(
                                            fontSize: 12,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Flexible(
                                  child: Center(
                                    child: Column(
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: AppColors.purple1),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: MySvgWidget(
                                              path: ImageAssets.dowanload1Icon,
                                              imageColor: AppColors.white,
                                              size: 20,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 4,
                                        ),
                                        Text(
                                          "dowanload".tr(),
                                          style: TextStyle(
                                            fontSize: 12,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Flexible(
                                  child: Center(
                                    child: Column(
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: AppColors.primary),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: MySvgWidget(
                                              path: ImageAssets.attachmentIcon,
                                              imageColor: AppColors.white,
                                              size: 20,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 4,
                                        ),
                                        Text(
                                          "attachments".tr(),
                                          style: TextStyle(
                                            fontSize: 12,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Flexible(
                                  flex: 2,
                                  child: CustomButton(
                                    text: "report_about_mistake".tr(),
                                    color: AppColors.error,
                                    onClick: () {},
                                  ),
                                )
                              ],
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "comments".tr(),
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: AppColors.blue3),
                        ),
                      ),
                      Comments()
                    ],
                  ),
                ),
                Positioned(
                    bottom: 0,
                    right: 0,
                    left: 0,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Image.asset(
                            ImageAssets.userImage,
                            height: 40,
                            width: 40,
                          ),
                          Expanded(
                            child: CustomTextField(
                              title: 'add_comment'.tr(),
                              validatorMessage: 'add_comment_valid'.tr(),
                              backgroundColor: AppColors.commentBackground,
                              suffixWidget: IconButton(
                                icon: Icon(Icons.attach_file),
                                onPressed: () {},
                              ),
                              textInputType: TextInputType.text,
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                shape: BoxShape.circle, color: AppColors.blue4),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(
                                Icons.mic,
                                color: AppColors.white,
                              ),
                            ),
                          )
                        ],
                      ),
                    ))
              ],
            ),
          );
        }
      },
    );
  }
}
