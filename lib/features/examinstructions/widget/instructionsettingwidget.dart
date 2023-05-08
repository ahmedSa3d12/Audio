import 'package:flutter/material.dart';
import 'package:new_mazoon/core/utils/app_colors.dart';

import '../../../core/widgets/my_svg_widget.dart';

class InstructionSettingWidget extends StatelessWidget {
   InstructionSettingWidget({Key? key, required this.icon, required this.color, required this.title, required this.color2}) : super(key: key);
final String icon;
final Color color;
final Color color2;
final String title;
  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color2
        ),
        child:Padding(
          padding: const EdgeInsets.all(16.0),
          child: MySvgWidget(path: icon,imageColor: color, size: 30,),
          
        ) ,
      ),
      Text(title,style: TextStyle(color: AppColors.liveExamGrayTextColor,fontSize: 18),)],
    );
  }
}
