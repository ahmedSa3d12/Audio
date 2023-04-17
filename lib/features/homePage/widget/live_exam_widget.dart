import 'package:flutter/material.dart';
import 'package:new_mazoon/core/utils/app_colors.dart';
import 'package:new_mazoon/core/utils/assets_manager.dart';

class LiveExamWarningWidget extends StatelessWidget {
  const LiveExamWarningWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 20.0,
        horizontal: 15,
      ),
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: AppColors.liveExamBackgroundColor,
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'امتحان لايف',
                    style: TextStyle(
                      color: AppColors.orangeThirdPrimary,
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                  ),
                  Text(
                    'عندنا امتحان لايف هيبدأ الساعة 10 مساء',
                    style: TextStyle(
                      color: AppColors.blackLite,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
            Image.asset(
              ImageAssets.liveExamImage,
              height: 50,
              width: 60,
            ),
          ],
        ),
      ),
    );
  }
}
