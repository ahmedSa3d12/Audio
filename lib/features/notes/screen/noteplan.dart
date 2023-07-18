import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:new_mazoon/core/utils/assets_manager.dart';
import 'package:new_mazoon/core/widgets/my_svg_widget.dart';
import 'package:new_mazoon/core/widgets/title_with_circle_background_widget.dart';

import 'package:new_mazoon/features/notes/widget/note.dart';

import '../../../core/utils/app_colors.dart';

import '../../../core/widgets/no_data_widget.dart';

import '../cubit/note_cubit.dart';

// import '../widget/notewidget.dart';

class NotePlan extends StatefulWidget {
  const NotePlan({Key? key}) : super(key: key);

  @override
  State<NotePlan> createState() => _NoteState();
}

class _NoteState extends State<NotePlan> {
  List<DateTime> _days = [
    DateTime(2023, 5, 12),
    DateTime(2023, 7, 20),
    DateTime(2023, 7, 15)
  ]; //Date to display the icon
  EventList<Event> _getMarkedDateMap(
      List<DateTime> days, BuildContext context) {
    EventList<Event> _markedDateMap = new EventList<Event>(events: {});
    for (DateTime _date in days) {
      _markedDateMap.add(
          _date,
          new Event(
            date: _date,
            icon: _getIcon(_date), //create icon
          ));
    }
    return _markedDateMap;
  }

  Widget _getIcon(DateTime date) {
    bool _isToday = isSameDay(date, DateTime.now()); //is today？
    CalendarCarousel _calendar_default = CalendarCarousel();
    Color _today_col = _calendar_default.todayButtonColor;
    //today's background

    return Container(
        decoration: new BoxDecoration(
          // color: _isToday ? AppColors.redPrimary : AppColors.white,
          borderRadius: BorderRadius.circular(1000),
        ),
        child: Column(children: [
          Flexible(
            child: Text(
              '',
              style: TextStyle(
                  color: _isToday
                      ? AppColors.white
                      : AppColors.black, //getDayCol(date),
                  fontWeight: FontWeight.w400),
            ),
          ),
          SizedBox(
            height: 2,
          ),
          Icon(
            Icons.brightness_1,
            color: _isToday ? AppColors.white : AppColors.liveExamGrayTextColor,
            size: MediaQuery.of(context).size.width / 44,
          ), //Icon to display with date
        ]));
  }

  static bool isSameDay(DateTime day1, DateTime day2) {
    return ((day1.difference(day2).inDays) == 0 && (day1.day == day2.day));
  }

  @override
  Widget build(BuildContext context) {
    NoteCubit cubit = context.read<NoteCubit>();

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.greenDownloadColor,
        child: MySvgWidget(
            path: ImageAssets.addIcon,
            imageColor: AppColors.white,
            size: MediaQuery.of(context).size.width / 16),
        onPressed: () {},
      ),
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
                                          TitleWithCircleBackgroundWidget(
                                              title: "اضف ملاحظاتك"),
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
                                            markedDatesMap: _getMarkedDateMap(
                                                _days, context),
                                            markedDateShowIcon: true,
                                            markedDateIconMaxShown: 1,
                                            markedDateMoreShowTotal: null,
                                            markedDateIconBuilder: (event) =>
                                                event.icon,
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
                                                fontWeight: FontWeight.w700,
                                                color: AppColors.black),
                                            selectedDayTextStyle: TextStyle(
                                                fontWeight: FontWeight.w700,
                                                color: AppColors.white),
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
                                                color: AppColors.black,
                                                fontWeight: FontWeight.w700),
                                            onDayPressed: (DateTime date,
                                                List<Event> events) {
                                              cubit.getNotes(
                                                  DateFormat('yyyy-MM-dd')
                                                      .format(date),
                                                  date,
                                                  date);
                                            },
                                            weekFormat: false,
                                            showWeekDays: true,
                                            selectedDateTime: cubit.datecurrent,
                                            daysHaveCircularBorder: true,
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
