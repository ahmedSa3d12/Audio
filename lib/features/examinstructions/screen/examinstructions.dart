import 'package:flutter/material.dart';
import 'package:new_mazoon/features/examinstructions/widget/instructionsettingwidget.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/utils/assets_manager.dart';
import '../../homePage/widget/home_page_app_bar_widget.dart';

class ExamInstructions extends StatefulWidget {
  const ExamInstructions({Key? key}) : super(key: key);

  @override
  State<ExamInstructions> createState() => _ExamInstructionsState();
}

class _ExamInstructionsState extends State<ExamInstructions> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.secondPrimary,
        toolbarHeight: 0,
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              top: 0,
              right: 0,
              left: 0,
              bottom: 0,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Text("امتحان على الدرس الاول",
                    style: TextStyle(fontSize: 14,
                    color: AppColors.black,
                    ),

                    ),
                    Row(children: [InstructionSettingWidget(icon: ImageAssets.loadIcon, color: AppColors.purple1, title: "3 محاولات"),
                      InstructionSettingWidget(icon: ImageAssets.timeIcon, color: AppColors.blue, title: "120 min"),
                      InstructionSettingWidget(icon: ImageAssets.questionIcon, color: AppColors.orange, title: "50 Q")],)
                  ],
                ),
              ),
            ),
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
