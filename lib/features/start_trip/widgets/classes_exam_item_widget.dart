import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:new_mazoon/core/utils/app_colors.dart';
import 'package:new_mazoon/core/utils/change_to_mega_byte.dart';
import 'package:new_mazoon/core/utils/getsize.dart';
import 'package:new_mazoon/core/utils/hex_color.dart';
import 'package:new_mazoon/features/start_trip/cubit/start_trip_cubit.dart';

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
    StartTripCubit cubit = context.read<StartTripCubit>();
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
                height: getSize(context) / 3.5,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(getSize(context) / 22),
                  color: model.type == 'pdf'
                      ? HexColor('#FCB9B9')
                      : HexColor('#FDC286'),
                ),
                child: SizedBox(
                  height: getSize(context) / 4.8,
                  width: getSize(context) / 5.2,
                  child: Center(
                    child: Image.asset(
                      model.type == 'pdf'
                          ? ImageAssets.examPdfImage
                          : ImageAssets.examPaperImage,
                      height: getSize(context) / 4.8,
                      width: getSize(context) / 5.2,
                    ),
                  ),
                ),
              ),
              SizedBox(height: getSize(context) / 100),
              Flexible(
                fit: FlexFit.tight,
                child: Padding(
                  padding: EdgeInsets.all(getSize(context) / 66),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        fit: FlexFit.tight,
                        child: Text(
                          model.name!,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: TextStyle(
                            color: AppColors.black,
                            fontSize: getSize(context) / 24,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      Visibility(
                        visible: model.type == 'pdf',
                        child: Text(
                          changeToMegaByte(model.examPdfSize.toString()),
                          style: TextStyle(
                              color: AppColors.black,
                              fontSize: getSize(context) / 26),
                        ),
                      ),
                      // SizedBox(height: model.type == 'pdf'?10: 35),
                      SizedBox(
                        // width: 210,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex: 3,
                              child: ClassExamIconWidget(
                                textData: '${model.numOfQuestion}Q',
                                type: 'text',
                                iconColor: AppColors.gray7,
                                onclick: () {
                                  print('rrrrrrrrrrrr');
                                },
                              ),
                            ),
                            Expanded(
                              flex: 4,
                              child: ClassExamIconWidget(
                                textData: ' ${model.totalTime} min',
                                type: 'text',
                                iconColor: AppColors.gray7,
                                onclick: () {},
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: ClassExamIconWidget(
                                radius: 1000,
                                type: ImageAssets.noLoveIcon,
                                iconColor: AppColors.error,
                                onclick: () {
                                  print('wwwwwwwwwwwwwwwww');
                                },
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: ClassExamIconWidget(
                                radius: 1000,
                                type: ImageAssets.answerPdfIcon,
                                iconColor: AppColors.goldColor,
                                onclick: () {},
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: ClassExamIconWidget(
                                type: ImageAssets.videoIcon,
                                iconColor: AppColors.skyColor,
                                onclick: () {},
                                radius: 1000,
                              ),
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
              child: InkWell(
                onTap: () async {
                  print('object');
                  cubit.downloadPdf(model);
                },
                child: SizedBox(
                  width: 25,
                  height: 25,
                  child: model.progress != 0
                      ? CircularProgressIndicator(
                          value: model.progress,
                          backgroundColor: AppColors.white,
                          color: AppColors.primary,
                        )
                      : DownloadIconWidget(
                          color: HexColor(model.backgroundColor!),
                        ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
