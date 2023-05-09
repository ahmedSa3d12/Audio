import 'package:flutter/material.dart';
import 'package:new_mazoon/core/utils/assets_manager.dart';
import 'package:new_mazoon/core/widgets/network_image.dart';

import '../../../core/utils/app_colors.dart';

class ExamHeroDataWidget extends StatelessWidget {
  const ExamHeroDataWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 250,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: [
              Positioned(
                left: 0,
                right: 0,
                top: 0,
                child: SizedBox(
                  height: 190,
                  width: 100,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 0,
                        right: 0,
                        top: 0,
                        child: Container(
                          width: 50,
                          height: 110,
                          child: Stack(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(ImageAssets.starsImage),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ManageNetworkImage(
                                    imageUrl:
                                        'https://elmazone.topbusiness.io/default/avatar2.jfif',
                                    height: 80,
                                    width: 80,
                                    borderRadius: 80,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 95,
                        left: 0,
                        right: 0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              height: 30,
                              width: 30,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: AppColors.orangeThirdPrimary,
                              ),
                              child: Center(
                                child: Text(
                                  '1',
                                  style: TextStyle(color: AppColors.white),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        bottom: 20,
                        left: 0,
                        right: 0,
                        child: Column(
                          children: [
                            Text(
                              'aya',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text('الموفيه'),
                            Text(
                              '30/60',
                              style: TextStyle(
                                  color: AppColors.orangeThirdPrimary,
                                  fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 80,
                left: 0,
                right: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: 175,
                      width: 140,
                      child: Stack(
                        children: [
                          Positioned(
                            left: 0,
                            right: 0,
                            top: 0,
                            child: SizedBox(
                              width: 80,
                              height: 120,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  ManageNetworkImage(
                                    imageUrl:
                                        'https://elmazone.topbusiness.io/default/avatar2.jfif',
                                    height: 80,
                                    width: 80,
                                    borderRadius: 80,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 65,
                            left: 60,
                            right: 0,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  height: 30,
                                  width: 30,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    color: AppColors.blueLiteColor,
                                  ),
                                  child: Center(
                                    child: Text(
                                      '2',
                                      style: TextStyle(color: AppColors.white),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: Column(
                              children: [
                                Text(
                                  'aya',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text('الموفيه'),
                                Text(
                                  '30/60',
                                  style: TextStyle(
                                      color: AppColors.orangeThirdPrimary,
                                      fontSize: 14),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 80),
                    SizedBox(
                      height: 175,
                      width: 140,
                      child: Stack(
                        children: [
                          Positioned(
                            left: 0,
                            right: 0,
                            top: 0,
                            child: SizedBox(
                              width: 80,
                              height: 120,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  ManageNetworkImage(
                                    imageUrl:
                                        'https://elmazone.topbusiness.io/default/avatar2.jfif',
                                    height: 80,
                                    width: 80,
                                    borderRadius: 80,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 65,
                            left: 60,
                            right: 0,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  height: 30,
                                  width: 30,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    color: AppColors.blueLiteColor,
                                  ),
                                  child: Center(
                                    child: Text(
                                      '3',
                                      style: TextStyle(color: AppColors.white),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: Column(
                              children: [
                                Text(
                                  'aya',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text('الموفيه'),
                                Text(
                                  '30/60',
                                  style: TextStyle(
                                      color: AppColors.orangeThirdPrimary,
                                      fontSize: 14),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
