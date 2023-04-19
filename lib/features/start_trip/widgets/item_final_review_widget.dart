import 'package:flutter/material.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/utils/assets_manager.dart';
import '../../../core/utils/hex_color.dart';
import '../../../core/widgets/download_icon_widget.dart';
import '../../../core/widgets/my_svg_widget.dart';
import '../../../core/widgets/network_image.dart';

class ItemOfFinalReviewWidget extends StatelessWidget {
  const ItemOfFinalReviewWidget({
    Key? key,
    required this.classNum,
    required this.imagePath,
    required this.mainColor,
    required this.type,
    required this.time,
  }) : super(key: key);
  final String classNum;
  final String imagePath;
  final String type;
  final int time;
  final Color mainColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: mainColor,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: 10),
                  MySvgWidget(
                    path: type == 'video'
                        ? ImageAssets.videoIcon
                        : ImageAssets.pdfIcon,
                    imageColor: AppColors.white,
                    size: 20,
                  ),
                ],
              ),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  classNum,
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          Spacer(),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              ManageNetworkImage(
                imageUrl: imagePath,
                height: 85,
                width: 85,
              ),
              Expanded(
                child: Row(

                  children: [
                    SizedBox(width: 16),
                    type == 'video'
                        ? MySvgWidget(
                            path: ImageAssets.clockIcon,
                            imageColor: AppColors.white,
                            size: 16,
                          )
                        : SizedBox(
                        width: 25,
                        height: 25,
                        child: DownloadIconWidget(color: mainColor)),
                    SizedBox(width: 10),
                    Text(
                      type == 'video'
                          ? '$time ساعه '
                          : ' 2 MB',
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Spacer(),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
