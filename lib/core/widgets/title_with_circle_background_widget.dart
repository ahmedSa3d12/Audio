import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:new_mazoon/core/utils/getsize.dart';

import '../utils/app_colors.dart';

class TitleWithCircleBackgroundWidget extends StatelessWidget {
  TitleWithCircleBackgroundWidget({Key? key, required this.title, this.width})
      : super(key: key);
  double? width;
  final String title;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: getSize(context) / 12,
      width: width ?? MediaQuery.of(context).size.width / 2,
      child: Stack(
        children: [
          Positioned(
            bottom: 0,
            right: 15,
            child: Container(
              width: getSize(context) / 12,
              height: getSize(context) / 12,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                color: AppColors.orangeThirdPrimary,
              ),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 6.0),
                  child: Container(
                    width: 50,
                    height: 1,
                    color: AppColors.primary,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 8,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SizedBox(
                // width: MediaQuery.of(context).size.width * 0.50,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      title.tr(),
                      style: TextStyle(
                        fontSize: getSize(context) / 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
