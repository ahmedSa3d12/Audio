import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_mazoon/core/utils/assets_manager.dart';
import '../../../core/widgets/no_data_widget.dart';
import '../../../core/widgets/show_loading_indicator.dart';
import '../cubit/start_trip_cubit.dart';
import '../widgets/item_final_review_widget.dart';

class FinalReviewScreen extends StatelessWidget {
  FinalReviewScreen({Key? key}) : super(key: key);

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
            child: ListView(
              children: [
                SizedBox(height: 10),
                cubit.finalReview.isNotEmpty
                    ? GridView.builder(
                        shrinkWrap: true,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          childAspectRatio: 0.85,
                          mainAxisSpacing: 15,
                          crossAxisSpacing: 20,
                          crossAxisCount: 2,
                        ),
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: cubit.finalReview.length,
                        itemBuilder: (BuildContext context, int index) {
                          return ItemOfFinalReviewWidget(
                            model: cubit.finalReview[index],
                          );
                        },
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.15),
                          Image.asset(
                            ImageAssets.comingSoonImage,
                            width: 250,
                            height: 190,
                          ),
                          SizedBox(height: 25),
                          Visibility(
                            visible: cubit.finalReview.isEmpty,
                            child: Text(
                              'coming_soon'.tr(),
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      ),
                SizedBox(height: 25),
              ],
            ),
          ),
        );
      },
    );
  }
}
