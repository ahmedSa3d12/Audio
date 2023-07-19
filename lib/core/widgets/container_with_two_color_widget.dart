import 'package:flutter/material.dart';

import '../utils/app_colors.dart';
import '../utils/assets_manager.dart';
import 'circle_network_image.dart';

class ContainerWithTwoColorWidget extends StatelessWidget {
  const ContainerWithTwoColorWidget({
    Key? key,
    required this.imagePath,
    required this.title,
    required this.color1,
    required this.color2,
    required this.textColor,
    this.isHome = false,
  }) : super(key: key);

  final String imagePath;
  final String title;
  final Color color1;
  final Color color2;
  final Color textColor;
  final bool? isHome;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: isHome! ? AppColors.transparent : null,
      ),
      child: Column(
        children: [
          // const Spacer(),
          imagePath.isEmpty
              ? Image.asset(ImageAssets.logoImage)
              : ManageCircleNetworkImage(
                  radius: MediaQuery.of(context).size.width / 8,
                  imageUrl: imagePath,
                  width: MediaQuery.of(context).size.width / 2,
                  height: MediaQuery.of(context).size.width / 2,
                ),
          // const Spacer(),
          SizedBox(height: 4),
          Flexible(
            flex: 2,
            child: Text(
              title,
              textAlign: TextAlign.center,
              overflow: TextOverflow.clip,
              maxLines: 1,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ),
          // const Spacer(),
        ],
      ),
    );
  }
}
