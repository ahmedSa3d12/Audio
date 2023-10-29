import 'package:flutter/material.dart';

import '../utils/app_colors.dart';

class ShowLoadingIndicator extends StatelessWidget {
  const ShowLoadingIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: CircularProgressIndicator(
            color: AppColors.primary,
          ),
        ),
      ],
    );
  }
}
