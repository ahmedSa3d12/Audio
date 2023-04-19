import 'package:flutter/material.dart';
import 'package:new_mazoon/core/utils/app_colors.dart';

import '../../../core/widgets/my_svg_widget.dart';

class InstructionSettingWidget extends StatelessWidget {
   InstructionSettingWidget({Key? key, required this.icon, required this.color, required this.title}) : super(key: key);
final String icon;
final Color color;
final String title;
  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: lighten(color)
        ),
        child:MySvgWidget(path: icon,imageColor: color, size: 12,) ,
      )],
    );
  }
}
