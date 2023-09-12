import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:new_mazoon/core/utils/hex_color.dart';

import 'package:new_mazoon/features/monthplan/cubit/month_cubit.dart';
import 'package:new_mazoon/features/monthplan/cubit/monthplan_state.dart';
import 'package:new_mazoon/features/monthplan/widget/monthpalnwidget.dart';

import '../../../core/utils/app_colors.dart';

import '../../../core/widgets/no_data_widget.dart';
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
              child: BlocBuilder<MonthPlanCubit, MonthPlanState>(
                builder: (context, state) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
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
                              child:
                                  BlocBuilder<MonthPlanCubit, MonthPlanState>(
                                builder: (context, state) {
                                  return ListView(
                                      shrinkWrap: true,
                                      physics: const BouncingScrollPhysics(),
                                      children: [
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(DateFormat(
                                                  'MMM, yyy',
                                                  EasyLocalization.of(context)!
                                                      .currentLocale!
                                                      .languageCode)
                                              .format(cubit.datecurrent)),
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        CalendarCarousel<Event>(
                                          height: 310,
                                          selectedDayButtonColor:
                                              AppColors.white,
                                          selectedDayBorderColor:
                                              AppColors.white,
                                          todayButtonColor: AppColors.red,
                                          todayBorderColor: AppColors.red,
                                          scrollDirection: Axis.horizontal,

                                          showHeaderButton: false,

                                          onCalendarChanged: (p0) {
                                            cubit.getMonthPlan(
                                                DateFormat('yyyy-MM-dd')
                                                    .format(p0),
                                                p0,
                                                p0);
                                          },
                                          showOnlyCurrentMonthDate: true,
                                          showHeader: false,

                                          weekdayTextStyle: TextStyle(
                                              color: AppColors.blue,
                                              fontWeight: FontWeight.w300),
                                          daysTextStyle:
                                              TextStyle(color: AppColors.black),

                                          customWeekDayBuilder:
                                              (weekday, weekdayName) {
                                            return Padding(
                                              padding:
                                                  const EdgeInsets.all(3.0),
                                              child: Text(
                                                weekdayName,
                                                style: TextStyle(
                                                    color: AppColors.blue,
                                                    fontSize: 13,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            );
                                          },
                                          pageSnapping: true,
                                          dayPadding: 2,

                                          weekDayPadding: EdgeInsets.all(8),
                                          weekendTextStyle:
                                              TextStyle(color: AppColors.black),
                                          nextDaysTextStyle: TextStyle(
                                              color: AppColors
                                                  .descriptionBoardingColor),

                                          headerTextStyle: TextStyle(
                                              color: AppColors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 17),
                                          locale: EasyLocalization.of(context)!
                                              .currentLocale!
                                              .languageCode,
                                          todayTextStyle:
                                              TextStyle(color: AppColors.white),
                                          onDayPressed: (DateTime date,
                                              List<Event> events) {
                                            cubit.getMonthPlan(
                                                DateFormat('yyyy-MM-dd')
                                                    .format(date),
                                                date,
                                                date);
                                          },

                                          // weekendTextStyle: TextStyle(
                                          //   color: Colors.red,
                                          // ),

                                          weekFormat: false,
                                          showWeekDays: true,
                                          selectedDateTime: cubit.datecurrent,
                                          daysHaveCircularBorder: true,

                                          /// null for not rendering any border, true for circular border, false for rectangular border
                                        )
                                      ]);
                                },
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
                                return Center(
                                  child: CircularProgressIndicator(
                                    color: AppColors.primary,
                                  ),
                                );
                              } else if (state is MonthPlanLoaded) {
                                return cubit.monthplanList.isNotEmpty
                                    ? ListView.builder(
                                        physics: const BouncingScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount: cubit.monthplanList.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return MonthPlanWidget(
                                              color1: HexColor(cubit
                                                  .monthplanList
                                                  .elementAt(index)
                                                  .backgroundColor!),
                                              color2: darken(
                                                  HexColor(cubit.monthplanList
                                                      .elementAt(index)
                                                      .backgroundColor!),
                                                  .5),
                                              title: cubit.monthplanList
                                                  .elementAt(index)
                                                  .title!,
                                              desc: cubit.monthplanList
                                                  .elementAt(index)
                                                  .description!,
                                              index: index + 1);
                                        },
                                      )
                                    : NoDataWidget(
                                        onclick: () => cubit.getMonthPlan(
                                            cubit.date,
                                            cubit.datefoucse,
                                            cubit.datecurrent),
                                        title: 'no_date',
                                      );
                              } else {
                                return NoDataWidget(
                                  onclick: () => cubit.getMonthPlan(cubit.date,
                                      cubit.datefoucse, cubit.datecurrent),
                                  title: 'no_date',
                                );
                              }
                            },
                          )
                        ],
                      ),
                    )),
                  );
                },
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
