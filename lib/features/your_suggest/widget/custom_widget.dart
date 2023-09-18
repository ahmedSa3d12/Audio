import 'package:flutter/material.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/utils/getsize.dart';
import '../../../core/widgets/my_svg_widget.dart';

class SuggestionInfoCard extends StatelessWidget {
  const SuggestionInfoCard(
      {required this.title, required this.path, super.key});
  final String title;
  final String path;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: getSize(context) / 44),
      width: double.infinity,
      height: getSize(context) / 7.2,
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 1, color: AppColors.gray5),
          borderRadius: BorderRadius.circular(getSize(context) / 22),
        ),
      ),
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: getSize(context) / 44),
            child: MySvgWidget(
              path: path,
              imageColor: AppColors.gray5,
              size: getSize(context) / 14,
            ),
          ),
          Flexible(
            child: Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.right,
              style: TextStyle(
                color: AppColors.gray5,
                fontSize: getSize(context) / 24,
                fontFamily: 'Cairo',
                fontWeight: FontWeight.w400,
                height: 0,
              ),
            ),
          )
        ],
      ),
    );
  }
}
