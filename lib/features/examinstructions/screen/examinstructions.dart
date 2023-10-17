import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_mazoon/core/utils/getsize.dart';
import 'package:new_mazoon/core/widgets/my_svg_widget.dart';
import 'package:new_mazoon/features/examinstructions/widget/instructionsettingwidget.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../core/models/exam_instruction_model.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/assets_manager.dart';
import '../../../core/widgets/network_image.dart';
import '../../../core/widgets/no_data_widget.dart';
import '../../../core/widgets/show_loading_indicator.dart';
import '../../../core/widgets/title_with_circle_background_widget.dart';
import '../../homePage/widget/home_page_app_bar_widget.dart';
import '../../lessonExamScreen/cubit/questionlessonexamcubit.dart';
import '../cubit/examinstructions_cubit.dart';

class ExamInstructions extends StatefulWidget {
  const ExamInstructions({Key? key, required this.exam_id, required this.type})
      : super(key: key);
  final int exam_id;
  final String type;

  @override
  State<ExamInstructions> createState() => _ExamInstructionsState();
}

class _ExamInstructionsState extends State<ExamInstructions> {
  @override
  void initState() {
    super.initState();
    // context
    //     .read<ExaminstructionsCubit>()
    //     .examInstructions(widget.exam_id, widget.type);
  }

