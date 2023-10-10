import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:new_mazoon/core/utils/assets_manager.dart';
import 'package:new_mazoon/core/utils/getsize.dart';
import 'package:new_mazoon/core/widgets/my_svg_widget.dart';
import 'package:new_mazoon/core/widgets/title_with_circle_background_widget.dart';
import 'package:new_mazoon/features/notes/widget/note.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/widgets/no_data_widget.dart';
import '../cubit/note_cubit.dart';

class NotePlan extends StatefulWidget {
  const NotePlan({Key? key}) : super(key: key);

  @override
  State<NotePlan> createState() => _NoteState();
}

class _NoteState extends State<NotePlan> {
  List<DateTime> _days = [];
  EventList<Event> _getMarkedDateMap(
      List<DateTime> days, BuildContext context) {
    EventList<Event> _markedDateMap = new EventList<Event>(events: {});
    for (DateTime _date in days) {
      _markedDateMap.add(
          _date,
          new Event(
            date: _date,
            icon: _getIcon(_date),
          ));
    }
    return _markedDateMap;
  }

  Widget _getIcon(DateTime date) {
    bool _isToday = isSameDay(date, DateTime.now());
    CalendarCarousel _calendar_default = CalendarCarousel();
    Color _today_col = _calendar_default.todayButtonColor;

    return Container(
        decoration: new BoxDecoration(
          borderRadius: BorderRadius.circular(1000),
        ),
        child: Column(children: [
          Expanded(
            flex: 7,
            child: Text(
              '',
              style: TextStyle(
                  color: _isToday ? AppColors.white : AppColors.black,
                  fontWeight: FontWeight.w400),
            ),
          ),
          Expanded(
            child: SizedBox(
              height: getSize(context) / 10,
            ),
          ),
          Expanded(
            child: Icon(
              Icons.brightness_1,
              color:
                  _isToday ? AppColors.white : AppColors.liveExamGrayTextColor,
              size: MediaQuery.of(context).size.width / 44,
            ),
          ), //Icon to display with date
        ]));
  }

  static bool isSameDay(DateTime day1, DateTime day2) {
    return ((day1.difference(day2).inDays) == 0 && (day1.day == day2.day));
  }

  @override
  void initState() {
    context.read<NoteCubit>().getDatesOfNotes().then((value) {
      for (int i = 0; i < context.read<NoteCubit>().datesOfNotes.length; i++) {
        _days.add(context.read<NoteCubit>().datesOfNotes[i].date);
      }
    });
    context.read<NoteCubit>().getNotes(
        context.read<NoteCubit>().date, DateTime.now(), DateTime.now());
    super.initState();
  }

