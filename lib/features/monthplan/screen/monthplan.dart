import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_mazoon/core/utils/hex_color.dart';
import 'package:new_mazoon/core/widgets/custom_button.dart';
import 'package:new_mazoon/core/widgets/my_svg_widget.dart';
import 'package:new_mazoon/features/monthplan/cubit/month_cubit.dart';
import 'package:new_mazoon/features/monthplan/cubit/monthplan_state.dart';
import 'package:new_mazoon/features/monthplan/widget/monthpalnwidget.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:neon_circular_timer/neon_circular_timer.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/utils/assets_manager.dart';
import '../../../core/widgets/network_image.dart';
import '../../../core/widgets/no_data_widget.dart';
import '../../../core/widgets/show_loading_indicator.dart';
import '../../homePage/widget/home_page_app_bar_widget.dart';

class MonthPlan extends StatefulWidget {
  const MonthPlan({Key? key}) : super(key: key);

  @override
  State<MonthPlan> createState() => _MonthPlanState();
}

class _MonthPlanState extends State<MonthPlan> {
  @override
  Widget build(BuildContext context) {
    MonthPlanCubit cubit = context.read<MonthPlanCubit>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.secondPrimary,
        toolbarHeight: 0,
      ),
      body: SafeArea(
        top: false,
        maintainBottomViewPadding: true,
        child: Stack(
          children: [
            Positioned(
              top: 0,
              right: 0,
              left: 0,
              bottom: 0,
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: NestedScrollView(
                    body: Column(
                      children: [
                        SizedBox(height: 110),
                        Container(
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15)),
                              gradient: LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                colors: [
                                  AppColors.blue1,
                                  AppColors.blue2,
                                ],
                              ),
                            ),
                            child: CalendarDatePicker(
                              onDateChanged: (value) {
                                String formattedDate =
                                    DateFormat('yyyy-MM-dd').format(value);

                                cubit.getMonthPlan(formattedDate);
                              },
                              firstDate: DateTime(1700, 01, 01),
                              lastDate: DateTime(3000, 12, 31),
                              initialDate: DateTime.now(),
                            )),
                        SizedBox(
                          height: 20,
                        ),
                        // NeonCircularTimer(
                        //   width: 200,
                        //   duration: 20,
                        //   backgroudColor: AppColors.white,
                        //   isTimerTextShown: true,
                        //   neumorphicEffect: true,
                        //   innerFillColor: Colors.amber,
                        //   initialDuration: 0,
                        //   isReverse: true,
                        //   isReverseAnimation: true,
                        //   neonColor: Colors.orange,
                        //   controller: null,
                        //   strokeWidth: 1,
                        //   strokeCap: StrokeCap.butt,
                        // ),

                        BlocBuilder<MonthPlanCubit, MonthPlanState>(
                          builder: (context, state) {
                            if (state is MonthPlanLoading) {
                              return CircularProgressIndicator(
                                color: AppColors.primary,
                              );
                            } else if (state is MonthPlanLoaded) {
                              return RefreshIndicator(
                                  onRefresh: () async {
                                    cubit.getMonthPlan(cubit.date);
                                  },
                                  color: AppColors.white,
                                  backgroundColor: AppColors.secondPrimary,
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: cubit.monthplanList.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return MonthPlanWidget(
                                          color1: HexColor(cubit.monthplanList
                                              .elementAt(index)
                                              .backgroundColor!),
                                          color2: darken(HexColor(cubit
                                              .monthplanList
                                              .elementAt(index)
                                              .backgroundColor!),.1),
                                          title: cubit.monthplanList
                                              .elementAt(index)
                                              .title!,
                                          desc: cubit.monthplanList
                                              .elementAt(index)
                                              .description!,
                                          index: index + 1);
                                    },
                                  ));
                            } else {
                              return NoDataWidget(
                                onclick: () => cubit.getMonthPlan(cubit.date),
                                title: 'no_date',
                              );
                            }
                          },
                        )
                      ],
                    ),
                    headerSliverBuilder:
                        (BuildContext context, bool innerBoxIsScrolled) {
                      return [];
                    },
                  ),
                ),
              ),
            ),
            Positioned(
              top: 0,
              right: 0,
              left: 0,
              child: HomePageAppBarWidget(),
            ),
          ],
        ),
      ),
    );
  }
}
