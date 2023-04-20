import 'package:flutter/material.dart';

import '../../../core/utils/app_colors.dart';

class MonthPlanWidget extends StatelessWidget {
  const MonthPlanWidget({Key? key, required this.color1, required this.color2, required this.title, required this.desc, required this.index}) : super(key: key);
final Color color1;
final Color color2;
final String title;
final String desc;
final int index;

  @override
  Widget build(BuildContext context) {
    return  Padding(padding:EdgeInsets.all(80),
    child: Row(
      children: [
        Container(
          decoration: BoxDecoration(shape: BoxShape.circle,
            color: color1
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(index.toString(),
            style: TextStyle(color: color2,fontWeight:FontWeight.bold,

            fontSize: 14,
            ),),
          ),
        ),
        SizedBox(width: 14,),
        Expanded(child: Container(decoration: BoxDecoration(
          color: color1,
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(children: [
            Text(title,
              style: TextStyle(color: color2,fontWeight:FontWeight.bold,

                fontSize: 14,
              ),),
            Text(desc,
              style: TextStyle(color: AppColors.black,fontWeight:FontWeight.bold,

                fontSize: 14,
              ),),
          ],),
        ),))
      ],
    ),
    );
  }
}
