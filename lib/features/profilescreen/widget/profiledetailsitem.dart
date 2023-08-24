import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/utils/getsize.dart';

class ProfileDataItem extends StatelessWidget {
  ProfileDataItem({required this.title, required this.data, super.key});
  String title;
  String data;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          child: Row(
            children: [
              Expanded(
                child: Text(
                  title.tr(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.liveExamGrayTextColor,
                    fontSize: getSize(context) / 22,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  data,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.liveExamGrayTextColor,
                    fontSize: getSize(context) / 22,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.all(getSize(context) / 22),
          child: Container(
            decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  width: 0.50,
                  strokeAlign: BorderSide.strokeAlignCenter,
                  color: AppColors.gray7,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
