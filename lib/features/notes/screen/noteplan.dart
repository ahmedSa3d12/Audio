import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:new_mazoon/core/utils/hex_color.dart';
import 'package:new_mazoon/core/widgets/custom_button.dart';
import 'package:new_mazoon/core/widgets/my_svg_widget.dart';
import 'package:new_mazoon/features/monthplan/cubit/month_cubit.dart';
import 'package:new_mazoon/features/monthplan/cubit/monthplan_state.dart';
import 'package:new_mazoon/features/monthplan/widget/monthpalnwidget.dart';
import 'package:new_mazoon/features/notes/widget/note.dart';
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
import '../cubit/note_cubit.dart';
// import '../widget/notewidget.dart';

class NotePlan extends StatefulWidget {
  const NotePlan({Key? key}) : super(key: key);

  @override
  State<NotePlan> createState() => _NoteState();
}

class _NoteState extends State<NotePlan> {
  @override
  Widget build(BuildContext context) {
    NoteCubit cubit = context.read<NoteCubit>();

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
              child: BlocBuilder<NoteCubit, NoteState>(
                builder: (context, state) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        child: SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(height: 110),
                          Material(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            elevation: 2,
                            child: Container(
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15)),
                                    color: AppColors.white),
                                child: BlocBuilder<NoteCubit, NoteState>(
                                  builder: (context, state) {
                                    return ListView(
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        children: [
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(DateFormat(
                                                    'MMMM',
                                                    EasyLocalization.of(
                                                            context)!
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
                                                AppColors.redPrimary,
                                            selectedDayBorderColor:
                                                AppColors.redPrimary,
                                            todayButtonColor:
                                                AppColors.unselectedTabColor,
                                            todayBorderColor:
                                                AppColors.unselectedTabColor,
                                            scrollDirection: Axis.horizontal,

                                            showHeaderButton: false,

                                            onCalendarChanged: (p0) {
                                              cubit.getNotes(
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
                                            daysTextStyle: TextStyle(
                                                color: AppColors.black),

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
                                            weekendTextStyle: TextStyle(
                                                color: AppColors.black),
                                            nextDaysTextStyle: TextStyle(
                                                color: AppColors
                                                    .descriptionBoardingColor),

                                            headerTextStyle: TextStyle(
                                                color: AppColors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 17),
                                            locale:
                                                EasyLocalization.of(context)!
                                                    .currentLocale!
                                                    .languageCode,
                                            todayTextStyle: TextStyle(
                                                color: AppColors.white),
                                            onDayPressed: (DateTime date,
                                                List<Event> events) {
                                              cubit.getNotes(
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
                          ),
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
////////////////////////////////////////
                          BlocBuilder<NoteCubit, NoteState>(
                            builder: (context, state) {
                              if (state is NoteLoading) {
                                return Center(
                                  child: CircularProgressIndicator(
                                    color: AppColors.primary,
                                  ),
                                );
                              } else if (state is NoteLoaded) {
                                return cubit.noteplanList.isNotEmpty
                                    ? ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: cubit.noteplanList.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return NoteWidget(
                                            noteModel: cubit.noteplanList
                                                .elementAt(index),
                                            index: index,
                                          );
                                        },
                                      )
                                    : NoDataWidget(
                                        onclick: () => () {
                                          cubit.getNotes(
                                              cubit.date,
                                              cubit.datefoucse,
                                              cubit.datecurrent);
                                        },
                                        title: 'no_date',
                                      );
                              } else {
                                return NoDataWidget(
                                  onclick: () => {
                                    cubit.getNotes(cubit.date, cubit.datefoucse,
                                        cubit.datecurrent),
                                  },
                                  title: 'no_date',
                                );
                              }
                            },
                          )
                          /////////////////////////////////
                        ],
                      ),
                    )),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
