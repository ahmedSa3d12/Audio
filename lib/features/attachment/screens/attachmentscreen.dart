import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_mazoon/core/utils/assets_manager.dart';
import 'package:new_mazoon/core/utils/getsize.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:new_mazoon/core/widgets/my_svg_widget.dart';
import 'package:new_mazoon/features/attachment/screens/recordscreen.dart';
import 'package:new_mazoon/features/attachment/screens/summaryscreen.dart';
import '../../../core/models/videoModel.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/widgets/title_with_circle_background_widget.dart';
import '../../homePage/widget/home_page_app_bar_widget.dart';
import '../cubit/attachmentcubit.dart';
import '../cubit/attachmentstate.dart';
import 'homeworkscreen.dart';
import 'rate_yourself.dart';

class AttachmentScreen extends StatefulWidget {
  AttachmentScreen({required this.model, super.key});
  VideoModel model;

  @override
  State<AttachmentScreen> createState() => _AttachmentScreenState();
}

class _AttachmentScreenState extends State<AttachmentScreen> {
  @override
  void initState() {
    BlocProvider.of<AttachmentCubit>(context)
        .audioOfLessonData(widget.model.id);
    super.initState();
  }

  int myBodyIs = 0;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AttachmentCubit, AttachmentState>(
      builder: (context, state) {
        var cubit = context.read<AttachmentCubit>();
        print(cubit.audioLessonData);
        return Scaffold(
          appBar: AppBar(
            backgroundColor: AppColors.secondPrimary,
            toolbarHeight: 0,
          ),
          body: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: getSize(context) / 3),
                  TitleWithCircleBackgroundWidget(
                    title: widget.model.name,
                    width: double.infinity,
                  ),
                  SizedBox(height: getSize(context) / 22),
                  Flexible(
                      child: SingleChildScrollView(
                    child: Column(children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            InkWell(
                              onTap: () {
                                setState(() {
                                  myBodyIs = 0;
                                  cubit.audioOfLessonData(widget.model.id);
                                });
                              },
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(500),
                                        child: Container(
                                          padding: EdgeInsets.all(20),
                                          color: myBodyIs == 0
                                              ? AppColors.orange
                                              : AppColors.unselectedTabColor,
                                          child: MySvgWidget(
                                              path: ImageAssets.rec,
                                              imageColor: myBodyIs == 0
                                                  ? AppColors.white
                                                  : AppColors.blue5,
                                              size: getSize(context) / 20),
                                        )),
                                    Text("records".tr())
                                  ],
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  myBodyIs = 1;
                                  cubit.pdfOfLessonData(widget.model.id);
                                });
                              },
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(500),
                                        child: Container(
                                          padding: EdgeInsets.all(20),
                                          color: myBodyIs == 1
                                              ? AppColors.orange
                                              : AppColors.unselectedTabColor,
                                          child: MySvgWidget(
                                              path: ImageAssets.pdf,
                                              imageColor: myBodyIs == 1
                                                  ? AppColors.white
                                                  : AppColors.blue5,
                                              size: getSize(context) / 20),
                                        )),
                                    Text("summary".tr())
                                  ],
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  myBodyIs = 2;
                                  cubit.homeworkOfLessonData(widget.model.id);
                                });
                              },
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(500),
                                        child: Container(
                                          padding: EdgeInsets.all(20),
                                          color: myBodyIs == 2
                                              ? AppColors.orange
                                              : AppColors.unselectedTabColor,
                                          child: MySvgWidget(
                                              path: ImageAssets.homework,
                                              imageColor: myBodyIs == 2
                                                  ? AppColors.white
                                                  : AppColors.blue5,
                                              size: getSize(context) / 20),
                                        )),
                                    Text("homework".tr())
                                  ],
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  myBodyIs = 3;
                                  cubit.rateYourselfLessonExam(widget.model.id);
                                });
                              },
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(500),
                                        child: Container(
                                            padding: EdgeInsets.all(20),
                                            color: myBodyIs == 3
                                                ? AppColors.orange
                                                : AppColors.unselectedTabColor,
                                            child: MySvgWidget(
                                                path: ImageAssets.rate_us,
                                                imageColor: myBodyIs == 3
                                                    ? AppColors.white
                                                    : AppColors.blue5,
                                                size: 20))),
                                    Text("rate_us".tr())
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      myBodyIs == 0
                          ? RecordScreenScreen()
                          : myBodyIs == 1
                              ? SummaryScreen()
                              : myBodyIs == 2
                                  ? HomeWorkScreen(lessonId: widget.model.id)
                                  : RateYourSelfScreen()
                    ]),
                  ))
                ],
              ),
              Positioned(
                top: 0,
                right: 0,
                left: 0,
                child: HomePageAppBarWidget(isHome: false),
              ),
            ],
          ),
        );
      },
    );
  }
}
