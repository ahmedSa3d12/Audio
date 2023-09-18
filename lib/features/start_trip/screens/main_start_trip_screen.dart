import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/utils/getsize.dart';
import '../../../core/widgets/title_with_circle_background_widget.dart';
import '../cubit/start_trip_cubit.dart';
import 'classes_exam_screen.dart';
import 'classes_screen.dart';
import 'final_review_screen.dart';

class StartTripScreen extends StatefulWidget {
  StartTripScreen({Key? key}) : super(key: key);

  @override
  State<StartTripScreen> createState() => _StartTripScreenState();
}

class _StartTripScreenState extends State<StartTripScreen>
    with TickerProviderStateMixin {
  List<String> titles = [
    'explanation'.tr(),
    'class_exams'.tr(),
    'final_review'.tr()
  ];
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.animateTo(context.read<StartTripCubit>().currentIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<StartTripCubit, StartTripState>(
        builder: (context, state) {
          StartTripCubit cubit = context.read<StartTripCubit>();
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: getSize(context) / 3.5),
              TitleWithCircleBackgroundWidget(title: 'start_trip'),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    ...List.generate(
                      titles.length,
                      (index) => Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8.0,
                          vertical: 8,
                        ),
                        child: InkWell(
                          onTap: () {
                            cubit.selectTap(index);
                            print(cubit.currentIndex);
                            _tabController.animateTo(index);
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 30,
                              vertical: 10,
                            ),
                            decoration: BoxDecoration(
                              color: cubit.currentIndex == index
                                  ? AppColors.orangeThirdPrimary
                                  : AppColors.unselectedTabColor,
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: Center(
                              child: Text(
                                titles[index],
                                style: TextStyle(
                                  color: cubit.currentIndex == index
                                      ? AppColors.white
                                      : AppColors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () async {
                    print(88888);
                  },
                  child: TabBarView(
                    controller: _tabController,
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      ClassesScreen(),
                      ClassesExamsScreen(),
                      FinalReviewScreen(),
                    ],
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
