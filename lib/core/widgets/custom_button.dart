import 'package:flutter/material.dart';
import 'package:new_mazoon/core/utils/getsize.dart';

class CustomButton extends StatelessWidget {
  CustomButton(
      {Key? key,
      required this.text,
      required this.color,
      required this.onClick,
      this.paddingHorizontal = 0,
      this.borderRadius = 8,
      this.height,
      this.textcolor = Colors.white})
      : super(key: key);
  final String text;
  final Color color;
  final Color textcolor;
  final double paddingHorizontal;
  final double? borderRadius;
  final VoidCallback onClick;
  double? height;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClick,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: paddingHorizontal),
        child: Container(
          width: getSize(context) / 1.5,
          alignment: Alignment.center,
          height: height ?? getSize(context) / 10,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), color: color),
          child: Text(
            text,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: textcolor,
              fontSize: getSize(context) / 24,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}
