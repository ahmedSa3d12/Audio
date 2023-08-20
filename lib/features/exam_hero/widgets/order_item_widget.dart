import 'dart:math';

import 'package:flutter/material.dart';
import 'package:new_mazoon/core/utils/getsize.dart';
import 'package:new_mazoon/core/widgets/network_image.dart';

import '../../../core/utils/app_colors.dart';

class OrderItemWidget extends StatelessWidget {
   OrderItemWidget({Key? key}) : super(key: key);
  final random = Random();
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding:  EdgeInsets.symmetric(
              horizontal: getSize(context)/22, vertical: getSize(context)/24),
          child: Row(
            children: [
              ManageNetworkImage(
                imageUrl:
                'https://elmazone.topbusiness.io/default/avatar2.jfif',
                height: getSize(context)/5,
                width: getSize(context)/5,
                borderRadius: getSize(context)/24,
              ),
              Expanded(
                child: Container(
                  height: getSize(context)/4,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(getSize(context)/22),
                    color: AppColors.redLiteColor,
                  ),
                  child: Padding(
                    padding:
                     EdgeInsets.symmetric(horizontal: getSize(context)/22),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'aya',
                          style: TextStyle(
                            fontSize: getSize(context)/22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text('الموفيه',  style: TextStyle(
                          fontSize: getSize(context)/22,
                          fontWeight: FontWeight.bold,
                        ),),
                        Text(
                          '30/60',
                          style: TextStyle(
                            color: AppColors.orangeThirdPrimary,
                            fontSize: getSize(context)/24,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        Positioned(
            top: 10,
            left: 25,
            child: Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color.fromRGBO(
                  random.nextInt(256),
                  random.nextInt(256),
                  random.nextInt(256),
                  2,
                ),
              ),
              // clipBehavior: Clip.antiAlias,
              child: Center(
                child: Text(
                  '5',
                  style: TextStyle(color: AppColors.white,fontSize: getSize(context)/22),
                ),
              ),
            ))
      ],
    );
  }
}
