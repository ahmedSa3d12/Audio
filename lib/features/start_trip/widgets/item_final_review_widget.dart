import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_mazoon/core/utils/getsize.dart';

import 'package:new_mazoon/features/video_details/cubit/video_details_cubit.dart';
import '../../../config/routes/app_routes.dart';
import '../../../core/models/home_page_model.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/assets_manager.dart';
import '../../../core/utils/change_to_mega_byte.dart';
import '../../../core/utils/hex_color.dart';
import '../../../core/widgets/download_icon_widget.dart';
import '../../../core/widgets/my_svg_widget.dart';
import '../../../core/widgets/network_image.dart';
import '../../../core/widgets/pdf_screen.dart';
import '../cubit/start_trip_cubit.dart';

class ItemOfFinalReviewWidget extends StatelessWidget {
  const ItemOfFinalReviewWidget({
    Key? key,
    required this.model,
  }) : super(key: key);
  final FinalReviewModel model;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        model.type == 'video'
            ? {
                context
                    .read<VideoDetailsCubit>()
                    .getVideoDetails(model.id!, "video_resource"),
                context
                    .read<VideoDetailsCubit>()
                    .getcomments(model.id!, "video_resource"),
                Navigator.pushNamed(context, Routes.videoDetailsScreenRoute,
                    arguments: {
                      'type': 'video_resource',
                      'videoId': model.id!,
                    })
              }
            : Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PdfScreen(
                    pdfTitle: model.name!,
                    pdfLink: model.pathFile!,
                  ),
                ),
              );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: HexColor(model.backgroundColor!),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: getSize(context) / 22),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(width: getSize(context) / 44),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: getSize(context) / 44),
                  child: MySvgWidget(
                      path: model.type == 'video'
                          ? ImageAssets.videoIcon
                          : ImageAssets.pdfIcon,
                      imageColor: AppColors.white,
                      size: getSize(context) / 18),
                ),
                Flexible(
                  child: Text(
                    model.name!,
                    overflow: TextOverflow.fade,
                    maxLines: 2,
                    style: TextStyle(
                      color: AppColors.white,
                      fontSize: getSize(context) / 26,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ManageNetworkImage(
                  imageUrl: model.image!,
                  height: getSize(context) / 6,
                  width: getSize(context) / 6,
                ),
                model.type == 'video'
                    ? Container(
                        // color: AppColors.red,
                        child: MySvgWidget(
                          path: ImageAssets.clockIcon,
                          imageColor: AppColors.white,
                          size: getSize(context) / 24,
                        ),
                      )
                    : SizedBox(),
                SizedBox(
                    width: model.type == 'video' ? getSize(context) / 100 : 0),
                Flexible(
                  child: Padding(
                    padding: EdgeInsets.all(model.type == 'video' ? 8.0 : 0),
                    child: Text(
                      model.type == 'video'
                          ? extractHourAndMinutes(model.time!).toString()
                          : changeToMegaByte(model.size.toString()),
                      textDirection: model.type == 'video'
                          ? TextDirection.rtl
                          : TextDirection.ltr,
                      style: TextStyle(
                        fontSize: getSize(context) / 26,
                        color: AppColors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: model.type != 'video' ? 10 : 0),
                model.type == 'video'
                    ? SizedBox()
                    : InkWell(
                        onTap: () {
                          context.read<StartTripCubit>().dowanload(model);
                        },
                        child: SizedBox(
                          width: getSize(context) / 44,
                          height: getSize(context) / 44,
                          child: model.progress != 0
                              ? CircularProgressIndicator(
                                  value: model.progress,
                                  backgroundColor: AppColors.white,
                                  color: AppColors.primary,
                                )
                              : DownloadIconWidget(
                                  color: HexColor(model.backgroundColor!),
                                ),
                        ),
                      ),
                SizedBox(width: model.type == 'video' ? 0 : 8),
              ],
            ),
            SizedBox(height: getSize(context) / 88),
          ],
        ),
      ),
    );
  }

  extractHourAndMinutes(String timeString) {
    List<String> timeParts = timeString.split(':');

    int hour = int.parse(timeParts[0]);
    int minute = int.parse(timeParts[1]);

    print("Hour: $hour");
    print("Minutes: $minute");
    return '$minute : $hour';
  }
}
