import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:get/get.dart';
import 'package:easy_localization/easy_localization.dart' as trans;
import 'package:new_mazoon/core/utils/assets_manager.dart';
import 'package:popover/popover.dart';

import '../../test.dart';
import '../utils/app_colors.dart';
import 'RPSCustom_painter_widgte.dart';

class CallUsWidget extends StatefulWidget {
  CallUsWidget({Key? key}) : super(key: key);

  @override
  State<CallUsWidget> createState() => _CallUsWidgetState();
}

class _CallUsWidgetState extends State<CallUsWidget> {
  double _height = 300;
  double _listHeight = 0;
  bool isHeight = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      height: _height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppColors.primary,
            AppColors.litePrimary,
            AppColors.white,
          ],
        ),
      ),
      duration: const Duration(milliseconds: 500),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 18),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  'أهلا aya',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.white),
                ),
              ),
              IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: Icon(
                  Icons.close,
                  size: 28,
                  color: AppColors.white,
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              trans.tr('contact_us_from'),
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.white),
            ),
          ),
          SizedBox(height: 45),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(width: 0),
              Image.asset(
                ImageAssets.callUsWhatsappImage,
                width: 70,
                height: 70,
              ),
              InkWell(
                onTap: () {
                  showPopover(
                    context: context,
                    bodyBuilder: (context) => Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        children: [
                          Icon(
                            Icons.call,
                            color: AppColors.blueLiteColor,
                            size: 30,
                          ),
                          SizedBox(width: 20),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  '01090439660',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  'يوميا من الساعة 10 صباحا حتى 9 مساء',
                                  style: TextStyle(fontSize: 16),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    onPop: () => print('Popover was popped!'),
                    direction: PopoverDirection.bottom,
                    backgroundColor: Colors.white,
                    width: 200,
                    height: 250,
                    arrowHeight: 40,
                    arrowWidth: 30,
                  );
                },
                child: Image.asset(
                  ImageAssets.callUsSmsImage,
                  width: 70,
                  height: 70,
                ),
              ),
              Image.asset(
                ImageAssets.callUsMessengerImage,
                width: 70,
                height: 70,
              ),
              InkWell(
                onTap: () {
                  if (isHeight) {
                    setState(() {
                      _height = 300;
                      _listHeight = 0;
                      isHeight = !isHeight;
                    });
                  } else {
                    setState(() {
                      _height = 500;
                      _listHeight = 250;
                      isHeight = !isHeight;
                    });
                  }
                },
                child: Image.asset(
                  ImageAssets.callUsCallImage,
                  width: 70,
                  height: 70,
                ),
              ),
              SizedBox(width: 0),
            ],
          ),
          // SizedBox(height: 30),
          AnimatedContainer(
            height: _listHeight,
            duration: const Duration(milliseconds: 500),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                decoration: BoxDecoration(
                    // color: AppColors.white,
                    borderRadius: BorderRadius.circular(18)),
                padding: const EdgeInsets.all(6.0),
                child: Stack(
                  children: [
                    Positioned(
                      top: 0,
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: CustomPaint(
                        size: Size(
                          MediaQuery.of(context).size.width,
                          (MediaQuery.of(context).size.width * 0.5573333333333333)
                              .toDouble(),
                        ),
                        //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
                        painter: RPSCustomPainter(),
                      ),
                    ),
                    Positioned(
                      top: 40,
                      bottom: 12,
                      left: 12,
                      right: 12,
                      child: Column(
                        children: [
                          Expanded(
                            child: ListView.separated(
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.call,
                                        color: AppColors.blueLiteColor,
                                        size: 30,
                                      ),
                                      SizedBox(width: 20),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              '01090439660',
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              'يوميا من الساعة 10 صباحا حتى 9 مساء',
                                              style: TextStyle(fontSize: 16),
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              },
                              separatorBuilder: (context, sIndex) => Container(
                                width: MediaQuery.of(context).size.width * 0.80,
                                height: 1,
                                color: AppColors.gray,
                              ),
                              itemCount: 8,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
