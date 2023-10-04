import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_mazoon/core/utils/app_colors.dart';
import 'package:new_mazoon/core/utils/assets_manager.dart';
import 'package:new_mazoon/core/utils/getsize.dart';
import 'package:new_mazoon/core/widgets/my_svg_widget.dart';
import 'package:readmore/readmore.dart';

import '../../../core/models/student_reports_model.dart';
import '../cubit/student_reports_cubit.dart';

class ReportWidget extends StatefulWidget {
  const ReportWidget({Key? key, required this.reports, required this.index})
      : super(key: key);
  final StudentReports reports;
  final int index;

  @override
  State<ReportWidget> createState() => _ReportWidgetState();
}

class _ReportWidgetState extends State<ReportWidget> {
  List<Color> colors = [AppColors.orange, AppColors.blue, AppColors.purple1];
  List<Color> colorsLight = [
    AppColors.orangelight,
    AppColors.bluelight,
    AppColors.purple1light
  ];

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StudentReportsCubit, StudentReportsState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = context.read<StudentReportsCubit>();
        return Padding(
          padding: EdgeInsets.symmetric(vertical: getSize(context) / 88),
          child: Material(
            elevation: 2,
            color: colorsLight[widget.index % 3],
            borderRadius:
                BorderRadius.circular(MediaQuery.of(context).size.width / 30),
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: getSize(context) / 40),
                    child: Row(
                      children: [
                        Text(
                          'report_about'.tr() + widget.reports.title,
                          style: TextStyle(
                              color: colors[widget.index % 3],
                              fontWeight: FontWeight.bold,
                              fontSize: getSize(context) / 30),
                        ),
                        Spacer(),
                        Container(
                          alignment: Alignment.topCenter,
                          child: IconButton(
                            padding: EdgeInsets.only(
                                top: MediaQuery.of(context).size.width / 44),
                            alignment: Alignment.topCenter,
                            icon: MySvgWidget(
                                path: ImageAssets.deleteIcon,
                                imageColor: AppColors.error,
                                size: MediaQuery.of(context).size.width / 18),
                            onPressed: () {
                              cubit.deleteReport(
                                  id: cubit.data[widget.index].id.toString());
                              //
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: getSize(context) / 90,
                  ),
                  Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: getSize(context) / 40),
                      child: ReadMoreText(
                        widget.reports.report,
                        trimLines: 3,
                        colorClickableText: AppColors.unselectedTabColor,
                        trimMode: TrimMode.Line,
                        lessStyle: TextStyle(
                            color: colors[widget.index % 3],
                            fontWeight: FontWeight.bold,
                            fontSize: getSize(context) / 30),
                        trimCollapsedText: 'see_more'.tr(),
                        trimExpandedText: 'see_less'.tr(),
                        moreStyle: TextStyle(
                            color: colors[widget.index % 3],
                            fontWeight: FontWeight.bold,
                            fontSize: getSize(context) / 30),
                      )),
                  SizedBox(
                    height: getSize(context) / 60,
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: getSize(context) / 40),
                    child: Row(
                      children: [
                        Center(
                            child: Icon(
                          Icons.calendar_month_outlined,
                          color: AppColors.liveExamGrayTextColor,
                        )),
                        SizedBox(
                          width: getSize(context) / 22,
                        ),
                        Center(
                          child: Text(
                            widget.reports.createdAt,
                            style: TextStyle(
                                color: AppColors.liveExamGrayTextColor,
                                fontWeight: FontWeight.normal,
                                fontSize: getSize(context) / 30),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
