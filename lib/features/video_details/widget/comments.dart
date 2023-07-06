import 'package:easy_localization/easy_localization.dart' as trans;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart' as git;
import 'package:new_mazoon/core/models/comment_data_model.dart';
import 'package:new_mazoon/core/widgets/network_image.dart';
import 'package:new_mazoon/core/widgets/no_data_widget.dart';
import 'package:new_mazoon/core/widgets/show_loading_indicator.dart';
import 'package:new_mazoon/features/video_details/cubit/video_details_cubit.dart';
import 'package:new_mazoon/features/video_details/widget/replies.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/widgets/audio_player_widget.dart';
import '../../../core/widgets/circle_network_image.dart';

class Comments extends StatefulWidget {
  const Comments({Key? key}) : super(key: key);

  @override
  State<Comments> createState() => _CommentsState();
}

class _CommentsState extends State<Comments> {
  @override
  Widget build(BuildContext context) {
    VideoDetailsCubit cubit = context.read<VideoDetailsCubit>();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: BlocBuilder<VideoDetailsCubit, VideoDetailsState>(
        builder: (context, state) {
          if (state is CommentsLoading) {
            return ShowLoadingIndicator();
          } else if (state is CommentsError) {
            return NoDataWidget(
                onclick: () {
                  cubit.getcomments(cubit.videoModel!.id, "video_resource");
                },
                title:trans.tr("no_comments"));
          } else {
            if (cubit.comments != null && cubit.comments!.data.isNotEmpty) {
              return ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: cubit.comments!.data.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(

                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.unselectedTabColor,
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ManageCircleNetworkImage(
                                    height: 40,
                                    width: 40,
                                    imageUrl:
                                        cubit.comments!.data.elementAt(index).user.image,
                                  ),
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(cubit.comments!.data.elementAt(index).user.name,style: TextStyle(color: AppColors.blue3,fontSize: 14,fontWeight: FontWeight.bold),),
                                        cubit.comments!.data.elementAt(index).type=='text'? Text(cubit.comments!.data.elementAt(index).comment,style: TextStyle(color: AppColors.gray1,fontSize: 14),): cubit.comments!.data.elementAt(index).type=='file'?ManageNetworkImage(imageUrl: cubit.comments!.data.elementAt(index).image):AudioPlayer(source:cubit.comments!.data.elementAt(index).audio , onDelete: () {  },  type: 'onlyShow',)
                                      ],
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.topCenter,
                                      child: Text(cubit.comments!.data.elementAt(index).time,style: TextStyle(color: AppColors.orangeThirdPrimary,fontSize: 10),))
                                ],
                              ),
                              Align(
                                  alignment:trans.EasyLocalization.of(context)!.currentLocale!.languageCode=='ar'? Alignment.bottomLeft:Alignment.bottomRight,
                                  child: InkWell(
                                      onTap: () {
                                        openBottomSheet

                                          (cubit.comments!.data.elementAt(index));
                                      },
                                      child: Text(cubit.comments!.data.elementAt(index).replies.length.toString()+" "+trans.tr("replies"),style: TextStyle(fontSize: 14,color: AppColors.primary),)))
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            } else {
              return NoDataWidget(
                  onclick: () {
                    cubit.getcomments(cubit.videoModel!.id, "video_resource");
                  },
                  title: trans.tr("no_comments"));
            }
          }
        },
      ),
    );
  }
  void openBottomSheet(CommentsModel commentsModel) {
    context.read<VideoDetailsCubit>().commentsModel=commentsModel;

    git.Get.bottomSheet(
      Replies(),
      backgroundColor: Colors.white,
      elevation: 8,
      // shape: RoundedRectangleBorder(
      //   borderRadius: BorderRadius.circular(40),
      // ),
    );
  }
}
