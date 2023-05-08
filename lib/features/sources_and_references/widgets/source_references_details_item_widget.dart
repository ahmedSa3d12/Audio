import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_mazoon/features/sources_and_references/cubit/source_references_cubit.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/utils/assets_manager.dart';
import '../../../core/utils/change_to_mega_byte.dart';
import '../../../core/widgets/my_svg_widget.dart';
import '../../../core/widgets/pdf_screen.dart';
import '../../start_trip/widgets/class_exam_icon_widget.dart';

class SourceReferenceDetailsItemWidget extends StatelessWidget {
  SourceReferenceDetailsItemWidget({Key? key}) : super(key: key);

  List<Color> colors = [
    AppColors.purple1,
    AppColors.orange,
    AppColors.blue,
  ];
  int i = 0;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SourceReferencesCubit, SourceReferencesState>(
      builder: (context, state) {
        SourceReferencesCubit cubit = context.read<SourceReferencesCubit>();
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            children: [
              ...List.generate(
                cubit.sourcesReferencesByIdList.length,
                (index) {
                  i < 2 ? ++i : i = 0;
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 4.0),
                    child: InkWell(
                      onTap: () {
                        cubit.sourcesReferencesByIdList[index].fileType != 'pdf'
                            ? null
                            : Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PdfScreen(
                                    pdfTitle: cubit
                                        .sourcesReferencesByIdList[index]
                                        .title!,
                                    pdfLink: cubit
                                        .sourcesReferencesByIdList[index]
                                        .filePath!,
                                  ),
                                ),
                              );
                      },
                      child: Card(
                        elevation: 12,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                // mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      width: 40,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(40),
                                        color: colors[i],
                                      ),
                                      child: Center(
                                        child: MySvgWidget(
                                          path: cubit
                                                      .sourcesReferencesByIdList[
                                                          index]
                                                      .fileType ==
                                                  'pdf'
                                              ? ImageAssets.pdfIcon
                                              : ImageAssets.resourceVideoIcon,
                                          size: 20,
                                          imageColor: AppColors.white,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        cubit.sourcesReferencesByIdList[index]
                                            .title!,
                                      ),
                                      cubit.sourcesReferencesByIdList[index]
                                                  .fileType ==
                                              'pdf'
                                          ? Text(
                                              changeToMegaByte(cubit
                                                  .sourcesReferencesByIdList[
                                                      index]
                                                  .filePathSize!),
                                              textDirection: TextDirection.ltr,
                                            )
                                          : SizedBox(
                                              height: null,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.25,
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Icon(
                                                    Icons.access_time_outlined,
                                                    color: AppColors
                                                        .liveExamGrayTextColor,
                                                    size: 16,
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                      horizontal: 8.0,
                                                    ),
                                                    child: Text(
                                                      cubit
                                                          .sourcesReferencesByIdList[
                                                              index]
                                                          .fileTime!,
                                                      style: TextStyle(
                                                        color: AppColors
                                                            .liveExamGrayTextColor,
                                                        fontSize: 16,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          SizedBox(width: 8),
                                          cubit.sourcesReferencesByIdList[index]
                                                      .fileType !=
                                                  'pdf'
                                              ? SizedBox()
                                              : ClassExamIconWidget(
                                                  type:
                                                      ImageAssets.downloadsIcon,
                                                  iconColor: AppColors.green,
                                                  radius: 8,
                                                  onclick: () {
                                                    print('wwwwwwwwwwwwwwwww');
                                                  },
                                                ),
                                          SizedBox(width: 8),
                                          cubit.sourcesReferencesByIdList[index]
                                                      .answerPdfFile ==
                                                  ''
                                              ? SizedBox()
                                              : ClassExamIconWidget(
                                                  type:
                                                      ImageAssets.answerPdfIcon,
                                                  iconColor:
                                                      AppColors.goldColor,
                                                  radius: 8,
                                                  onclick: () {},
                                                ),
                                          SizedBox(width: 8),
                                          cubit.sourcesReferencesByIdList[index]
                                                      .answerVideoFile ==
                                                  ''
                                              ? SizedBox()
                                              : ClassExamIconWidget(
                                                  type: ImageAssets.videoIcon,
                                                  iconColor: AppColors.skyColor,
                                                  radius: 8,
                                                  onclick: () {},
                                                ),
                                          SizedBox(width: 8),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              )
            ],
          ),
        );
      },
    );
  }
}
