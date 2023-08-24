import 'package:flutter/material.dart';
import 'package:new_mazoon/core/utils/assets_manager.dart';
import 'package:new_mazoon/core/widgets/network_image.dart';

import '../../../core/models/exam_hero.dart';
import '../../../core/utils/app_colors.dart';

class ThreeTopExamHeroWidget extends StatelessWidget {
  ThreeTopExamHeroWidget({required this.threeHeros, Key? key})
      : super(key: key);
  List<ExamHerosModelAuth> threeHeros;
  @override
  Widget build(BuildContext context) {
    return threeHeros.length == 0
        ? Container()
        : SizedBox(
            height: 250,
            width: MediaQuery.of(context).size.width,
            child: Stack(
              children: [
                threeHeros.length < 1
                    ? Container()
                    : Positioned(
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
                                top: 30,
                                child: Container(
                                  width: 50,
                                  height: 110,
                                  child: Stack(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Image.asset(ImageAssets.starsImage),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          ManageNetworkImage(
                                            imageUrl: threeHeros[0].image,
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
                                bottom: 70,
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
                                          threeHeros[0].ordered.toString(),
                                          style:
                                              TextStyle(color: AppColors.white),
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
                                      threeHeros[0].name,
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(threeHeros[0].country),
                                    Text(
                                      '${threeHeros[0].studentTotalDegrees} / ${threeHeros[0].examsTotalDegree}',
                                      style: TextStyle(
                                          color: AppColors.orangeThirdPrimary,
                                          fontSize: 14),
                                    ),
                                  ],
                                ),
                              ),
                              Positioned(
                                top: 0,
                                left: 30,
                                right: 0,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      ImageAssets.crownImage,
                                      width: 45,
                                      height: 45,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                threeHeros.length < 2
                    ? Container()
                    : Positioned(
                        top: 80,
                        left: 0,
                        right: 0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            threeHeros.length < 2
                                ? Container()
                                : SizedBox(
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
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                ManageNetworkImage(
                                                  imageUrl: threeHeros[1].image,
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
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Container(
                                                height: 30,
                                                width: 30,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(30),
                                                  color:
                                                      AppColors.blueLiteColor,
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    threeHeros[1]
                                                        .ordered
                                                        .toString(),
                                                    style: TextStyle(
                                                        color: AppColors.white),
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
                                                threeHeros[1].name,
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Text(threeHeros[1].country),
                                              Text(
                                                '${threeHeros[1].studentTotalDegrees} / ${threeHeros[1].examsTotalDegree}',
                                                style: TextStyle(
                                                    color: AppColors
                                                        .orangeThirdPrimary,
                                                    fontSize: 14),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                            SizedBox(width: 80),
                            threeHeros.length < 3
                                ? Container()
                                : SizedBox(
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
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                ManageNetworkImage(
                                                  imageUrl: threeHeros[2].image,
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
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Container(
                                                height: 30,
                                                width: 30,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(30),
                                                  color:
                                                      AppColors.blueLiteColor,
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    threeHeros[2]
                                                        .ordered
                                                        .toString(),
                                                    style: TextStyle(
                                                        color: AppColors.white),
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
                                                threeHeros[2].name,
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Text(threeHeros[2].country),
                                              Text(
                                                '${threeHeros[2].studentTotalDegrees} / ${threeHeros[2].examsTotalDegree}',
                                                style: TextStyle(
                                                    color: AppColors
                                                        .orangeThirdPrimary,
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
          );
  }
}
