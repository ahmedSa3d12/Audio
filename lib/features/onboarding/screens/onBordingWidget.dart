import 'package:flutter/material.dart';
import 'package:new_mazoon/core/utils/app_colors.dart';

class OnBordingModel extends StatelessWidget {
  String image;
  String title;
  String subtitle;
  Color color;
  OnBordingModel(
      {required this.color,
      required this.image,
      required this.title,
      required this.subtitle,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 4,
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: Image.network(
                image,
                fit: BoxFit.contain,
                width: double.infinity,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Column(
              children: [
                Text(
                  title,
                  style: TextStyle(
                      color: AppColors.black,
                      fontSize: 20,
                      fontFamily: 'Cairo-Black',
                      fontWeight: FontWeight.bold),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    subtitle,
                    style: TextStyle(
                        fontFamily: 'Cairo-Light',
                        color: AppColors.descriptionBoardingColor,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
