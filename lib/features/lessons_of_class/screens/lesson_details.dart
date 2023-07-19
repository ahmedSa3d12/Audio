import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_mazoon/core/utils/app_colors.dart';
import 'package:new_mazoon/core/widgets/title_with_circle_background_widget.dart';
import 'package:new_mazoon/features/start_trip/screens/classes_exam_screen.dart';

import '../../homePage/widget/home_page_app_bar_widget.dart';
import '../../start_trip/cubit/start_trip_cubit.dart';
import '../../start_trip/screens/classes_screen.dart';

class LessonDetails extends StatefulWidget {
  const LessonDetails({super.key});

  @override
  State<LessonDetails> createState() => _LessonDetailsState();
}

class _LessonDetailsState extends State<LessonDetails>
    with TickerProviderStateMixin {
  List<String> titles = [
    'expnain'.tr(),
    'less_exam'.tr(),
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
      appBar: AppBar(
        backgroundColor: AppColors.secondPrimary,
        toolbarHeight: 0,
      ),
      body: BlocBuilder<StartTripCubit, StartTripState>(
        builder: (context, state) {
          StartTripCubit cubit = context.read<StartTripCubit>();

          return SafeArea(
            child: Stack(
              children: [
                Column(
                  children: [
                    SizedBox(height: 115),
                    Positioned(
                      top: 0,
                      right: 0,
                      left: 0,
                      bottom: 0,
                      child: TitleWithCircleBackgroundWidget(title: "title"),
                    ),
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
                          ],
                        ),
                      ),
                    )
                  ],
                ),

                ///
                Positioned(
                  top: 0,
                  right: 0,
                  left: 0,
                  child: HomePageAppBarWidget(isHome: false),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
