import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {Key? key,
      required this.text,
      required this.color,
      required this.onClick,
      this.paddingHorizontal = 0,
      this.borderRadius = 8,
      this.textcolor = Colors.white})
      : super(key: key);
  final String text;
  final Color color;
  final Color textcolor;
  final double paddingHorizontal;
  final double? borderRadius;
  final VoidCallback onClick;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClick,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: paddingHorizontal),
        child: Container(
          width: 100,
          alignment: Alignment.center,
          height: 30,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Color(0xffff0000)),
          child: Text(
            text,
            style: TextStyle(
              color: textcolor,
              fontSize: 13,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}
