import 'package:flutter/material.dart';

import '../../../core/utils/app_colors.dart';
import '../../attachment/screens/rate_yourself.dart';
import '../../homePage/widget/home_page_app_bar_widget.dart';

class RateYourselfDependExamResult extends StatefulWidget {
  const RateYourselfDependExamResult({super.key});

  @override
  State<RateYourselfDependExamResult> createState() =>
      _RateYourselfDependExamResultState();
}

class _RateYourselfDependExamResultState
    extends State<RateYourselfDependExamResult> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.secondPrimary,
        toolbarHeight: 0,
      ),
      //
      body: SafeArea(
        top: false,
        maintainBottomViewPadding: true,
        child: Stack(
          children: [
            RateYourSelfScreen(),
            Positioned(
              top: 0,
              right: 0,
              left: 0,
              child: HomePageAppBarWidget(),
            ),
          ],
        ),
      ),
    );
  }
}
