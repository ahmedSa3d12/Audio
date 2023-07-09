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
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/custom_textfield.dart';
import '../../../core/widgets/my_svg_widget.dart';
import 'choose_icon_dialog.dart';

class Report extends StatefulWidget {
  const Report({
    Key? key,
  }) : super(key: key);

  @override
  State<Report> createState() => _ReportState();
}

class _ReportState extends State<Report> {
  @override
  Widget build(BuildContext context) {
    VideoDetailsCubit cubit = context.read<VideoDetailsCubit>();
    return BlocBuilder<VideoDetailsCubit, VideoDetailsState>(
        builder: (context, state) {
      return AnimatedContainer(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(16), topLeft: Radius.circular(16))),
          duration: const Duration(milliseconds: 500),
          height: MediaQuery.of(context).size.height * .44,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(

              child: Column(children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Text(
                        "send_report" + " " + cubit.videoModel!.name,
                        style: TextStyle(
                            color: AppColors.liveExamGrayTextColor,
                            fontSize: 14,
                            fontWeight: FontWeight.bold),
                      ),
                      Expanded(child: Container()),
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(
                          Icons.close_outlined,
                          size: 30,
                          color: AppColors.liveExamGrayTextColor,
                        ),
                      )
                    ],
                  ),
                ),
                CustomTextField(
                    color1: AppColors.liveExamGrayTextColor,
                    title: "please_add_problem_discription",
                    textInputType: TextInputType.text,
                    minLine: 4,
                    controller: cubit.report_control,
                    backgroundColor: AppColors.unselectedTabColor),
                SizedBox(
                  height: 20,
                ),
                CustomButton(
                  text: "sent".tr(),
                  color: AppColors.orangeThirdPrimary,
                  onClick: () {
                    cubit.report(context);
                  },
                )
              ]),
            ),
          ));
    });
  }
}
