import 'package:flutter/material.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

import '../../../core/utils/app_colors.dart';

class MainScreenItemWidget extends StatelessWidget {
  const MainScreenItemWidget({Key? key, required this.mainColor})
      : super(key: key);

  final Color mainColor;

  static const _durations = [
    8000,
    7000,
  ];

  static const _heightPercentages = [
    0.20,
    0.50,
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0,vertical: 12),
      child: Container(
        height: 200,
        width: null,
        decoration: BoxDecoration(
          color: lighten(mainColor, 0.4),
          borderRadius: BorderRadius.circular(15),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Stack(
            children: [
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: WaveWidget(
                  config: CustomConfig(
                    colors: [lighten(mainColor, 0.3), lighten(mainColor, 0.2)],
                    durations: _durations,
                    heightPercentages: _heightPercentages,
                  ),
                  backgroundColor: mainColor.withOpacity(0.0),
                  size: Size(double.infinity, 200 / 2),
                  waveAmplitude: 10,
                ),
              ),
              Positioned(
                top: 0,
                right: 0,
                left: 0,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'كتاب الامتحان',
                        style: TextStyle(
                          color: mainColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                        ),
                      ),
                      SizedBox(height: 12),
                      Text(
                        'حل اهم اسئلة الكتاب',
                        style: TextStyle(
                          color: AppColors.gray,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
