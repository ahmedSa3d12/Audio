import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_mazoon/core/utils/app_colors.dart';
import 'package:new_mazoon/core/utils/change_to_mega_byte.dart';
import 'package:new_mazoon/core/utils/getsize.dart';
import 'package:new_mazoon/core/utils/hex_color.dart';
import 'package:new_mazoon/features/lessons_of_class/screens/view_video_screen.dart';
import '../../../core/models/lessonexammodel.dart';
import '../../../core/utils/assets_manager.dart';
import '../../../core/widgets/download_icon_widget.dart';
import '../../../core/widgets/pdf_screen.dart';
import '../../start_trip/widgets/class_exam_icon_widget.dart';
import '../cubit/lessons_class_cubit.dart';

class LessonsExamItemWidget extends StatelessWidget {
  const LessonsExamItemWidget(
      {Key? key, required this.model, required this.index})
      : super(key: key);

  final LessonExamData model;
  final int index;
  @override
  Widget build(BuildContext context) {
    LessonsClassCubit cubit = context.read<LessonsClassCubit>();
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
                height: getSize(context) / 4,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: model.type == 'pdf'
                      ? HexColor('#FCB9B9')
                      : HexColor('#FDC286'),
                ),
                child: SizedBox(
                  height: getSize(context) / 6,
                  width: getSize(context) / 6,
                  child: Center(
                    child: Image.asset(
                      model.type == 'pdf'
                          ? ImageAssets.examPdfImage
                          : ImageAssets.examPaperImage,
                      height: getSize(context) / 7,
                      width: getSize(context) / 7,
                    ),
                  ),
                ),
              ),
              Flexible(
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
                          maxLines: 2,
                          style: TextStyle(
                            color: AppColors.black,
                            fontSize: getSize(context) / 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Visibility(
                        visible: model.type == 'pdf',
                        child: Expanded(
                          child: Text(
                            changeToMegaByte(model.examPdfSize.toString()),
                            style: TextStyle(
                              color: AppColors.black,
                              fontSize: getSize(context) / 28,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex: 1,
                              child: ClassExamIconWidget(
                                textData: ' ${model.numOfQuestion}',
                                type: 'text',
                                iconColor: AppColors.gray7,
                                onclick: () {
                                  print('rrrrrrrrrrrr');
                                },
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: ClassExamIconWidget(
                                textData: '${model.totalTime}',
                                type: 'text',
                                iconColor: AppColors.gray7,
                                onclick: () {},
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: ClassExamIconWidget(
                                radius: 1000,
                                type: ImageAssets.loveIcon,
                                iconLoveColor:
                                    cubit.examsofLessons[index].examsFavorite ==
                                            'un_favorite'
                                        ? AppColors.white
                                        : AppColors.red,
                                iconColor: HexColor(cubit
                                    .examsofLessons[index].backgroundColor),
                                onclick: () {
                                  cubit.favourite(
                                      'online_exam',
                                      cubit.examsofLessons[index]
                                                  .examsFavorite ==
                                              'un_favorite'
                                          ? 'favorite'
                                          : 'un_favorite',
                                      index);
                                },
                              ),
                            ),
                            cubit.examsofLessons[index].answerPdfFile == null
                                ? Container()
                                : Expanded(
                                    flex: 1,
                                    child: ClassExamIconWidget(
                                      radius: 1000,
                                      type: ImageAssets.answerPdfIcon,
                                      iconColor: AppColors.goldColor,
                                      onclick: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => PdfScreen(
                                                      pdfLink: cubit
                                                          .examsofLessons[index]
                                                          .answerPdfFile,
                                                      pdfTitle: cubit
                                                          .examsofLessons[index]
                                                          .name,
                                                    )));

                                        ///open pdf answer
                                      },
                                    ),
                                  ),
                            cubit.examsofLessons[index].answerVideoFile == null
                                ? Container()
                                : Expanded(
                                    flex: 1,
                                    child: ClassExamIconWidget(
                                      type: ImageAssets.videoIcon,
                                      iconColor: AppColors.skyColor,
                                      onclick: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    AnswerVideoViewScreen(
                                                        videoId: cubit
                                                            .examsofLessons[
                                                                index]
                                                            .id,
                                                        videoLink: cubit
                                                            .examsofLessons[
                                                                index]
                                                            .answerVideoFile)));
                                      },
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
              top: getSize(context) / 6,
              right: getSize(context) / 44,
              child: InkWell(
                onTap: () async {
                  print('object');
                  cubit.downloadPdfOfLesson(model);
                },
                child: SizedBox(
                  width: getSize(context) / 14,
                  height: getSize(context) / 14,
                  child: model.progress != 0
                      ? CircularProgressIndicator(
                          value: model.progress,
                          backgroundColor: AppColors.white,
                          color: AppColors.primary,
                        )
                      : DownloadIconWidget(
                          color: HexColor(model.backgroundColor),
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
