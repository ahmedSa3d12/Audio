import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:new_mazoon/core/widgets/custom_button.dart';
import 'package:new_mazoon/core/widgets/my_svg_widget.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/utils/assets_manager.dart';
import '../../../core/widgets/network_image.dart';
import '../../homePage/widget/home_page_app_bar_widget.dart';

class MonthPlan extends StatefulWidget {
  const MonthPlan({Key? key}) : super(key: key);

  @override
  State<MonthPlan> createState() => _MonthPlanState();
}

class _MonthPlanState extends State<MonthPlan> {
  @override
  Widget build(BuildContext context) {
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
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
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
                            child: CalendarDatePicker2(
                              config: CalendarDatePicker2Config(
                                calendarType: CalendarDatePicker2Type.single,
                              ), value: [],


                            )),

                      ],
                    ),
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
