import 'package:flutter/material.dart';
import 'package:new_mazoon/core/models/elmazoon_model.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/utils/getsize.dart';

class MazoonInfoWidget extends StatelessWidget {
  MazoonInfoWidget({
    required this.data,
    required this.allData,
    super.key,
  });
  List<ELmazoonModelDataExperience> data;

  ELmazoonModelData allData;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: data.length,
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        return Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(
                        horizontal: getSize(context) / 100),
                    width: getSize(context) / 15.5,
                    height: getSize(context) / 15.5,
                    child: Stack(
                      children: [
                        Positioned(
                          left: 0,
                          top: 0,
                          child: Container(
                            alignment: Alignment.center,
                            width: getSize(context) / 15.5,
                            height: getSize(context) / 15.5,
                            decoration: ShapeDecoration(
                              color: AppColors.white,
                              shape: OvalBorder(
                                side: BorderSide(
                                    width: 1.50, color: AppColors.blue),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          left: 6.67,
                          top: 5.83,
                          child: Container(
                            width: getSize(context) / 31,
                            height: getSize(context) / 31,
                            decoration: ShapeDecoration(
                              color: AppColors.blue,
                              shape: OvalBorder(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Flexible(
                    child: Text(
                      data[index].title,
                      textAlign: TextAlign.right,
                      maxLines: 1,
                      overflow: TextOverflow.fade,
                      style: TextStyle(
                        color: AppColors.gray1,
                        fontSize: getSize(context) / 24,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  )
                ],
              ),
              IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(width: getSize(context) / 34),

                    ///side widget
                    Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: getSize(context) / 100),
                      decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            width: 1,
                            strokeAlign: BorderSide.strokeAlignCenter,
                            color: AppColors.blue,
                          ),
                        ),
                      ),
                    ),
                    Flexible(
                      fit: FlexFit.tight,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: getSize(context) / 24),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              data[index].description,
                              style: TextStyle(
                                color: AppColors.gray1,
                                fontSize: getSize(context) / 24,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Text(
                              data[index].year,
                              maxLines: 1,
                              overflow: TextOverflow.fade,
                              style: TextStyle(
                                color: AppColors.orangeThirdPrimary,
                                fontSize: getSize(context) / 24,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            SizedBox(height: getSize(context) / 12),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
