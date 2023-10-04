import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_mazoon/core/widgets/no_data_widget.dart';
import 'package:new_mazoon/core/widgets/pdf_screen.dart';
import 'package:new_mazoon/core/widgets/show_loading_indicator.dart';
import 'package:new_mazoon/features/favourites/cubit/favourite_cubit.dart';

import '../../../config/routes/app_routes.dart';
import '../../../core/utils/dialogs.dart';
import '../../examinstructions/cubit/examinstructions_cubit.dart';
import '../widget/exam_widget.dart';

class ExamsScreen extends StatelessWidget {
  const ExamsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FavouriteCubit, FavouriteState>(
      listener: (context, state) {
        if (state is SuccessRemoveFavoriteExam) {
          context.read<FavouriteCubit>().getAllFavourite();
        }
      },
      builder: (context, state) {
        FavouriteCubit cubit = context.read<FavouriteCubit>();
        if (state is LoadingGetFavourite) {
          return ShowLoadingIndicator();
        }
        if (state is FailureGetFavourite) {
          return NoDataWidget(
              onclick: () {
                cubit.getAllFavourite();
              },
              title: "No Data");
        }
        return RefreshIndicator(
          onRefresh: () async {
            cubit.getAllFavourite();
          },
          child: Padding(
            padding: EdgeInsets.all(8),
            child: GridView.builder(
              itemCount: cubit.allFavourite?.data.allExamFavorites!.length ?? 0,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: .75,
                mainAxisSpacing: 20,
                crossAxisSpacing: 5,
                crossAxisCount: 2,
              ),
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    if (cubit.allFavourite?.data.allExamFavorites![index]
                            .examType ==
                        'online') {
                      context.read<ExaminstructionsCubit>().examInstructions(
                          cubit.allFavourite!.data.allExamFavorites![index]
                              .examId,
                          cubit.allFavourite!.data.allExamFavorites![index]
                              .type);
                      Navigator.pushNamed(context, Routes.examInstructionsRoute,
                          arguments: [
                            cubit.allFavourite!.data.allExamFavorites![index]
                                .examId,
                            cubit.allFavourite!.data.allExamFavorites![index]
                                        .examCategoryType ==
                                    'subject_class'
                                ? 'online_exam'
                                : cubit
                                            .allFavourite!
                                            .data
                                            .allExamFavorites![index]
                                            .examCategoryType ==
                                        'video'
                                    ? 'video'
                                    : cubit
                                                .allFavourite!
                                                .data
                                                .allExamFavorites![index]
                                                .examCategoryType ==
                                            'all_exam'
                                        ? 'all_exam'
                                        : 'lesson'
                          ]);
                    } else if (cubit.allFavourite!.data.allExamFavorites![index]
                            .answerPdfFile ==
                        null) {
                      errorGetBar('no_date'.tr());
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PdfScreen(
                            pdfTitle: cubit.allFavourite!.data
                                .allExamFavorites![index].name,
                            pdfLink: cubit.allFavourite!.data
                                .allExamFavorites![index].pdfFileUpload!,
                          ),
                        ),
                      );
                    }
                  },
                  /////////use must make another custom widget
                  child: FavExamItemWidget(
                    index: index,
                    model: cubit.allFavourite!.data.allExamFavorites![index],
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
