import 'package:flutter/material.dart';
import 'package:new_mazoon/core/utils/app_colors.dart';

class DownloadIconWidget extends StatelessWidget {
  const DownloadIconWidget(
      {Key? key, required this.color, this.iconColor = Colors.white})
      : super(key: key);
  final Color color;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(0),
      width: 30,
      height: 30,
      decoration: BoxDecoration(
        color: darken(color),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Icon(
          Icons.file_download_outlined,
          color: iconColor,
        ),
      ),
    );
  }
}
