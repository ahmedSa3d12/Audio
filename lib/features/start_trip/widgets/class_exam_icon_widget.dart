import 'package:flutter/material.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/widgets/my_svg_widget.dart';

class ClassExamIconWidget extends StatelessWidget {
  const ClassExamIconWidget({
    Key? key,
    required this.type,
    required this.iconColor,
    required this.onclick,
    this.textData,
  }) : super(key: key);

  final String type;
  final String? textData;
  final Color iconColor;
  final VoidCallback onclick;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: type == 'text' ? null : onclick,
      child: Container(
        padding: EdgeInsets.all(2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          color: iconColor,
        ),
        child: Center(
          child: Directionality(
            textDirection: TextDirection.ltr,
            child: type == 'text'
                ? Text(
                    textData!,
                    style: TextStyle(
                      color: AppColors.white,
                      fontSize: 12,
                    ),
                  )
                : MySvgWidget(
                    path: type,
                    imageColor: AppColors.white,
                    size: 16,
                  ),
          ),
        ),
      ),
    );
  }
}
