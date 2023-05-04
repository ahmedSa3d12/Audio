import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_mazoon/config/routes/app_routes.dart';
import 'package:new_mazoon/core/utils/app_colors.dart';
import 'package:new_mazoon/core/widgets/no_data_widget.dart';
import 'package:new_mazoon/core/widgets/show_loading_indicator.dart';
import 'package:new_mazoon/features/sources_and_references/cubit/source_references_cubit.dart';
import 'package:new_mazoon/features/sources_and_references/cubit/source_references_cubit.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

import '../../../core/widgets/title_with_circle_background_widget.dart';
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
    return Scaffold(
      body: ListView(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 105),
          TitleWithCircleBackgroundWidget(title: 'sources_and_references'),
          SizedBox(height: 25),
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
              return ListView(
                children: [
                  ...List.generate(
                    colors.length,
                    (index) => InkWell(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          Routes.sourceReferencesDetailsRoute,
                        );
                      },
                      child: MainScreenItemWidget(
                        mainColor: colors[index],
                      ),
                    ),
                  ),
                ],
              );
            },
          )
        ],
      ),
    );
  }
}
