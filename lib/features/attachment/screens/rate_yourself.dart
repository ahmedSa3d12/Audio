import 'package:flutter/material.dart';
import 'package:new_mazoon/core/utils/app_colors.dart';
import 'package:new_mazoon/core/utils/assets_manager.dart';
import 'package:new_mazoon/core/utils/getsize.dart';
import 'package:new_mazoon/core/widgets/my_svg_widget.dart';
import 'package:percent_indicator/percent_indicator.dart';

class RateYourSelfScreen extends StatefulWidget {
  const RateYourSelfScreen({super.key});

  @override
  State<RateYourSelfScreen> createState() => _RateYourSelfScreenState();
}

class _RateYourSelfScreenState extends State<RateYourSelfScreen> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(getSize(context) / 32),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('نتيجة الاختبار',
                  style: TextStyle(
                    fontSize: getSize(context) / 32,
                    fontWeight: FontWeight.w700,
                  )),
            ),
            Stack(
              children: [
                CircularPercentIndicator(
                  backgroundColor: AppColors.offWiite,
                  radius: getSize(context) / 8,
                  lineWidth: getSize(context) / 32,
                  percent: 0.8,
                  center: new Text("20/30"),
                  progressColor: AppColors.greenDownloadColor,
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('ممتاز بس فيه أحسن ',
                  style: TextStyle(
                    fontSize: getSize(context) / 32,
                    fontWeight: FontWeight.w200,
                  )),
            ),
            Padding(
              padding: EdgeInsets.all(getSize(context) / 22),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Container(
                        height: getSize(context) / 10,
                        width: getSize(context) / 10,
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(getSize(context) / 66),
                            color: AppColors.green),
                        alignment: Alignment.center,
                        child: Text('10',
                            style: TextStyle(
                                fontSize: getSize(context) / 22,
                                fontWeight: FontWeight.w500,
                                color: AppColors.white)),
                      ),
                      Text('الصحيحه',
                          style: TextStyle(
                            fontSize: getSize(context) / 32,
                            fontWeight: FontWeight.w500,
                          )),
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        height: getSize(context) / 10,
                        width: getSize(context) / 10,
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(getSize(context) / 66),
                            color: AppColors.red),
                        alignment: Alignment.center,
                        child: Text('10',
                            style: TextStyle(
                                fontSize: getSize(context) / 22,
                                fontWeight: FontWeight.w500,
                                color: AppColors.white)),
                      ),
                      Text('الخطأ',
                          style: TextStyle(
                            fontSize: getSize(context) / 32,
                            fontWeight: FontWeight.w500,
                          )),
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        height: getSize(context) / 10,
                        width: getSize(context) / 10,
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(getSize(context) / 66),
                            color: AppColors.purple1),
                        alignment: Alignment.center,
                        child: Text('0',
                            style: TextStyle(
                                fontSize: getSize(context) / 22,
                                fontWeight: FontWeight.w500,
                                color: AppColors.white)),
                      ),
                      Text('المحاولات',
                          style: TextStyle(
                            fontSize: getSize(context) / 32,
                            fontWeight: FontWeight.w500,
                          )),
                    ],
                  )
                ],
              ),
            ),
            Text('اضغط  على اى سؤال بالاسفل لمراجعت اجابتك',
                style: TextStyle(
                  fontSize: getSize(context) / 32,
                  fontWeight: FontWeight.w700,
                )),
            SizedBox(height: getSize(context) / 44),
            GridView.builder(
              shrinkWrap: true,
              itemCount: 13,
              physics: const BouncingScrollPhysics(),
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 10),
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.all(getSize(context) / 100),
                  child: CircleAvatar(
                    radius: getSize(context) / 44,
                    backgroundColor: index % 3 == 0
                        ? AppColors.greenDownloadColor
                        : AppColors.red,
                    child: Text('${index + 1}',
                        style: TextStyle(
                            fontSize: getSize(context) / 32,
                            fontWeight: FontWeight.w700,
                            color: AppColors.white)),
                  ),
                );
              },
            ),
            SizedBox(height: getSize(context) / 44),
            Container(
              margin: EdgeInsets.all(getSize(context) / 32),
              padding: EdgeInsets.all(getSize(context) / 32),
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                    offset: Offset(2, 3),
                    color: AppColors.gray4,
                    blurRadius: 8,
                    spreadRadius: 0.5)
              ], borderRadius: BorderRadius.circular(10), color: Colors.white),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("1- اختر الاجابة الصحيحة :",
                      style: TextStyle(
                          fontSize: getSize(context) / 24,
                          fontWeight: FontWeight.w900,
                          color: AppColors.black)),
                  Text(
                      'عدد طرق اختيار عددين فرديين من 4 اعداد زوجية, 5 اعداد فردية = ..........',
                      style: TextStyle(
                          fontSize: getSize(context) / 28,
                          fontWeight: FontWeight.w700,
                          color: AppColors.black)),
                  Container(
                    margin:
                        EdgeInsets.symmetric(vertical: getSize(context) / 32),
                    padding: EdgeInsets.all(getSize(context) / 44),
                    decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(getSize(context) / 32),
                        color: AppColors.bink,
                        border:
                            Border.all(color: Colors.red.shade400, width: 2)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          backgroundColor: AppColors.white,
                          radius: getSize(context) / 22,
                          child: MySvgWidget(
                              path: ImageAssets.wrong,
                              imageColor: AppColors.red,
                              size: getSize(context) / 22),
                        ),
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                                "simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum",
                                style: TextStyle(
                                    fontSize: getSize(context) / 24,
                                    fontWeight: FontWeight.w900,

                                    ///check status
                                    color: AppColors.white)),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin:
                        EdgeInsets.symmetric(vertical: getSize(context) / 32),
                    padding: EdgeInsets.all(getSize(context) / 44),
                    decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(getSize(context) / 32),
                        color: Color(0xffeeeeee),
                        border: Border.all(color: Colors.grey, width: 2)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          backgroundColor: AppColors.white,
                          radius: getSize(context) / 22,
                          child: MySvgWidget(
                              path: ImageAssets.doneIcon,
                              imageColor: AppColors.greenDownloadColor,
                              size: getSize(context) / 22),
                        ),
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                                "simply dummy  an  essentially unchanged. It was popularis",
                                style: TextStyle(
                                    fontSize: getSize(context) / 24,
                                    fontWeight: FontWeight.w900,
                                    color: AppColors.black)),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
