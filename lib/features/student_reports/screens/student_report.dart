import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_mazoon/features/student_reports/cubit/student_reports_cubit.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/utils/getsize.dart';
import '../../../core/widgets/my_svg_widget.dart';
import '../../../core/widgets/no_data_widget.dart';
import '../../homePage/widget/home_page_app_bar_widget.dart';
import '../widget/report.dart';

class StudentReportScreen extends StatefulWidget {
  const StudentReportScreen({super.key});

  @override
  State<StudentReportScreen> createState() => _StudentReportScreenState();
}

class _StudentReportScreenState extends State<StudentReportScreen> {
  @override

  Widget build(BuildContext context) {
    StudentReportsCubit cubit = context.read<StudentReportsCubit>();

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
              child: BlocBuilder<StudentReportsCubit, StudentReportsState>(
                builder: (context, state) {
                  return Container(
                      padding: EdgeInsets.all(getSize(context) / 30),
                      child: Column(
                        children: [
                          SizedBox(height: 110),

                          BlocBuilder<StudentReportsCubit, StudentReportsState>(
                            builder: (context, state) {
                              if (state is StudentReportsPageLoading) {
                                return Center(
                                  child: CircularProgressIndicator(
                                    color: AppColors.primary,
                                  ),
                                );
                              } else if (state is StudentReportsPageLoaded) {
                                return cubit.data.isNotEmpty
                                    ? ListView.builder(
                                  shrinkWrap: true,
                                  itemCount:
                                  cubit.data.length,
                                  itemBuilder: (BuildContext context,
                                      int index) {
                                    return ReportWidget(
                                      reports: cubit.data
                                          .elementAt(index),
                                      index: index,
                                    );
                                  },
                                )
                                    : NoDataWidget(
                                  onclick: () => () {
                                    cubit.getAllReports(
                                    );
                                  },
                                  title: 'no_date',
                                );
                              } else {
                                return NoDataWidget(
                                  onclick: () => {
                                    cubit.getAllReports(
                                       ),
                                  },
                                  title: 'no_date',
                                );
                              }
                            },
                          )
                          /////////////////////////////////
                        ],
                      ));
                },
              ),
            ),
            Positioned(
              top: 0,
              right: 0,
              left: 0,
              child: HomePageAppBarWidget(isHome: false),
            ),
          ],
        ),
      ),
    );
  }
}
