import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:new_mazoon/features/video_details/cubit/video_details_cubit.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/utils/getsize.dart';

import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/custom_textfield.dart';

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
            padding: EdgeInsets.all(getSize(context) / 44),
            child: SingleChildScrollView(
              child: Column(children: [
                Padding(
                  padding: EdgeInsets.all(getSize(context) / 44),
                  child: Row(
                    children: [
                      Flexible(
                        fit: FlexFit.tight,
                        child: Text(
                          'send_report'.tr() + " " + cubit.videoModel!.name,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: AppColors.liveExamGrayTextColor,
                              fontSize: getSize(context) / 22,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(
                          Icons.close_outlined,
                          size: getSize(context) / 12,
                          color: AppColors.liveExamGrayTextColor,
                        ),
                      )
                    ],
                  ),
                ),
                CustomTextField(
                    color1: AppColors.liveExamGrayTextColor,
                    title: 'Please_add_problem_discription'.tr(),
                    textInputType: TextInputType.text,
                    minLine: 4,
                    controller: cubit.report_control,
                    backgroundColor: AppColors.unselectedTabColor),
                SizedBox(
                  height: 20,
                ),
                CustomButton(
                  text: 'sent'.tr(),
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
