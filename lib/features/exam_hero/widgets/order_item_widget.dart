import 'dart:math';

import 'package:flutter/material.dart';
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
          padding: const EdgeInsets.symmetric(
              horizontal: 20.0, vertical: 16),
          child: Row(
            children: [
              ManageNetworkImage(
                imageUrl:
                'https://elmazone.topbusiness.io/default/avatar2.jfif',
                height: 70,
                width: 70,
                borderRadius: 70,
              ),
              Expanded(
                child: Container(
                  height: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: AppColors.redLiteColor,
                  ),
                  child: Padding(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 35.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'aya',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text('الموفيه'),
                        Text(
                          '30/60',
                          style: TextStyle(
                            color: AppColors.orangeThirdPrimary,
                            fontSize: 14,
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
                  style: TextStyle(color: AppColors.white),
                ),
              ),
            ))
      ],
    );
  }
}
