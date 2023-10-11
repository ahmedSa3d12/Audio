import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_mazoon/core/utils/getsize.dart';
import 'package:new_mazoon/core/widgets/my_svg_widget.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/utils/assets_manager.dart';
import '../../../core/widgets/network_image.dart';
import '../../../core/widgets/title_with_circle_background_widget.dart';
import '../../homePage/widget/home_page_app_bar_widget.dart';
import '../cubit/countdown_cubit.dart';

class CountdownScreen extends StatelessWidget {
  const CountdownScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CountdownCubit cubit = context.read<CountdownCubit>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.secondPrimary,
        toolbarHeight: 0,
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              top: 0,
              right: 0,
              left: 0,
              bottom: 0,
              child: BlocBuilder<CountdownCubit, CountdownState>(
                builder: (context, state) {
                  CountdownCubit cubit = context.read<CountdownCubit>();
                  if (state is CountDownLoading || state is CountDownError) {
                    return Center(child: CircularProgressIndicator());
                  } else if (DateTime.now()
                      .isAfter(DateTime.parse(cubit.countDown!.dateExam))) {
                    return Center(
                      child: Text('have_exams'.tr()),
                    );
                  } else {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: getSize(context) / 3.5),
                        TitleWithCircleBackgroundWidget(
                          title: 'countdown',
                          width: double.infinity,
                        ),
                        SizedBox(height: getSize(context) / 22),
                        ManageNetworkImage(
                          imageUrl: cubit.countDown!.image,
                          width: getSize(context) / 1.5,
                          height: getSize(context) / 3.5,
                        ),
                        SizedBox(height: getSize(context) / 22),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: getSize(context) / 30),
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color: AppColors.gray8,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.all(
                                    Radius.circular(getSize(context) / 22))),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: getSize(context) / 22,
                                  vertical: getSize(context) / 10),
                              child: Row(
                                children: [
                                  MySvgWidget(
                                      path: ImageAssets.time1Icon,
                                      imageColor: AppColors.blue5,
                                      size: getSize(context) / 22),
                                  SizedBox(
                                    width: getSize(context) / 32,
                                  ),
                                  Text(
                                    'date_exam'.tr(),
                                    style: TextStyle(
                                        fontSize: getSize(context) / 22,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.blue5),
                                  ),
                                  Expanded(
                                      child: Text(
                                    cubit.countDown!.dateExam,
                                    style: TextStyle(
                                        color: AppColors.black,
                                        fontSize: getSize(context) / 22),
                                    textAlign: TextAlign.end,
                                  ))
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: getSize(context) / 24,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              children: [
                                Text(
                                  'hour'.tr(),
                                  style: TextStyle(
                                      fontSize: getSize(context) / 22,
                                      color: AppColors.black),
                                ),
                                Container(
                                  width: getSize(context) / 3.5,
                                  height: getSize(context) / 3.5,
                                  child: SfCircularChart(
                                    palette: [AppColors.orangeThirdPrimary],
                                    annotations: <CircularChartAnnotation>[
                                      CircularChartAnnotation(
                                        widget: Center(
                                          child: Center(
                                            child: Container(
                                              child: Center(
                                                child: Text(
                                                  cubit.countDown!.hours
                                                      .toString(),
                                                  style: TextStyle(
                                                    color: AppColors
                                                        .orangeThirdPrimary,
                                                    fontSize:
                                                        getSize(context) / 35,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              height: getSize(context) / 7,
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: AppColors.orangelight),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                    series: <CircularSeries>[
                                      RadialBarSeries<int, String>(
                                        maximumValue: 100,
                                        innerRadius: '20',
                                        dataSource: [
                                          ((cubit.countDown!.hours * 100) / 24)
                                              .round()
                                        ],
                                        strokeWidth: 32,
                                        cornerStyle:
                                            ((cubit.countDown!.hours * 100) /
                                                        24) ==
                                                    100
                                                ? CornerStyle.bothFlat
                                                : CornerStyle.endCurve,
                                        trackColor: AppColors.orangelight,
                                        xValueMapper: (int data, _) =>
                                            data.toString(),
                                        yValueMapper: (int data, _) =>
                                            double.parse(data.toString()),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Text(
                                  'day'.tr(),
                                  style: TextStyle(
                                      fontSize: getSize(context) / 22,
                                      color: AppColors.black),
                                ),
                                Container(
                                  width: getSize(context) / 3.5,
                                  height: getSize(context) / 3.5,
                                  child: SfCircularChart(
                                    palette: [AppColors.blue],
                                    annotations: <CircularChartAnnotation>[
                                      CircularChartAnnotation(
                                        widget: Center(
                                          child: Center(
                                            child: Container(
                                              child: Center(
                                                child: Text(
                                                  cubit.countDown!.days
                                                      .toString(),
                                                  style: TextStyle(
                                                    color: AppColors.blue,
                                                    fontSize:
                                                        getSize(context) / 35,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              height: getSize(context) / 7,
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: AppColors.bluelight),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                    series: <CircularSeries>[
                                      RadialBarSeries<int, String>(
                                        maximumValue: 100,
                                        innerRadius: '20',
                                        dataSource: [
                                          ((cubit.countDown!.days * 100) / 30)
                                              .round()
                                        ],
                                        strokeWidth: 32,
                                        cornerStyle:
                                            ((cubit.countDown!.days * 100) /
                                                        30) ==
                                                    100
                                                ? CornerStyle.bothFlat
                                                : CornerStyle.endCurve,
                                        trackColor: AppColors.bluelight,
                                        xValueMapper: (int data, _) =>
                                            data.toString(),
                                        yValueMapper: (int data, _) =>
                                            double.parse(data.toString()),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Text(
                                  'month'.tr(),
                                  style: TextStyle(
                                      fontSize: getSize(context) / 22,
                                      color: AppColors.black),
                                ),
                                Container(
                                  width: getSize(context) / 3.5,
                                  height: getSize(context) / 3.5,
                                  child: SfCircularChart(
                                    palette: [AppColors.purple1],
                                    annotations: <CircularChartAnnotation>[
                                      CircularChartAnnotation(
                                        widget: Center(
                                          child: Center(
                                            child: Container(
                                              child: Center(
                                                child: Text(
                                                  cubit.countDown!.months
                                                      .toString(),
                                                  style: TextStyle(
                                                    color: AppColors.purple1,
                                                    fontSize:
                                                        getSize(context) / 35,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              height: getSize(context) / 7,
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color:
                                                      AppColors.purple1light),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                    series: <CircularSeries>[
                                      RadialBarSeries<int, String>(
                                          maximumValue: 100,
                                          innerRadius: '20',
                                          dataSource: [
                                            ((cubit.countDown!.months * 100) /
                                                    12)
                                                .round()
                                          ],
                                          strokeWidth: 32,
                                          cornerStyle:
                                              ((cubit.countDown!.months * 100) /
                                                          12) ==
                                                      100
                                                  ? CornerStyle.bothFlat
                                                  : CornerStyle.endCurve,
                                          xValueMapper: (int data, _) =>
                                              data.toString(),
                                          yValueMapper: (int data, _) =>
                                              double.parse(data.toString()),
                                          trackColor: AppColors.purple1light),
                                    ],
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: getSize(context) / 30),
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color: AppColors.blue5,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.all(
                                    Radius.circular(getSize(context) / 22))),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: getSize(context) / 22,
                                  vertical: getSize(context) / 30),
                              child: Column(
                                children: [
                                  Text(
                                    cubit.countDown!.title,
                                    style: TextStyle(
                                        fontSize: getSize(context) / 24,
                                        color: AppColors.blue5),
                                  ),
                                  SizedBox(
                                    height: getSize(context) / 24,
                                  ),
                                  Text(
                                    cubit.countDown!.description,
                                    style: TextStyle(
                                        fontSize: getSize(context) / 24,
                                        color: AppColors.liveExamGrayTextColor),
                                  ),
                                  SizedBox(
                                    height: getSize(context) / 24,
                                  ),
                                ],
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                              ),
                            ),
                            width: getSize(context),
                          ),
                        ),
                      ],
                    );
                  }
                },
              ),
            ),
            Positioned(
              top: 0,
              right: 0,
              left: 0,
              child: HomePageAppBarWidget(isHome: false),
            ),
          ],
        ),
      ),
    );
  }
}
