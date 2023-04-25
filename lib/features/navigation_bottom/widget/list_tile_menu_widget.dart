import 'package:flutter/material.dart';
import 'package:new_mazoon/core/widgets/my_svg_widget.dart';

import '../../../core/utils/app_colors.dart';

class MenuListTileWidget extends StatelessWidget {
  const MenuListTileWidget({
    Key? key,
    required this.title,
    required this.iconPath,
    required this.onclick,
  }) : super(key: key);

  final String title;
  final String iconPath;
  final VoidCallback onclick;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(
          color: AppColors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      leading: MySvgWidget(
        path: iconPath,
        imageColor: AppColors.white,
        size: 25,
      ),
      onTap: onclick,
    );
  }
}
