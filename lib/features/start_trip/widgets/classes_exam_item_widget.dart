import 'package:flutter/material.dart';
import 'package:new_mazoon/core/utils/app_colors.dart';
import 'package:new_mazoon/core/utils/hex_color.dart';

import '../../../core/models/classes_exam_data_model.dart';
import '../../../core/utils/assets_manager.dart';
import '../../../core/widgets/download_icon_widget.dart';
import 'class_exam_icon_widget.dart';

class ClassesExamItemWidget extends StatelessWidget {
  const ClassesExamItemWidget({Key? key, required this.model})
      : super(key: key);

  final ClassesExamDatumModel model;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                height: 110,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: model.type == 'pdf'
                      ? HexColor('#FCB9B9')
                      : HexColor('#FDC286'),
                ),
                child: SizedBox(
                  height: 65,
                  width: 55,
                  child: Center(
                    child: Image.asset(
                      model.type == 'pdf'
                          ? ImageAssets.examPdfImage
                          : ImageAssets.examPaperImage,
                      height: 65,
                      width: 55,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 8),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text(
                          model.name,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 3,
                          style: TextStyle(
                            color: AppColors.black,
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Visibility(
                        visible: model.type == 'pdf',
                        child: Expanded(
                          child: Text(
                            '2 MB',
                            style: TextStyle(
                              color: AppColors.black,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                      // SizedBox(height: model.type == 'pdf'?10: 35),
                      SizedBox(
                        width: 210,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ClassExamIconWidget(
                              type: 'text',
                              iconColor: AppColors.blueColor1,
                              onclick: () {},
                            ),
                            ClassExamIconWidget(
                              type: 'text',
                              iconColor: AppColors.blueColor1,
                              onclick: () {},
                            ),
                            ClassExamIconWidget(
                              type: ImageAssets.noLoveIcon,
                              iconColor: AppColors.error,
                              onclick: () {},
                            ),
                            ClassExamIconWidget(
                              type: ImageAssets.answerPdfIcon,
                              iconColor: AppColors.goldColor,
                              onclick: () {},
                            ),
                            ClassExamIconWidget(
                              type: ImageAssets.videoIcon,
                              iconColor: AppColors.skyColor,
                              onclick: () {},
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
          Visibility(
            visible: model.type == 'pdf',
            child: Positioned(
              top: 95,
              right: 10,
              child: SizedBox(
                width: 25,
                height: 25,
                child: DownloadIconWidget(
                  color: AppColors.error,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
