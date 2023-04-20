import 'package:flutter/material.dart';
import 'package:new_mazoon/core/widgets/network_image.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/utils/assets_manager.dart';
import '../../../core/widgets/lesson_paint_class.dart';
import '../../../test.dart';
import '../../homePage/widget/home_page_app_bar_widget.dart';
import '../widgets/lesson_class_item_widget.dart';
import 'dart:math' as math;

class LessonsClassScreen extends StatelessWidget {
  const LessonsClassScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              child: Column(
                children: [
                  SizedBox(height: 155),
                  SizedBox(
                    height: 155,
                    child: Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Stack(
                        children: [
                          Positioned(
                            top: 0,
                            left: 0,
                            bottom: 0,
                            child: Transform(
                              alignment: Alignment.center,
                              transform: Matrix4.rotationY(math.pi),
                              child: CustomPaint(
                                size: Size(
                                  MediaQuery.of(context).size.width * 0.62,
                                  115,
                                ),
                                painter: LessonPaintClass(Colors.transparent),
                                isComplex: true,
                                child: ManageNetworkImage(
                                  imageUrl:
                                      "https://elmazone.topbusiness.io/sliders/1.jpg",
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: CustomPaint(
                              size: Size(
                                180,
                                115,
                              ),
                              painter: MyPainter(Colors.blue),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Stack(
                              children: [
                                CustomPaint(
                                  size: Size(
                                    250,
                                    80,
                                  ),
                                  painter: MyPainter(darken(Colors.blue, 0.2)),
                                ),
                                Positioned(
                                  top: 6,
                                  left: 55,
                                  // top: 0,
                                  right: 15,
                                  child: Text(
                                    'ازدواجية الموجة والجسيم',
                                    style: TextStyle(
                                      color: AppColors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      shadows: <Shadow>[
                                        Shadow(
                                          offset: Offset(3.0, 3.0),
                                          blurRadius: 3.0,
                                          color: Color.fromARGB(255, 0, 0, 0),
                                        ),
                                        // Shadow(
                                        //   offset: Offset(10.0, 10.0),
                                        //   blurRadius: 8.0,
                                        //   color: Color.fromARGB(125, 0, 0, 255),
                                        // ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Positioned(
                            top: 0,
                            right: 0,
                            child: Text(
                              'الفصل الاول',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  LessonClassItemWidget(
                    mainColor: AppColors.orangeThirdPrimary,
                    title: 'الدرس الاول',
                    present: '0',
                  ),
                  LessonClassItemWidget(
                    mainColor: AppColors.skyColor,
                    title: 'الدرس الثانى',
                    present: '50',
                  ),
                  LessonClassItemWidget(
                    mainColor: AppColors.primary,
                    title: 'الدرس الثالث',
                    present: '80',
                  ),
                ],
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
