import 'package:easy_localization/easy_localization.dart' as easy;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_mazoon/core/utils/getsize.dart';

import '../../../../core/utils/app_colors.dart';

import '../../../core/models/paper_exam_data_model.dart';
import '../../homePage/widget/home_page_app_bar_widget.dart';
import '../cubit/paper_detials_cubit.dart';

class PaperDetailsExmRegisterPage extends StatefulWidget {
  final PaperExam paperExamModel;

  PaperDetailsExmRegisterPage({
    Key? key,
    required this.paperExamModel,
  }) : super(key: key);

  @override
  State<PaperDetailsExmRegisterPage> createState() =>
      _PaperDetailsExmRegisterPageState();
}

class _PaperDetailsExmRegisterPageState
    extends State<PaperDetailsExmRegisterPage> {
  @override
  void initState() {
    super.initState();
    setData(context);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context);

        return false;
      },
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: AppColors.secondPrimary,
            toolbarHeight: 0,
          ),
          body: SafeArea(
              top: false,
              maintainBottomViewPadding: true,
              child: Stack(children: [
                Positioned(
                  top: 0,
                  right: 0,
                  left: 0,
                  bottom: 0,
                  child: Container(
                    color: AppColors.white,
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            SizedBox(
                              height: getSize(context) / 3.5,
                            ),
                            TextFormField(
                              controller:
                                  context.read<PaperDetialsCubit>().name,
                              enabled: false,
                              style: TextStyle(
                                  color: AppColors.orangeThirdPrimary,
                                  fontSize: 18),
                              decoration: InputDecoration(
                                  fillColor: AppColors.white,
                                  labelText: easy.tr("target_parts"),
                                  labelStyle: TextStyle(
                                      color: AppColors.orangeThirdPrimary,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                  disabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 1,
                                          color: AppColors.orangeThirdPrimary),
                                      borderRadius: BorderRadius.circular(10))),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            TextFormField(
                              controller:
                                  context.read<PaperDetialsCubit>().examtime,
                              enabled: false,
                              style: TextStyle(
                                  color: AppColors.skyColor, fontSize: 18),
                              decoration: InputDecoration(
                                  filled: true,
                                  fillColor: AppColors.white,
                                  labelStyle: TextStyle(
                                      color: AppColors.skyColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                  labelText: easy.tr("exam_time"),
                                  disabledBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: AppColors.skyColor),
                                      borderRadius: BorderRadius.circular(10))),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            TextFormField(
                              controller:
                                  context.read<PaperDetialsCubit>().examPlace,
                              enabled: false,
                              style: TextStyle(
                                  color: AppColors.blue, fontSize: 18),
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: AppColors.white,
                                labelText: easy.tr("exam_place"),
                                labelStyle: TextStyle(
                                    color: AppColors.blue,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18),
                                disabledBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: AppColors.blue),
                                    borderRadius: BorderRadius.circular(10)),
                              ),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            TextFormField(
                              controller:
                                  context.read<PaperDetialsCubit>().examHall,
                              enabled: false,
                              textDirection: TextDirection.ltr,
                              textAlign: easy.EasyLocalization.of(context)!
                                          .currentLocale!
                                          .languageCode ==
                                      'ar'
                                  ? TextAlign.right
                                  : TextAlign.left,
                              style: TextStyle(
                                  color: AppColors.purple1, fontSize: 18),
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: AppColors.white,
                                labelText: easy.tr("exam_hall"),
                                labelStyle: TextStyle(
                                    color: AppColors.purple1,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18),
                                disabledBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: AppColors.purple1),
                                    borderRadius: BorderRadius.circular(10)),
                              ),
                            ),
                            SizedBox(
                              height: 70,
                            ),
                            InkWell(
                              onTap: () {
                                context
                                    .read<PaperDetialsCubit>()
                                    .deleteexam(context);
                              },
                              child: Container(
                                width: getSize(context) / 2,
                                height: getSize(context) / 8,
                                decoration: BoxDecoration(
                                    border: Border.all(color: AppColors.red),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    color: AppColors.bink),
                                child: Center(
                                    child: Text(
                                  'cancel'.tr(),
                                  style: TextStyle(
                                      color: AppColors.red,
                                      fontWeight: FontWeight.bold,
                                      fontSize: getSize(context) / 24),
                                )),
                              ),
                            )
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
              ]))),
    );
  }

  void setData(BuildContext context) {
    Future.delayed(Duration(seconds: 1), () {
      context.read<PaperDetialsCubit>().name.text =
          widget.paperExamModel.nameOfExam!;
      context.read<PaperDetialsCubit>().examtime.text = easy.tr('day') +
          " " +
          easy.DateFormat(
                  'EEEE yyyy/MM/dd',
                  easy.EasyLocalization.of(context)!
                      .currentLocale!
                      .languageCode)
              .format(widget.paperExamModel.dateExam!) +
          easy.tr("hour") +
          " " +
          widget.paperExamModel.time!.replaceRange(
              widget.paperExamModel.time!.length - 4,
              widget.paperExamModel.time!.length - 1,
              "");
      context.read<PaperDetialsCubit>().examPlace.text =
          widget.paperExamModel.address!;
      context.read<PaperDetialsCubit>().examHall.text =
          widget.paperExamModel.section!.trim();
    });
  }
}
