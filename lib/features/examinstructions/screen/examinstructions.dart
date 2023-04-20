import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:new_mazoon/core/widgets/custom_button.dart';
import 'package:new_mazoon/core/widgets/my_svg_widget.dart';
import 'package:new_mazoon/features/examinstructions/widget/instructionsettingwidget.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/utils/assets_manager.dart';
import '../../../core/widgets/network_image.dart';
import '../../homePage/widget/home_page_app_bar_widget.dart';

class ExamInstructions extends StatefulWidget {
  const ExamInstructions({Key? key}) : super(key: key);

  @override
  State<ExamInstructions> createState() => _ExamInstructionsState();
}

class _ExamInstructionsState extends State<ExamInstructions> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.secondPrimary,
        toolbarHeight: 0,
      ),
      body: SafeArea(
        top: false,
        maintainBottomViewPadding: true,
        child: Stack(
          children: [
            Positioned(
              top: 0,
              right: 0,
              left: 0,
              bottom: 0,
              child: Container(
                child: SingleChildScrollView(

                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 105),

                        Text(
                          "امتحان على الدرس الاول",
                          style: TextStyle(
                            fontSize: 16,
                            color: AppColors.black,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                        SizedBox(height: 20,),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            SizedBox(width: 20),
                            InstructionSettingWidget(
                                icon: ImageAssets.loadIcon,
                                color: AppColors.purple1,
                                color2: AppColors.purple1light,
                                title: "3 محاولات"),
                            InstructionSettingWidget(
                                icon: ImageAssets.timeIcon,
                                color: AppColors.blue,
                                color2: AppColors.bluelight,
                                title: "120 min"),
                            InstructionSettingWidget(
                                icon: ImageAssets.questionIcon,
                                color: AppColors.orange,
                                color2: AppColors.orangelight,
                                title: "50 Q"),
                            SizedBox(width: 20),
                          ],
                        ),
                        SizedBox(height: 20,),
                        Text(
                          "best_result".tr(),
                          style: TextStyle(
                              fontSize: 16,
                              color: AppColors.black,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                        SizedBox(height: 20,),
                    Container(
                      decoration: BoxDecoration(color: AppColors.bluelight,
                      borderRadius: BorderRadius.all(Radius.circular(15))
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            ManageNetworkImage(
                              imageUrl: ImageAssets.userImage,
                              width: 50,
                              height: 50,
                              borderRadius: 90,
                            ),
                            SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [

                                     Text(
                                    'mohamed',
                                      style: TextStyle(
                                          color: AppColors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),

                                  Padding(
                                    padding: const EdgeInsets.only(top: 4.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Text(
                                           "اسم المحافظه",
                                            style: TextStyle(
                                                color: AppColors.black,
                                                fontSize: 10,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Row(children: [
                                          MySvgWidget(path: ImageAssets.timeIcon, imageColor: AppColors.blue, size: 20),
                                          SizedBox(width: 3,),
                                          Text(
                                            "120 min",
                                            style: TextStyle(
                                                color: AppColors.blue,
                                                fontSize: 10,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],)
                                        // SizedBox(width: 10),
                                        ,
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: 90,
                              height: 90,

                              child: SfCircularChart(

                                palette: [AppColors.blue],
                                annotations: <CircularChartAnnotation>[
                                  CircularChartAnnotation(
                                 widget: Text(
                                      "20",
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
                                    dataSource: [20],
                                    strokeColor: AppColors.white,
                                    trackColor: AppColors.white,

                                    cornerStyle: CornerStyle.endCurve,
                                    xValueMapper: (int data, _) => data.toString(),
                                    yValueMapper: (int data, _) =>
                                        double.parse(data.toString()),
                                  )
                                ],
                              ),
                            ),
                            Row(children: [
                              MySvgWidget(path: ImageAssets.timeIcon, imageColor: AppColors.blue, size: 20),
                              SizedBox(width: 3,),
                              Text(
                                "منذ عام",
                                style: TextStyle(
                                    color: AppColors.blue,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],)
                          ],
                        ),
                      ),
                    ),
                        ListView(),
                        CustomButton(text: "جاهز للامتحان .... ابدأ الان", color: AppColors.orange, onClick: () {

                        },)

                      ],
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 0,
              right: 0,
              left: 0,
              child: HomePageAppBarWidget(),
            ),
          ],
        ),
      ),
    );
  }
}
