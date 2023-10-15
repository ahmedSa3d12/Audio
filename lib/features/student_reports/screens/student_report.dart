import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_mazoon/features/student_reports/cubit/student_reports_cubit.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/utils/getsize.dart';
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
  void initState() {
    context.read<StudentReportsCubit>().getAllReports();
    super.initState();
  }

  bool isLoading = true;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StudentReportsCubit, StudentReportsState>(
      listener: (context, state) {
        if (state is StudentReportsPageLoading) {
          isLoading = true;
        } else {
          isLoading = false;
        }
      },
      builder: (context, state) {
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
                    child: isLoading
                        ? Center(child: CircularProgressIndicator())
                        : cubit.data.isEmpty
                            ? NoDataWidget(
                                onclick: () async {
                                  await cubit.getAllReports();
                                },
                                title: 'no_date',
                              )
                            : Container(
                                padding: EdgeInsets.all(getSize(context) / 30),
                                child: RefreshIndicator(
                                  onRefresh: () async {
                                    cubit.getAllReports();
                                  },
                                  child: RefreshIndicator(
                                    onRefresh: () async {
                                      cubit.getAllReports();
                                    },
                                    child: ListView(
                                      shrinkWrap: true,
                                      physics: const BouncingScrollPhysics(),
                                      children: [
                                        SizedBox(height: getSize(context) / 3),

                                        ListView.builder(
                                          shrinkWrap: true,
                                          physics:
                                              const BouncingScrollPhysics(),
                                          itemCount: cubit.data.length,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return ReportWidget(
                                              reports:
                                                  cubit.data.elementAt(index),
                                              index: index,
                                            );
                                          },
                                        )

                                        /////////////////////////////////
                                      ],
                                    ),
                                  ),
                                ))),
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
      },
    );
  }
}