  @override
  Widget build(BuildContext context) {
    ExaminstructionsCubit cubit = context.read<ExaminstructionsCubit>();

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
                child:
                    BlocBuilder<ExaminstructionsCubit, ExaminstructionsState>(
                  builder: (context, state) {
                    if (state is ExaminstructionsLoading) {
                      return ShowLoadingIndicator();
                    } else if (state is ExaminstructionsLoaded) {
                      ExamInstructionModel examinstructions =
                          state.examInstructionModel;
                      return SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(14.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: getSize(context) / 3),
                              TitleWithCircleBackgroundWidget(
                                  title: examinstructions.data!.details!.name ??
                                      '',
                                  width: double.infinity),
                              // Text(
                              //   examinstructions.data!.details!.name ?? '',
                              //   style: TextStyle(
                              //       fontSize: getSize(context) / 28,
                              //       color: AppColors.black,
                              //       fontWeight: FontWeight.bold),
                              // ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  SizedBox(width: 20),
                                  InstructionSettingWidget(
                                      icon: ImageAssets.questionIcon,
                                      color: AppColors.orange,
                                      color2: AppColors.orangelight,
                                      title: examinstructions
                                              .data!.details!.numOfQuestion
                                              .toString() +
                                          "q".tr()),
                                  SizedBox(width: 20),
                                  InstructionSettingWidget(
                                      icon: ImageAssets.timeIcon,
                                      color: AppColors.blue,
                                      color2: AppColors.bluelight,
                                      title: examinstructions
                                              .data!.details!.totalTime
                                              .toString() +
                                          "min".tr()),
                                  SizedBox(width: 20),
                                  InstructionSettingWidget(
                                      icon: ImageAssets.loadIcon,
                                      color: AppColors.purple1,
                                      color2: AppColors.purple1light,
                                      title: examinstructions
                                              .data!.details!.tryingNumber!
                                              .toString() +
                                          "try".tr()),
                                  SizedBox(width: 20),
                                ],
                              ),
                              SizedBox(
                                height: getSize(context) / 22,
                              ),
                              examinstructions.data!.user == null
                                  ? Container()
                                  : TitleWithCircleBackgroundWidget(
                                      title: "best_result",
                                      width: double.infinity,
                                    ),
                              SizedBox(
                                height: getSize(context) / 22,
                              ),
                              examinstructions.data!.user == null
                                  ? Container()
                                  : Container(
                                      decoration: BoxDecoration(
                                          color: AppColors.bluelight,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(15))),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 9, vertical: 2),
                                        child: Center(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Align(
                                                alignment: Alignment.center,
                                                child: examinstructions.data!
                                                            .user!.image ==
                                                        null
                                                    ? MySvgWidget(
                                                        path: ImageAssets
                                                            .loadIcon,
                                                        imageColor:
                                                            AppColors.black,
                                                        size: getSize(context) /
                                                            22)
                                                    : ManageNetworkImage(
                                                        imageUrl:
                                                            examinstructions
                                                                .data!
                                                                .user!
                                                                .image!,
                                                        width: 50,
                                                        height: 50,
                                                        borderRadius: 90,
                                                      ),
                                              ),
                                              SizedBox(width: 16),
                                              Flexible(
                                                fit: FlexFit.tight,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      examinstructions
                                                          .data!.user!.name!,
                                                      style: TextStyle(
                                                          color:
                                                              AppColors.black,
                                                          fontSize:
                                                              getSize(context) /
                                                                  28,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 4.0),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(4.0),
                                                            child: Text(
                                                              EasyLocalization.of(
                                                                              context)!
                                                                          .currentLocale!
                                                                          .languageCode ==
                                                                      'ar'
                                                                  ? examinstructions
                                                                      .data!
                                                                      .user!
                                                                      .city!
                                                                      .nameAr!
                                                                  : examinstructions
                                                                      .data!
                                                                      .user!
                                                                      .city!
                                                                      .nameEn!,
                                                              style: TextStyle(
                                                                  color:
                                                                      AppColors
                                                                          .black,
                                                                  fontSize:
                                                                      getSize(context) /
                                                                          32,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400),
                                                            ),
                                                          ),
                                                          Row(
                                                            children: [
                                                              MySvgWidget(
                                                                  path: ImageAssets
                                                                      .timeIcon,
                                                                  imageColor:
                                                                      AppColors
                                                                          .blue,
                                                                  size: getSize(
                                                                          context) /
                                                                      22),
                                                              SizedBox(
                                                                width: 3,
                                                              ),
                                                              Text(
                                                                examinstructions
                                                                        .data!
                                                                        .user!
                                                                        .totalTime
                                                                        .toString() +
                                                                    "min".tr(),
                                                                style: TextStyle(
                                                                    color:
                                                                        AppColors
                                                                            .blue,
                                                                    fontSize:
                                                                        getSize(context) /
                                                                            32,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                            ],
                                                          )
                                                          // SizedBox(width: 10),
                                                          ,
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                width: getSize(context) / 4,
                                                height: getSize(context) / 4,
                                                child: SfCircularChart(
                                                  palette: [AppColors.blue],
                                                  annotations: <CircularChartAnnotation>[
                                                    CircularChartAnnotation(
                                                      widget: Center(
                                                        child: Center(
                                                          child: Container(
                                                            child: Center(
                                                              child: Text(
                                                                (double.parse(examinstructions.data!.user!.per.toString())
                                                                            .round())
                                                                        .toString() +
                                                                    "%",
                                                                style:
                                                                    TextStyle(
                                                                  color:
                                                                      AppColors
                                                                          .blue,
                                                                  fontSize: 11,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                              ),
                                                            ),
                                                            height: 40,
                                                            decoration: BoxDecoration(
                                                                shape: BoxShape
                                                                    .circle,
                                                                color: AppColors
                                                                    .white),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                  series: <CircularSeries>[
                                                    RadialBarSeries<int,
                                                        String>(
                                                      maximumValue: 100,
                                                      innerRadius: '20',
                                                      dataSource: [
                                                        examinstructions
                                                            .data!.user!.per!
                                                            .toInt()
                                                      ],
                                                      strokeWidth: 8,
                                                      cornerStyle:
                                                          examinstructions
                                                                      .data!
                                                                      .user!
                                                                      .per ==
                                                                  100
                                                              ? CornerStyle
                                                                  .bothFlat
                                                              : CornerStyle
                                                                  .endCurve,
                                                      xValueMapper:
                                                          (int data, _) =>
                                                              data.toString(),
                                                      yValueMapper: (int data,
                                                              _) =>
                                                          double.parse(
                                                              data.toString()),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                margin:
                                                    EdgeInsets.only(top: 45),
                                                child: Align(
                                                  alignment:
                                                      Alignment.bottomCenter,
                                                  child: Row(
                                                    children: [
                                                      MySvgWidget(
                                                          path: ImageAssets
                                                              .timeIcon,
                                                          imageColor:
                                                              AppColors.blue,
                                                          size:
                                                              getSize(context) /
                                                                  22),
                                                      SizedBox(
                                                        width: 3,
                                                      ),
                                                      Text(
                                                        examinstructions.data!
                                                            .user!.timeExam!,
                                                        style: TextStyle(
                                                            color:
                                                                AppColors.blue,
                                                            fontSize: getSize(
                                                                    context) /
                                                                32,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                              SizedBox(height: getSize(context) / 22),
                              ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: examinstructions
                                    .data!.details!.instruction!.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 0,
                                        vertical: getSize(context) / 44),
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal:
                                                  getSize(context) / 44),
                                          child: Container(
                                            alignment: Alignment.center,
                                            child: Center(
                                                child: Text(
                                              (index + 1).toString(),
                                              style: TextStyle(
                                                  fontSize:
                                                      getSize(context) / 22,
                                                  fontWeight: FontWeight.w600,
                                                  color: AppColors.blue),
                                            )),
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: AppColors.bluelight),
                                            width: getSize(context) / 14,
                                            height: getSize(context) / 14,
                                          ),
                                        ),
                                        Flexible(
                                          child: Text(
                                            examinstructions.data!.details!
                                                .instruction![index],
                                            style: TextStyle(
                                                fontSize: getSize(context) / 24,
                                                color: AppColors.black),
                                          ),
                                        )
                                      ],
                                    ),
                                  );
                                },
                              ),
                              // SizedBox(
                              //   height: getSize(context) / 32,
                              // ),
                              InkWell(
                                onTap: () {
                                  context
                                      .read<QuestionsLessonExamCubit>()
                                      .getQuestionsOfLessonExam(
                                          context: context,
                                          lessonId: widget.exam_id,
                                          exam_type: widget.type ==
                                                  'online_exam'
                                              ? "subject_class"
                                              : widget.type == 'video'
                                                  ? 'video'
                                                  : widget.type == 'all_exam'
                                                      ? 'full_exam'
                                                      : "lesson");
                                },
                                child: Container(
                                    width: getSize(context) / 1.1,
                                    height: getSize(context) / 7,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        color: AppColors.orange,
                                        borderRadius: BorderRadius.circular(
                                            getSize(context) / 22)),
                                    child: Text(
                                      'ready_exam'.tr(),
                                      style: TextStyle(color: AppColors.white),
                                    )),
                              )
                            ],
                          ),
                        ),
                      );
                    } else {
                      return NoDataWidget(
                        onclick: () =>
                            cubit.examInstructions(widget.exam_id, widget.type),
                        title: 'no_date',
                      );
                    }
                  },
                ),
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
