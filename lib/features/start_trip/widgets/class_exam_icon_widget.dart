import 'package:flutter/material.dart';
import 'package:new_mazoon/core/utils/getsize.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/widgets/my_svg_widget.dart';

class ClassExamIconWidget extends StatelessWidget {
  const ClassExamIconWidget({
    Key? key,
    required this.type,
    required this.iconColor,
    required this.onclick,
    this.textData,
    this.iconLoveColor = Colors.white,
    this.radius = 18,
  }) : super(key: key);

  final String type;
  final String? textData;
  final double? radius;
  final Color iconColor;
  final Color iconLoveColor;
  final VoidCallback onclick;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: type == 'text' ? null : onclick,
      child: Container(
        width: getSize(context) / 14,
        height: getSize(context) / 14,
        padding: EdgeInsets.all(2),
        margin: EdgeInsets.all(2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius!),
          color: iconColor,
        ),
        child: Center(
          child: Directionality(
            textDirection: TextDirection.ltr,
            child: type == 'text'
                ? Text(
                    textData!,
                    maxLines: 1,
                    style: TextStyle(
                        color: AppColors.white,
                        fontSize: getSize(context) / 38,
                        overflow: TextOverflow.clip),
                  )
                : Container(
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(5)),
                    padding: const EdgeInsets.all(2.0),
                    child: MySvgWidget(
                      path: type,
                      imageColor: iconLoveColor,
                      size: getSize(context) / 38,
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
