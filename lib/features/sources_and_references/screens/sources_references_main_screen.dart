import 'package:flutter/material.dart';
import 'package:new_mazoon/core/utils/app_colors.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

import '../../../core/widgets/title_with_circle_background_widget.dart';
import '../widgets/main_screen_item_widget.dart';

class SourcesAndReferencesMainScreen extends StatelessWidget {
  const SourcesAndReferencesMainScreen({Key? key}) : super(key: key);
  static List<Color> colors = [
    AppColors.orangeThirdPrimary,
    AppColors.skyColor,
    AppColors.primary,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 105),
          TitleWithCircleBackgroundWidget(title: 'sources_and_references'),
          SizedBox(height: 25),
          Column(
            children: [
              ...List.generate(
                colors.length,
                (index) => MainScreenItemWidget(mainColor: colors[index]),
              )
            ],
          )
        ],
      ),
    );
  }
}