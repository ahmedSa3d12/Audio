import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:new_mazoon/core/utils/assets_manager.dart';
import 'package:new_mazoon/core/utils/getsize.dart';
import 'package:new_mazoon/core/utils/hex_color.dart';
import 'package:new_mazoon/core/utils/numformat.dart';
import 'package:new_mazoon/core/widgets/my_svg_widget.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../../core/models/lessons_model.dart';
import '../../../core/utils/app_colors.dart';

class LessonClassItemWidget extends StatelessWidget {
  const LessonClassItemWidget({
    Key? key,
    required this.model,
  }) : super(key: key);

  final AllLessonsModel model;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        padding: EdgeInsets.all(8),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.width / 3.5,
        decoration: BoxDecoration(
          color: HexColor(model.backgroundColor!),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    model.title!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: darken(HexColor(model.backgroundColor!), 0.3),
                      fontWeight: FontWeight.w700,
                      fontSize: getSize(context) / 24,
                    ),
                  ),
                  Text(
                    model.name!,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: AppColors.grayLite,
                      fontSize: getSize(context) / 26,
                    ),
                  ),
                ],
              ),
            ),
            if (model.status == 'lock') ...{
              Container(
                width: getSize(context) / 7,
                height: getSize(context) / 7,
                decoration: BoxDecoration(
                  color: darken(HexColor(model.backgroundColor!), 0.3),
                  borderRadius: BorderRadius.circular(80),
                ),
                child: Center(
                  child: MySvgWidget(
                    path: ImageAssets.lockIcon,
                    size: getSize(context) / 16,
                    imageColor: AppColors.white,
                  ),
                ),
              ),
            } else ...{
              if (model.totalWatch == 100) ...{
                Container(
                  width: getSize(context) / 7,
                  height: getSize(context) / 7,
                  decoration: BoxDecoration(
                    color: darken(HexColor(model.backgroundColor!), 0.3),
                    borderRadius: BorderRadius.circular(80),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.check,
                        color: AppColors.white,
                      ),
                      // Text(
                      //   '100 %',
                      //   style: TextStyle(
                      //     color: AppColors.white,
                      //     fontSize: getSize(context) / 18,
                      //   ),
                      // ),
                    ],
                  ),
                ),
              } else ...{
                SizedBox(
                  width: getSize(context) / 7,
                  height: getSize(context) / 7,
                  child: SfCircularChart(
                    margin: EdgeInsets.zero,
                    palette: [
                      darken(HexColor(model.backgroundColor!), 0.3),
                    ],
                    annotations: <CircularChartAnnotation>[
                      CircularChartAnnotation(
                        widget: Text(
                          '${model.totalWatch.toString() == "0" ? '0' : (double.parse(model.totalWatch.toString()) / double.parse(model.totalTimes.toString()) * 100).round()}%',
                          style: TextStyle(
                            color:
                                darken(HexColor(model.backgroundColor!), 0.3),
                            fontSize: getSize(context) / 24,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                    series: <CircularSeries>[
                      RadialBarSeries<int, String>(
                        maximumValue: 100,
                        innerRadius: '22',
                        dataSource: [
                          model.totalTimes == 0
                              ? 0
                              : (double.parse(model.totalWatch.toString()) /
                                      double.parse(
                                          model.totalTimes.toString()) *
                                      100)
                                  .round()
                        ],
                        cornerStyle: CornerStyle.endCurve,
                        // trackColor:
                        //     darken(HexColor(model.backgroundColor!), 0.3),

                        xValueMapper: (int data, _) => data.toString(),
                        yValueMapper: (int data, _) =>
                            double.parse(data.toString()),
                      )
                    ],
                  ),
                )
              },
            },
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: 8.0,
                horizontal: getSize(context) / 22,
              ),
              child: Container(
                width: 1,
                height: getSize(context) / 8,
                color: darken(HexColor(model.backgroundColor!), 0.3),
              ),
            ),
            Expanded(
              flex: 4,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.slow_motion_video,
                        color: darken(HexColor(model.backgroundColor!), 0.3),
                        size: getSize(context) / 16,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8.0,
                        ),
                        child: Text(
                          model.numOfVideos.toString(),
                          maxLines: 1,
                          overflow: TextOverflow.clip,
                          style: TextStyle(
                              color:
                                  darken(HexColor(model.backgroundColor!), 0.3),
                              fontSize: getSize(context) / 24,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                      Flexible(
                        child: Text(
                          'video'.tr(),
                          maxLines: 1,
                          overflow: TextOverflow.clip,
                          style: TextStyle(
                              color:
                                  darken(HexColor(model.backgroundColor!), 0.3),
                              fontSize: getSize(context) / 24,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.access_time_outlined,
                        color: darken(HexColor(model.backgroundColor!), 0.3),
                        size: getSize(context) / 16,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8.0,
                        ),
                        child: Text(
                          formatedTime(
                                  timeInSecond:
                                      int.parse(model.totalTimes.toString()))
                              .toStringAsFixed(1)
                              .toString(),
                          maxLines: 1,
                          overflow: TextOverflow.clip,
                          style: TextStyle(
                              color:
                                  darken(HexColor(model.backgroundColor!), 0.3),
                              fontSize: getSize(context) / 22,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                      Flexible(
                        child: Text(
                          'hours'.tr(),
                          maxLines: 1,
                          overflow: TextOverflow.clip,
                          style: TextStyle(
                              color:
                                  darken(HexColor(model.backgroundColor!), 0.3),
                              fontSize: getSize(context) / 22,
                              fontWeight: FontWeight.w400),
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
    );
  }
}
