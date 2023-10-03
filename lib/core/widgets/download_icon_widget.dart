import 'package:flutter/material.dart';
import 'package:new_mazoon/core/utils/app_colors.dart';
import 'package:new_mazoon/core/utils/getsize.dart';

class DownloadIconWidget extends StatelessWidget {
  const DownloadIconWidget(
      {Key? key, required this.color, this.iconColor = Colors.white})
      : super(key: key);
  final Color color;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: Container(
        alignment: Alignment.center,
        width: getSize(context) / 12,
        height: getSize(context) / 12,
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
      ),
    );
  }
}
