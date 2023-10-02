import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:new_mazoon/core/utils/getsize.dart';
import 'package:new_mazoon/core/utils/numformat.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../config/routes/app_routes.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/assets_manager.dart';
import '../../../core/widgets/my_svg_widget.dart';
import '../../../core/widgets/network_image.dart';

class ItemOfOneClassWidget extends StatelessWidget {
  const ItemOfOneClassWidget({
    Key? key,
    required this.classNum,
    required this.classTitle,
    required this.classPresentFinished,
    required this.lessonNum,
    required this.videoNum,
    required this.hourNum,
    required this.imagePath,
    required this.status,
    required this.mainColor,
    required this.classId,
  }) : super(key: key);

  final String classNum;
  final String classTitle;
  final String classPresentFinished;
  final String lessonNum;
  final String videoNum;
  final String hourNum;
  final String imagePath;
  final String status;
  final Color mainColor;
  final int classId;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: getSize(context) / 1.5,
      padding: EdgeInsets.all(5),
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.all(getSize(context) / 44),
            decoration: BoxDecoration(
                color: mainColor,
                borderRadius: BorderRadius.circular(getSize(context) / 32)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: getSize(context) / 88),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: getSize(context) / 22),
                  child: Text(
                    classNum,
                    maxLines: 1,
                    overflow: TextOverflow.clip,
                    style: TextStyle(
                        color: AppColors.white,
                        fontSize: getSize(context) / 24),
                  ),
                ),
                SizedBox(height: getSize(context) / 88),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: getSize(context) / 88),
                  child: Text(
                    classTitle,
                    maxLines: 1,
                    overflow: TextOverflow.clip,
                    style: TextStyle(
                        color: AppColors.white,
                        fontSize: getSize(context) / 28),
                  ),
                ),
                Row(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 3.9,
                      height: MediaQuery.of(context).size.width / 3.9,
                      child: SfCircularChart(
                        palette: [darken(mainColor, 0.08)],
                        annotations: <CircularChartAnnotation>[
                          CircularChartAnnotation(
                            widget: status == 'lock'
                                ? MySvgWidget(
                                    size: getSize(context) / 22,
                                    imageColor: AppColors.white,
                                    path: ImageAssets.lockIcon,
                                  )
                                : Text(
                                    classPresentFinished,
                                    maxLines: 1,
                                    overflow: TextOverflow.clip,
                                    style: TextStyle(
                                      color: AppColors.white,
                                      fontSize: getSize(context) / 28,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                          ),
                        ],
                        series: <CircularSeries>[
                          RadialBarSeries<int, String>(
                            maximumValue: 100,
                            innerRadius: '18',
                            dataSource: [int.parse(classPresentFinished)],
                            cornerStyle: classPresentFinished == '100'
                                ? CornerStyle.bothFlat
                                : CornerStyle.endCurve,
                            xValueMapper: (int data, _) => data.toString(),
                            yValueMapper: (int data, _) =>
                                double.parse(data.toString()),
                          )
                        ],
                      ),
                    ),
                    Flexible(
                      child: Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: getSize(context) / 44),
                            child: Container(
                              width: 2,
                              height: getSize(context) / 5.5,
                              color: AppColors.white,
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Flexible(
                                      child: Icon(
                                        Icons.sticky_note_2_outlined,
                                        color: AppColors.white,
                                        size: getSize(context) / 22,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: getSize(context) / 66,
                                      ),
                                      child: Text(
                                        lessonNum,
                                        maxLines: 1,
                                        overflow: TextOverflow.clip,
                                        style: TextStyle(
                                            color: AppColors.white,
                                            fontSize: getSize(context) / 28),
                                      ),
                                    ),
                                    Text(
                                      'lesson'.tr(),
                                      maxLines: 1,
                                      overflow: TextOverflow.clip,
                                      style: TextStyle(
                                          color: AppColors.white,
                                          fontSize: getSize(context) / 28),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Flexible(
                                      child: Icon(Icons.slow_motion_video,
                                          color: AppColors.white,
                                          size: getSize(context) / 28),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0,
                                      ),
                                      child: Text(
                                        videoNum,
                                        maxLines: 1,
                                        overflow: TextOverflow.clip,
                                        style: TextStyle(
                                            color: AppColors.white,
                                            fontSize: getSize(context) / 28),
                                      ),
                                    ),
                                    Text(
                                      'video'.tr(),
                                      maxLines: 1,
                                      overflow: TextOverflow.clip,
                                      style: TextStyle(
                                        color: AppColors.white,
                                        fontSize: getSize(context) / 28,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Icon(Icons.access_time_outlined,
                                        color: AppColors.white,
                                        size: getSize(context) / 28),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 5.0,
                                      ),
                                      child: Text(
                                        formatedTime(
                                                timeInSecond:
                                                    int.parse(hourNum))
                                            .toStringAsFixed(1)
                                            .toString(),
                                        maxLines: 1,
                                        overflow: TextOverflow.clip,
                                        style: TextStyle(
                                            color: AppColors.white,
                                            fontSize: getSize(context) / 28),
                                      ),
                                    ),
                                    Flexible(
                                      child: Text(
                                        'hours'.tr(),
                                        maxLines: 1,
                                        overflow: TextOverflow.clip,
                                        style: TextStyle(
                                            color: AppColors.white,
                                            fontSize: getSize(context) / 28),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: getSize(context) / 66),
                    child: Container(
                      height: 2,
                      width: getSize(context) / 1.5,
                      color: AppColors.white,
                    ),
                  ),
                ),
                Flexible(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        if (status == 'lock') ...{
                          Text(
                            'lesson_lock'.tr(),
                            maxLines: 1,
                            overflow: TextOverflow.clip,
                            style: TextStyle(
                              color: AppColors.white,
                              fontSize: getSize(context) / 30,
                              fontWeight: FontWeight.w600,
                            ),
                          )
                        } else ...{
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: getSize(context) / 44),
                            child: InkWell(
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  Routes.lessonClassScreenRoute,
                                  arguments: classId,
                                );
                              },
                              child: Container(
                                width: getSize(context) / 2,
                                height: getSize(context) / 8,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: AppColors.white, width: 2),
                                  borderRadius: BorderRadius.circular(50),
                                  color: darken(mainColor, 0.1),
                                ),
                                child: Center(
                                  child: Text(
                                    'start_studyy'.tr(),
                                    maxLines: 1,
                                    overflow: TextOverflow.clip,
                                    style: TextStyle(
                                      fontSize: getSize(context) / 24,
                                      color: AppColors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        }
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: -getSize(context) / 66,
            left: -getSize(context) / 66,
            child: Padding(
              padding: const EdgeInsets.all(0.0),
              child: ManageNetworkImage(
                imageUrl: imagePath,
                height: getSize(context) / 6.2,
                width: getSize(context) / 6.2,
                borderRadius: getSize(context) / 6.2,
              ),
            ),
          )
        ],
      ),
    );
  }
}
