import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_mazoon/core/widgets/network_image.dart';
import 'package:new_mazoon/core/widgets/no_data_widget.dart';
import 'package:new_mazoon/core/widgets/show_loading_indicator.dart';
import 'package:new_mazoon/features/video_details/cubit/video_details_cubit.dart';

import '../../../core/models/comment_data_model.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/assets_manager.dart';
import '../../../core/widgets/audio_player_widget.dart';
import '../../../core/widgets/circle_network_image.dart';
import '../../../core/widgets/custom_textfield.dart';
import '../../../core/widgets/my_svg_widget.dart';
import 'choose_icon_dialog.dart';

class Replies extends StatefulWidget {
  const Replies({Key? key, }) : super(key: key);

  @override
  State<Replies> createState() => _RepliesState();
}

class _RepliesState extends State<Replies> {
  @override
  Widget build(BuildContext context) {
    VideoDetailsCubit cubit = context.read<VideoDetailsCubit>();
    return BlocBuilder<VideoDetailsCubit, VideoDetailsState>(
  builder: (context, state) {
    if(cubit.commentsModel!=null){
    cubit.commentsModel;
    return AnimatedContainer(
      decoration: BoxDecoration(borderRadius: BorderRadius.only(topRight: Radius.circular(16),topLeft: Radius.circular(16))),
      duration: const Duration(milliseconds: 500),
      height:MediaQuery.of(context).size.height*.44,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child:

   Stack(
       children:[
       Positioned(
         bottom: 20,
         top: 0,
         right: 0,
         left: 0,
         child: cubit.commentsModel!.replies.isNotEmpty?
     Padding(
         padding: const EdgeInsets.only(bottom: 50.0),
         child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: cubit.commentsModel!.replies.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: AppColors.unselectedTabColor,
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ManageCircleNetworkImage(
                                    height: 40,
                                    width: 40,
                                    imageUrl:
                                        cubit.commentsModel!.replies.elementAt(index).user.image,
                                  ),
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(cubit.commentsModel!.replies.elementAt(index).user.name,style: TextStyle(color: AppColors.blue3,fontSize: 14,fontWeight: FontWeight.bold),),
                                        cubit.commentsModel!.replies.elementAt(index).type=='text'? Text(cubit.commentsModel!.replies.elementAt(index).comment,style: TextStyle(color: AppColors.gray1,fontSize: 14),): cubit.commentsModel!.replies.elementAt(index).type=='file'?ManageNetworkImage(imageUrl: cubit.commentsModel!.replies.elementAt(index).image):AudioPlayer(source:cubit.commentsModel!.replies.elementAt(index).audio , onDelete: () {  },  type: 'onlyShow',)
                                      ],
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.topCenter,
                                      child: Text(cubit.commentsModel!.replies.elementAt(index).time,style: TextStyle(color: AppColors.orangeThirdPrimary,fontSize: 15),))
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
     )
           :NoDataWidget(
           onclick: () {
             cubit.getcomments(cubit.videoModel!.id, "video_resource");
           },
           title:"no_replies".tr()),
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
                     title: 'add_replay'.tr(),
                     controller: cubit.replay_control,
                     validatorMessage: 'add_replay_valid'.tr(),
                     backgroundColor: AppColors.commentBackground,
                     onchange: (p0) {
                       cubit.updateicone();
                     },
                     suffixWidget:InkWell(
                       onTap: () {
                         showDialog(
                           context: context,
                           builder: (ctx) => AlertDialog(
                             title: Padding(
                               padding: const EdgeInsets.symmetric(vertical: 5),
                               child: Text('choose'.tr()),
                             ),
                             contentPadding: EdgeInsets.zero,
                             content: SizedBox(
                               width: MediaQuery.of(context).size.width - 60,
                               child: Column(
                                 mainAxisSize: MainAxisSize.min,
                                 children: [
                                   ChooseIconDialog(
                                     title: 'camera'.tr(),
                                     icon: Icons.camera_alt,
                                     onTap: () {
                                       cubit.pickImage(type: 'camera', type1: '2');
                                       Navigator.of(context).pop();
                                       // Future.delayed(Duration(milliseconds: 500),
                                       //         () {
                                       //       showDialog(
                                       //         context: context,
                                       //         barrierDismissible: false,
                                       //         builder: (ctx) => AlertDialog(
                                       //           title: Padding(
                                       //             padding: const EdgeInsets.symmetric(
                                       //               vertical: 5,
                                       //             ),
                                       //             child: Text('photo'.tr()),
                                       //           ),
                                       //           contentPadding: EdgeInsets.zero,
                                       //           content: RecordWidget(
                                       //             type: 'image',
                                       //             sendType: type,
                                       //             id: id,
                                       //           ),
                                       //         ),
                                       //       );
                                       //     });
                                     },
                                   ),
                                   ChooseIconDialog(
                                     title: 'photo'.tr(),
                                     icon: Icons.photo,
                                     onTap: () {
                                       cubit.pickImage(type: 'photo', type1: '2');
                                       Navigator.of(context).pop();
                                       // Future.delayed(Duration(milliseconds: 500),
                                       //         () {
                                       //       showDialog(
                                       //         context: context,
                                       //         barrierDismissible: false,
                                       //         builder: (ctx) => AlertDialog(
                                       //           title: Padding(
                                       //             padding: const EdgeInsets.symmetric(
                                       //               vertical: 5,
                                       //             ),
                                       //             child: Text('photo'.tr()),
                                       //           ),
                                       //           contentPadding: EdgeInsets.zero,
                                       //           content: RecordWidget(
                                       //             type: 'image',
                                       //             sendType: type,
                                       //             id: id,
                                       //           ),
                                       //         ),
                                       //       );
                                       //     });
                                     },
                                   ),

                                 ],
                               ),
                             ),
                             actions: [
                               TextButton(
                                 onPressed: () {
                                   Navigator.pop(context);
                                 },
                                 child: Text('cancel'.tr()),
                               )
                             ],
                           ),
                         );
                       },
                       child: Padding(
                         padding: const EdgeInsets.all(8.0),
                         child: MySvgWidget(
                           path: ImageAssets.attachmentIcon,
                           imageColor: AppColors.white,
                           size: 10,

                         ),
                       ),
                     ),

                     textInputType: TextInputType.text,
                   ),
                 ),
                 InkWell(
                   onTap: () {
                     cubit.replay_control.text.isNotEmpty?  cubit.addreplay("text",'',''):  cubit.isRecording?cubit.stop(2):cubit.start();
                   },
                   child: Container(
                     decoration: BoxDecoration(
                         shape: BoxShape.circle, color: AppColors.blue4),
                     child: Padding(
                       padding: const EdgeInsets.all(8.0),
                       child: Icon(
                         cubit.replay_control.text.isNotEmpty?Icons.send:cubit.isRecording?Icons.stop: Icons.mic,
                         color: AppColors.white,
                       ),
                     ),
                   ),
                 )
               ],
             ),
           ))

]
      ),
    ));}
    else{
      return Container();
    }
  },
);
  }
}
