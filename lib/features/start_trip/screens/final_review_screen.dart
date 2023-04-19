import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utils/assets_manager.dart';
import '../../../core/utils/hex_color.dart';
import '../../../core/widgets/no_data_widget.dart';
import '../../../core/widgets/show_loading_indicator.dart';
import '../cubit/start_trip_cubit.dart';
import '../widgets/item_final_review_widget.dart';

class FinalReviewScreen extends StatelessWidget {
  FinalReviewScreen({Key? key}) : super(key: key);

  List<String> classNumber = [
    'الفصل الاول',
    'الفصل الثانى',
    'الفصل الثالث',
    'الفصل الرابع'
  ];
  List<Color> mainColors = [
    HexColor('#48B8E0'),
    HexColor('#E4312A'),
    HexColor('#009541'),
    HexColor('#F4BC35'),
  ];
  List<String> imagesPath = [
    ImageAssets.Image1,
    ImageAssets.Image2,
    ImageAssets.Image3,
    ImageAssets.Image4,
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StartTripCubit, StartTripState>(
      builder: (context, state) {
        StartTripCubit cubit = context.read<StartTripCubit>();
        if (state is StartTripFinalReviewLoading) {
          return ShowLoadingIndicator();
        }
        if (state is StartTripFinalReviewError) {
          return NoDataWidget(
            onclick: () {
              cubit.getExplanationData();
            },
            title: 'no_date',
          );
        }

        return RefreshIndicator(
          onRefresh: () async {
            cubit.getFinalReviewData();
          },
          child: Padding(
            padding: const EdgeInsets.only(
              left: 15.0,
              right: 15,
            ),
            child: GridView.builder(
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 0.85,
                mainAxisSpacing: 15,
                crossAxisSpacing: 20,
                crossAxisCount: 2,
              ),
              itemCount: cubit.finalReview.length,
              itemBuilder: (BuildContext context, int index) {
                return ItemOfFinalReviewWidget(
                  classNum: cubit.finalReview[index].name!,
                  time: cubit.finalReview[index].time!,
                  imagePath: cubit.finalReview[index].image!,
                  type: cubit.finalReview[index].type!,
                  mainColor:
                      HexColor(cubit.finalReview[index].backgroundColor!),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
