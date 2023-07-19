import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../utils/app_colors.dart';

class ManageCircleNetworkImage extends StatelessWidget {
  const ManageCircleNetworkImage(
      {Key? key,
      required this.imageUrl,
      required this.radius,
      this.height = 0,
      this.width = 0})
      : super(key: key);

  final String imageUrl;
  final double height;
  final double width;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
        radius: radius,
        child: ClipRRect(
          borderRadius:
              BorderRadius.circular(MediaQuery.of(context).size.width / 8),
          child: CachedNetworkImage(
            imageUrl: imageUrl,
            fit: BoxFit.cover,
            height: height != 0 ? height : null,
            width: width != 0 ? width : null,
            placeholder: (context, url) => Center(
              child: CircularProgressIndicator(
                color: AppColors.primary,
              ),
            ),
          ),
        ));
  }
}
