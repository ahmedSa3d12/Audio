import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_mazoon/core/utils/app_colors.dart';
import 'package:new_mazoon/core/utils/getsize.dart';
import 'package:new_mazoon/core/utils/hex_color.dart';
import 'package:new_mazoon/features/lessons_of_class/screens/view_video_screen.dart';
import '../../../core/models/all_favourite.dart';
import '../../../core/utils/assets_manager.dart';
import '../../../core/widgets/download_icon_widget.dart';
import '../../../core/widgets/pdf_screen.dart';
import '../../start_trip/widgets/class_exam_icon_widget.dart';
import '../cubit/favourite_cubit.dart';

class FavExamItemWidget extends StatelessWidget {
  const FavExamItemWidget({Key? key, required this.model, required this.index})
      : super(key: key);
  final int index;
  final AllExamFavorite model;

  @override
  Widget build(BuildContext context) {
    FavouriteCubit cubit = context.read<FavouriteCubit>();
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
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
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
                    Positioned(
                        left: 0,
                        top: 0,
                        child: IconButton(
                          icon: Icon(
                            CupertinoIcons.heart_fill,
                            color: AppColors.red,
                          ),
                          onPressed: () async {
                            await cubit.removeFavouriteExam(model.type,
                                "un_favourite", model.examId, index);
                          },
                        )),
                  ],
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
                          model.name,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: TextStyle(
                            color: AppColors.black,
                            fontSize: getSize(context) / 28,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      // Visibility(
                      //   visible: model.type == 'pdf',
                      //   child: Text(
                      //    // "ooo",
                      //     changeToMegaByte(model.answerPdfFile.toString()),
                      //     style: TextStyle(
                      //         color: AppColors.black,
                      //         fontSize: getSize(context) / 26),
                      //   ),
                      // ),
                      // SizedBox(height: model.type == 'pdf'?10: 35),
                      SizedBox(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            model.numOfQuestions != null
                                ? Expanded(
                                    flex: 1,
                                    child: ClassExamIconWidget(
                                      textData: '${model.numOfQuestions}',
                                      type: 'text',
                                      iconColor: AppColors.gray7,
                                      onclick: () {},
                                    ),
                                  )
                                : SizedBox(),
                            model.quizMinutes != null
                                ? Expanded(
                                    flex: 1,
                                    child: ClassExamIconWidget(
                                      textData: ' ${model.quizMinutes}',
                                      type: 'text',
                                      iconColor: AppColors.gray7,
                                      onclick: () {},
                                    ),
                                  )
                                : SizedBox(),
                            model.answerPdfFile == null
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
                                                      pdfLink:
                                                          model.answerPdfFile!,
                                                      pdfTitle:
                                                          'model_answer'.tr(),
                                                    )));
                                      },
                                    ),
                                  ),
                            model.answerVideoFile == null
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
                                                        isYoutube:
                                                            model.youtubeAnswer,
                                                        videoLink: model
                                                            .answerVideoFile!)));
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
              top: 95,
              right: 10,
              child: cubit.allFavourite!.data.allExamFavorites!
                              .elementAt(index)
                              .progress ==
                          0 &&
                      File(cubit.dirpath.path +
                              "/pdf/" +
                              cubit.allFavourite!.data.allExamFavorites!
                                  .elementAt(index)
                                  .name
                                  .split("/")
                                  .toList()
                                  .last +
                              '.pdf')
                          .existsSync()
                  ? SizedBox(
                      width: 25,
                      height: 25,
                      child: Icon(
                        Icons.check_circle,
                        color: AppColors.success,
                      ))
                  : InkWell(
                      onTap: () async {
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