  bool isLoadingAddNote = false;
  var key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    NoteCubit cubit = context.read<NoteCubit>();

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.greenDownloadColor,
        child: MySvgWidget(
            path: ImageAssets.addIcon,
            imageColor: AppColors.white,
            size: getSize(context)/18),
        onPressed: () {
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) {
              return Form(
                key: key,
                child: BlocConsumer<NoteCubit, NoteState>(
                  listener: (context, state) {
                    if (state is AddNewNoteLoading) {
                      isLoadingAddNote = true;
                    } else {
                      isLoadingAddNote = false;
                    }
                  },
                  builder: (context, state) {
                    return AlertDialog(
                      insetPadding: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                              Radius.circular(getSize(context) / 44))),
                      actionsAlignment: MainAxisAlignment.center,
                      // <-- SEE HERE
                      titlePadding: EdgeInsets.all(0),
                      title: Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                                vertical: getSize(context) / 22),
                            alignment: Alignment.center,
                            child: Text(
                              'add_note'.tr(),
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                color: AppColors.black,
                                fontSize: getSize(context) / 24,
                                fontFamily: 'Cairo',
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          Positioned(
                            left: 0,
                            top: 0,
                            child: IconButton(
                                onPressed: () {
                                  cubit.dateController.clear();
                                  cubit.titleController.clear();
                                  cubit.noteController.clear();
                                  Navigator.pop(context);
                                },
                                icon: MySvgWidget(
                                    path: ImageAssets.close2,
                                    imageColor: AppColors.red,
                                    size: getSize(context) / 24)),
                          )
                        ],
                      ),
                      content: Container(
                        width: MediaQuery.of(context).size.width / 1.25,
                        child: SingleChildScrollView(
                          child: ListBody(
                            children: <Widget>[
                              TextFormField(
                                readOnly: true,
                                keyboardType: TextInputType.datetime,
                                controller: cubit.dateController,
                                validator: (String? value) {
                                  if (value!.isEmpty) {
                                    return 'invalid_date'.tr();
                                  }
                                  return null;
                                },
                                onTap: () {
                                  showDatePicker(
                                    context: context,
                                    initialDate: cubit.selectedDate,
                                    firstDate: DateTime.utc(2010),
                                    lastDate: DateTime.parse('5999-10-03'),
                                  ).then((value) {
                                    cubit.dateController.text =
                                        DateFormat('y-MM-dd').format(
                                            DateTime.parse(value.toString()));
                                    print(DateFormat('y-MM-dd').format(
                                        DateTime.parse(value.toString())));
                                  }).catchError((e) {
                                    debugPrint(e);
                                  });
                                },
                                style: TextStyle(
                                    color: AppColors.black,
                                    fontSize: getSize(context) / 28),
                                decoration: InputDecoration(
                                    filled: true,
                                    // enabled: false,
                                    fillColor: AppColors.white,
                                    suffixIcon: InkWell(
                                      onTap: () {
                                        showDatePicker(
                                          context: context,
                                          initialDate: cubit.selectedDate,
                                          firstDate: DateTime.utc(2010),
                                          lastDate:
                                              DateTime.parse('5999-10-03'),
                                        ).then((value) {
                                          cubit.dateController.text =
                                              DateFormat('y-MM-dd').format(
                                                  DateTime.parse(
                                                      value.toString()));
                                          print(DateFormat('y-MM-dd').format(
                                              DateTime.parse(
                                                  value.toString())));
                                        }).catchError((e) {
                                          debugPrint(e);
                                        });
                                      },
                                      child: Padding(
                                        padding: EdgeInsets.all(
                                            getSize(context) / 32),
                                        child: MySvgWidget(
                                            path: ImageAssets.addDateIcon,
                                            imageColor: AppColors.black,
                                            size: getSize(context) / 44),
                                      ),
                                    ),
                                    labelStyle: TextStyle(
                                        color: AppColors.gray6,
                                        fontWeight: FontWeight.bold,
                                        fontSize: getSize(context) / 24),
                                    labelText: "add_date".tr(),
                                    border: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: AppColors.gray6),
                                        borderRadius: BorderRadius.circular(
                                            getSize(context) / 44)),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: AppColors.gray6),
                                        borderRadius: BorderRadius.circular(
                                            getSize(context) / 44)),
                                    disabledBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: AppColors.gray6),
                                        borderRadius: BorderRadius.circular(
                                            getSize(context) / 44))),
                              ),
                              SizedBox(
                                height: getSize(context) / 22,
                              ),
                              Container(
                                child: TextFormField(
                                  controller: cubit.titleController,
                                  validator: (String? value) {
                                    if (value!.isEmpty) {
                                      return 'invalid_title'.tr();
                                    }
                                    return null;
                                  },
                                  style: TextStyle(
                                      color: AppColors.black, fontSize: 18),
                                  decoration: InputDecoration(
                                      filled: true,
                                      fillColor: AppColors.white,
                                      prefixIcon: Padding(
                                        padding: EdgeInsets.all(
                                            getSize(context) / 32),
                                        child: MySvgWidget(
                                            path: ImageAssets.addTitleIcon,
                                            imageColor: AppColors.black,
                                            size: getSize(context) / 44),
                                      ),
                                      labelStyle: TextStyle(
                                          color: AppColors.gray6,
                                          fontWeight: FontWeight.bold,
                                          fontSize: getSize(context) / 24),
                                      labelText: "add_title".tr(),
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: AppColors.gray6),
                                          borderRadius: BorderRadius.circular(
                                              getSize(context) / 44)),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: AppColors.gray6),
                                          borderRadius: BorderRadius.circular(
                                              getSize(context) / 44)),
                                      disabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: AppColors.gray6),
                                          borderRadius: BorderRadius.circular(
                                              getSize(context) / 44))),
                                ),
                              ),
                              SizedBox(
                                height: getSize(context) / 22,
                              ),
                              Container(
                                child: TextFormField(
                                  keyboardType: TextInputType.multiline,
                                  validator: (String? value) {
                                    if (value!.isEmpty) {
                                      return 'invalid_note'.tr();
                                    }
                                    return null;
                                  },
                                  controller: cubit.noteController,
                                  minLines: 2,
                                  maxLines: 3,
                                  textAlignVertical: TextAlignVertical.top,
                                  style: TextStyle(
                                      color: AppColors.black, fontSize: 18),
                                  decoration: InputDecoration(
                                      alignLabelWithHint: true,
                                      filled: true,
                                      fillColor: AppColors.white,
                                      prefixIcon: Padding(
                                        padding: EdgeInsets.all(
                                            getSize(context) / 22),
                                        child: Align(
                                          alignment: Alignment.topCenter,
                                          widthFactor: 1,
                                          heightFactor: 5,
                                          child: MySvgWidget(
                                              path: ImageAssets.addNoteIcon,
                                              imageColor: AppColors.black,
                                              size: getSize(context) / 16),
                                        ),
                                      ),
                                      labelStyle: TextStyle(
                                          color: AppColors.gray6,
                                          fontWeight: FontWeight.bold,
                                          fontSize: getSize(context) / 24),
                                      labelText: "add_note".tr(),
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: AppColors.gray6),
                                          borderRadius: BorderRadius.circular(
                                              getSize(context) / 44)),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: AppColors.gray6),
                                          borderRadius: BorderRadius.circular(
                                              getSize(context) / 44)),
                                      disabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: AppColors.gray6),
                                          borderRadius: BorderRadius.circular(
                                              getSize(context) / 44))),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      actions: <Widget>[
                        InkWell(
                          onTap: () {
                            if (key.currentState!.validate()) {
                              cubit
                                  .addNewNote(
                                context,
                              )
                                  .then((value) {
                                cubit.getNotes(cubit.date, cubit.datefoucse,
                                    cubit.datecurrent);
                                _days.clear();
                                cubit.datesOfNotes.clear();
                                print('...............');
                                print(cubit.addNewNoteData!.note);
                                print('...............');
                                cubit.getDatesOfNotes().then((value) {
                                  for (int i = 0;
                                      i < cubit.datesOfNotes.length;
                                      i++) {
                                    _days.add(cubit.datesOfNotes[i].date);
                                  }
                                });
                              });
                            }
                          },
                          child: Container(
                            width: getSize(context) / 3,
                            height: getSize(context) / 8,
                            alignment: Alignment.center,
                            decoration: ShapeDecoration(
                              color: AppColors.green11,
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                  width: 0.50,
                                  strokeAlign: BorderSide.strokeAlignOutside,
                                  color: AppColors.green12,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: isLoadingAddNote
                                ? CircularProgressIndicator(
                                    color: AppColors.white)
                                : Text(
                                    'ok'.tr(),
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                      color: AppColors.green12,
                                      fontSize: getSize(context) / 24,
                                      fontFamily: 'Cairo',
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                          ),
                        )
                      ],
                    );
                  },
                ),
              );
            },
          );
        },
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
                        padding: EdgeInsets.all(getSize(context) / 32),
                        child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: Column(
                            children: [
                              SizedBox(height: getSize(context) / 3.5),
                              BlocBuilder<NoteCubit, NoteState>(
                                builder: (context, state) {
                                  return ListView(
                                      shrinkWrap: true,
                                      physics: const BouncingScrollPhysics(),
                                      children: [
                                        TitleWithCircleBackgroundWidget(
                                            title: 'add_note'.tr()),
                                        SizedBox(height: getSize(context) / 44),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8.0),
                                          child: Text(
                                            DateFormat(
                                                    'MMMM',
                                                    EasyLocalization.of(
                                                            context)!
                                                        .currentLocale!
                                                        .languageCode)
                                                .format(cubit.datecurrent),
                                            style: TextStyle(
                                                fontSize:
                                                    getSize(context) / 22),
                                          ),
                                        ),
                                        SizedBox(height: getSize(context) / 44),
                                        Material(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(
                                                    getSize(context) / 44)),
                                            elevation: 5,
                                            child: Container(
                                                decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.all(Radius.circular(
                                                        getSize(context) / 32)),
                                                    color: AppColors.white),
                                                child: CalendarCarousel<Event>(
                                                    markedDatesMap:
                                                        _getMarkedDateMap(
                                                            _days, context),
                                                    markedDateShowIcon: true,
                                                    markedDateIconMaxShown: 1,
                                                    markedDateMoreShowTotal:
                                                        null,
                                                    markedDateIconBuilder:
                                                        (event) => event.icon,
                                                    height:
                                                        getSize(context) / 1.25,
                                                    selectedDayButtonColor:
                                                        AppColors.redPrimary,
                                                    selectedDayBorderColor:
                                                        AppColors.redPrimary,
                                                    todayButtonColor: AppColors
                                                        .unselectedTabColor,
                                                    todayBorderColor: AppColors
                                                        .unselectedTabColor,
                                                    scrollDirection: Axis.horizontal,
                                                    showHeaderButton: false,
                                                    onCalendarChanged: (p0) {
                                                      cubit.getNotes(
                                                          DateFormat(
                                                                  'yyyy-MM-dd')
                                                              .format(p0),
                                                          p0,
                                                          p0);
                                                    },
                                                    showOnlyCurrentMonthDate: true,
                                                    showHeader: false,
                                                    weekdayTextStyle: TextStyle(color: AppColors.blue, fontWeight: FontWeight.w300),
                                                    daysTextStyle: TextStyle(fontWeight: FontWeight.w700, color: AppColors.black),
                                                    selectedDayTextStyle: TextStyle(fontWeight: FontWeight.w700, color: AppColors.white),
                                                    customWeekDayBuilder: (weekday, weekdayName) {
                                                      return Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(0.0),
                                                        child: Text(
                                                          weekdayName,
                                                          style: TextStyle(
                                                              color: AppColors
                                                                  .blue,
                                                              fontSize: getSize(
                                                                      context) /
                                                                  32,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700),
                                                        ),
                                                      );
                                                    },
                                                    pageSnapping: true,
                                                    dayPadding: 2,
                                                    weekDayPadding: EdgeInsets.all(getSize(context) / 22),
                                                    weekendTextStyle: TextStyle(
                                                      color: AppColors.black,
                                                    ),
                                                    nextDaysTextStyle: TextStyle(
                                                      color: AppColors
                                                          .descriptionBoardingColor,
                                                    ),
                                                    headerTextStyle: TextStyle(color: AppColors.black, fontWeight: FontWeight.bold, fontSize: getSize(context) / 28),
                                                    locale: EasyLocalization.of(context)!.currentLocale!.languageCode,
                                                    todayTextStyle: TextStyle(color: AppColors.black, fontWeight: FontWeight.w700),
                                                    onDayPressed: (DateTime date, List<Event> events) {
                                                      cubit.getNotes(
                                                          DateFormat(
                                                                  'yyyy-MM-dd')
                                                              .format(date),
                                                          date,
                                                          date);
                                                    },
                                                    weekFormat: false,
                                                    showWeekDays: true,
                                                    selectedDateTime: cubit.datecurrent,
                                                    daysHaveCircularBorder: true)))
                                      ]);
                                },
                              ),
                              SizedBox(height: getSize(context) / 44),
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
                                            physics:
                                                const BouncingScrollPhysics(),
                                            itemCount:
                                                cubit.noteplanList.length,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              return NoteWidget(
                                                onTap: () {
                                                  Scaffold.of(context)
                                                      .showBottomSheet(
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius: BorderRadius.only(
                                                                topRight: Radius
                                                                    .circular(
                                                                        getSize(context) /
                                                                            22),
                                                                topLeft: Radius
                                                                    .circular(
                                                                        getSize(context) /
                                                                            22)),
                                                          ), (context) {
                                                    return Container(
                                                      decoration: BoxDecoration(
                                                        color:
                                                            cubit.colorsLight[
                                                                index % 3],
                                                        borderRadius: BorderRadius.only(
                                                            topRight: Radius
                                                                .circular(getSize(
                                                                        context) /
                                                                    22),
                                                            topLeft: Radius
                                                                .circular(getSize(
                                                                        context) /
                                                                    22)),
                                                      ),
                                                      height: getSize(context),
                                                      width: double.infinity,
                                                      padding: EdgeInsets.all(
                                                          getSize(context) /
                                                              22),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          IconButton(
                                                              onPressed: () {
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                              icon: MySvgWidget(
                                                                  path: ImageAssets
                                                                      .close2,
                                                                  imageColor:
                                                                      AppColors
                                                                          .red,
                                                                  size: getSize(
                                                                          context) /
                                                                      22)),
                                                          Flexible(
                                                              child: ListView(
                                                            physics:
                                                                const BouncingScrollPhysics(),
                                                            children: [
                                                              Container(
                                                                alignment:
                                                                    Alignment
                                                                        .center,
                                                                child: Text(
                                                                  cubit
                                                                      .noteplanList[
                                                                          index]
                                                                      .title,
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          getSize(context) /
                                                                              24,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w800,
                                                                      color: cubit
                                                                              .colors[
                                                                          index %
                                                                              3]),
                                                                ),
                                                              ),
                                                              Text(
                                                                cubit
                                                                    .noteplanList[
                                                                        index]
                                                                    .note,
                                                                style: TextStyle(
                                                                    color: AppColors
                                                                        .liveExamGrayTextColor,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                    fontSize: MediaQuery.of(context)
                                                                            .size
                                                                            .width /
                                                                        26),
                                                              ),
                                                              Text(
                                                                DateFormat
                                                                        .yMMMEd()
                                                                    .format(cubit
                                                                        .noteplanList[
                                                                            index]
                                                                        .date),
                                                                maxLines: 1,
                                                                overflow:
                                                                    TextOverflow
                                                                        .clip,
                                                                style: TextStyle(
                                                                    color: AppColors
                                                                        .liveExamGrayTextColor,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w200,
                                                                    fontSize: MediaQuery.of(context)
                                                                            .size
                                                                            .width /
                                                                        32),
                                                              ),
                                                            ],
                                                          )),
                                                        ],
                                                      ),
                                                    );
                                                  });
                                                },
                                                onPressed: () {
                                                  cubit
                                                      .deleteNote(
                                                          cubit
                                                              .noteplanList[
                                                                  index]
                                                              .id,
                                                          index)
                                                      .then((value) {
                                                    //
                                                    cubit.datesOfNotes.clear();
                                                    _days.clear();
                                                    cubit
                                                        .getDatesOfNotes()
                                                        .then((value) {
                                                      for (int i = 0;
                                                          i <
                                                              cubit.datesOfNotes
                                                                  .length;
                                                          i++) {
                                                        _days.add(cubit
                                                            .datesOfNotes[i]
                                                            .date);
                                                      }
                                                    });
                                                  });
                                                },
                                                noteModel: cubit.noteplanList
                                                    .elementAt(index),
                                                index: index,
                                              );
                                            },
                                          )
                                        : NoDataWidget(
                                            onclick: () {
                                              cubit.getNotes(
                                                  cubit.date,
                                                  cubit.datefoucse,
                                                  cubit.datecurrent);
                                            },
                                            title: 'no_date',
                                          );
                                  } else {
                                    return NoDataWidget(
                                      onclick: () {
                                        cubit.getNotes(
                                            cubit.date,
                                            cubit.datefoucse,
                                            cubit.datecurrent);
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
