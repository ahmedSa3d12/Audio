import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widgets/banner.dart';
import '../../../../core/widgets/no_data_widget.dart';
import '../../../../core/widgets/show_loading_indicator.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/getsize.dart';
import '../cubit/home_page_cubit.dart';
import '../widget/final_review_widget.dart';
import '../widget/home_page_start_study_widget.dart';
import '../widget/home_page_video_item_widget.dart';
import '../widget/live_exam_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<HomePageCubit, HomePageState>(
        builder: (context, state) {
          HomePageCubit cubit = context.read<HomePageCubit>();
          if (state is HomePageLoading) {
            return ShowLoadingIndicator();
          } else if (state is HomePageLoaded) {
            return RefreshIndicator(
              onRefresh: () async {
                cubit.getHomePageData();
              },
              color: AppColors.white,
              backgroundColor: AppColors.secondPrimary,
              child: ListView(
                physics: const BouncingScrollPhysics(),
                children: [
                  SizedBox(height: getSize(context) / 3.5),

                  BannerWidget(sliderData: state.model.data!.sliders!),
                  //
                  state.model.data!.lifeExam != null
                      ? LiveExamWarningWidget()
                      : SizedBox(
                          height: 30,
                        ),
                  HomePageVideoWidget(
                    videosBasics: cubit.videosBasics,
                    title: 'train_yourself',
                  ),
                  HomePageStartStudyWidget(classes: cubit.classes),
                  FinalReviewWidget(
                    model: cubit.videosResources,
                    title: 'all_exams',
                  ),
                ],
              ),
            );
          } else {
            return NoDataWidget(
              onclick: () => cubit.getHomePageData(),
              title: 'no_date',
            );
          }
        },
      ),
    );
  }
}
