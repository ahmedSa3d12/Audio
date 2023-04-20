import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../../core/utils/app_colors.dart';

class LessonClassItemWidget extends StatelessWidget {
  const LessonClassItemWidget({
    Key? key,
    required this.mainColor,
    required this.title,
    required this.present,
  }) : super(key: key);

  final Color mainColor;
  final String title;
  final String present;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15),
      child: Container(
        padding: EdgeInsets.all(8),
        width: MediaQuery.of(context).size.width,
        height: 120,
        decoration: BoxDecoration(
          color: lighten(mainColor, 0.3),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Expanded(
              flex: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: mainColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    'شرح ازدواجية الموجة',
                    style: TextStyle(
                      color: AppColors.grayLite,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            if (present == '0') ...{
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: mainColor,
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
                width: 110,
                height: 110,
                child: SfCircularChart(
                  palette: [mainColor],
                  annotations: <CircularChartAnnotation>[
                    CircularChartAnnotation(
                      widget: Text(
                        present,
                        style: TextStyle(
                          color: AppColors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                  series: <CircularSeries>[
                    RadialBarSeries<int, String>(
                      maximumValue: 100,
                      innerRadius: '20',
                      dataSource: [int.parse(present)],
                      cornerStyle: CornerStyle.endCurve,
                      xValueMapper: (int data, _) => data.toString(),
                      yValueMapper: (int data, _) =>
                          double.parse(data.toString()),
                    )
                  ],
                ),
              )
            },
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 8.0,
                horizontal: 15,
              ),
              child: Container(
                width: 1,
                height: 100,
                color: mainColor,
              ),
            ),
            Expanded(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Icon(
                          Icons.slow_motion_video,
                          color: mainColor,
                          size: 22,
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8.0,
                          ),
                          child: Text(
                            '5',
                            style: TextStyle(
                              color: mainColor,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Text(
                          'فيديو',
                          style: TextStyle(
                            color: mainColor,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Icon(
                          Icons.access_time_outlined,
                          color: mainColor,
                          size: 22,
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8.0,
                          ),
                          child: Text(
                            '6',
                            style: TextStyle(
                              color: mainColor,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Text(
                          'ساعه',
                          style: TextStyle(
                            color: mainColor,
                            fontSize: 12,
                          ),
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
