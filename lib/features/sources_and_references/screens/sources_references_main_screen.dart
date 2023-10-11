import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_mazoon/config/routes/app_routes.dart';
import 'package:new_mazoon/core/utils/app_colors.dart';
import 'package:new_mazoon/core/widgets/no_data_widget.dart';
import 'package:new_mazoon/core/widgets/show_loading_indicator.dart';
import 'package:new_mazoon/features/sources_and_references/cubit/source_references_cubit.dart';

import '../../../core/utils/getsize.dart';
import '../../../core/widgets/title_with_circle_background_widget.dart';
import '../../lessons_of_class/cubit/lessons_class_cubit.dart';
import '../../lessons_of_class/cubit/lessons_class_state.dart';
import '../widgets/main_screen_item_widget.dart';

class SourcesAndReferencesMainScreen extends StatelessWidget {
  const SourcesAndReferencesMainScreen({Key? key}) : super(key: key);
  static List<Color> colors = [
    AppColors.orangeThirdPrimary,
    AppColors.skyColor,
    AppColors.primary,
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LessonsClassCubit, LessonsClassState>(
      builder: (context, state) {
        return Scaffold(
          body: RefreshIndicator(
            onRefresh: () async {
              context.read<SourceReferencesCubit>().sourcesAndReferencesData();
            },
            child: ListView(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: getSize(context) / 3.5),
                TitleWithCircleBackgroundWidget(
                    width: double.infinity, title: 'sources_and_references'),
                SizedBox(height: getSize(context) / 18),
                BlocBuilder<SourceReferencesCubit, SourceReferencesState>(
                  builder: (context, state) {
                    SourceReferencesCubit cubit =
                        context.read<SourceReferencesCubit>();

                    if (state is SourceReferencesLoading) {
                      return ShowLoadingIndicator();
                    }
                    if (state is SourceReferencesError) {
                      return NoDataWidget(
                        onclick: () => cubit.sourcesAndReferencesData(),
                        title: 'no_date'.tr(),
                      );
                    }
                    print('cubit.sourcesReferencesList.length');
                    print(cubit.sourcesReferencesList.length);
                    return Column(
                      children: [
                        ...List.generate(
                          cubit.sourcesReferencesList.length,
                          (index) => InkWell(
                            onTap: () {
                              cubit.referenceModel =
                                  cubit.sourcesReferencesList[index];
                              Navigator.pushNamed(
                                context,
                                Routes.sourceReferencesDetailsRoute,
                              );
                            },
                            child: MainScreenItemWidget(
                              model: cubit.sourcesReferencesList[index],
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
