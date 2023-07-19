import 'package:flutter/material.dart';
import 'package:new_mazoon/core/utils/assets_manager.dart';
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
                    style: TextStyle(
                      color: darken(HexColor(model.backgroundColor!), 0.3),
                      fontWeight: FontWeight.w700,
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    model.name!,
                    style: TextStyle(
                      color: AppColors.grayLite,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            if (model.status == 'lock') ...{
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: darken(HexColor(model.backgroundColor!), 0.3),
                  borderRadius: BorderRadius.circular(80),
                ),
                child: Center(
                  child: MySvgWidget(
                    path: ImageAssets.lockIcon,
                    size: 16,
                    imageColor: AppColors.white,
                  ),
                ),
              ),
            } else ...{
              if (model.totalWatch == 100) ...{
                Container(
                  width: 60,
                  height: 60,
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
                      Directionality(
                        textDirection: TextDirection.ltr,
                        child: Text(
                          '100 %',
                          style: TextStyle(
                            color: AppColors.white,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              } else ...{
                SizedBox(
                  width: 70,
                  height: 70,
                  child: SfCircularChart(
                    margin: EdgeInsets.zero,
                    palette: [
                      darken(HexColor(model.backgroundColor!), 0.3),
                    ],
                    annotations: <CircularChartAnnotation>[
                      CircularChartAnnotation(
                        widget: Text(
                          model.totalWatch.toString(),
                          style: TextStyle(
                            color:
                                darken(HexColor(model.backgroundColor!), 0.3),
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                    series: <CircularSeries>[
                      RadialBarSeries<int, String>(
                        maximumValue: 100,
                        innerRadius: model.totalWatch.toString(),
                        dataSource: [model.totalWatch!],
                        cornerStyle: CornerStyle.endCurve,
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
              padding: const EdgeInsets.symmetric(
                vertical: 8.0,
                horizontal: 15,
              ),
              child: Container(
                width: 1,
                height: 100,
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
                        size: 22,
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
                              fontSize: 15,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                      Flexible(
                        child: Text(
                          'فيديو',
                          maxLines: 1,
                          overflow: TextOverflow.clip,
                          style: TextStyle(
                              color:
                                  darken(HexColor(model.backgroundColor!), 0.3),
                              fontSize: 15,
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
                        size: 22,
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
                              fontSize: 15,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                      Flexible(
                        child: Text(
                          'ساعه',
                          maxLines: 1,
                          overflow: TextOverflow.clip,
                          style: TextStyle(
                              color:
                                  darken(HexColor(model.backgroundColor!), 0.3),
                              fontSize: 15,
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
