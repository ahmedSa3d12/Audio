import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_mazoon/core/widgets/my_svg_widget.dart';

import '../../../../core/models/TimeModel.dart';
import '../../../../core/models/times_model.dart';
import '../../../../core/models/times_model.dart';
import '../../../../core/models/times_model.dart';
import '../../../../core/models/times_model.dart';
import '../../../../core/models/times_model.dart';
import '../../../../core/models/times_model.dart';
import '../../../../core/models/times_model.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/assets_manager.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../homePage/widget/home_page_app_bar_widget.dart';
import '../../cubit/exam_register_cubit.dart';

class ExmRegisterPage extends StatefulWidget {
 final TimeDataModel timeDataModel;


   ExmRegisterPage({Key? key, required this.timeDataModel, }) : super(key: key);

  @override
  State<ExmRegisterPage> createState() => _ExmRegisterPageState();
}

class _ExmRegisterPageState extends State<ExmRegisterPage> {
  Time? dropdownValue;

  @override
  void initState() {
    super.initState();
    dropdownValue=widget.timeDataModel.data.times.elementAt(0);

  }

  @override
  Widget build(BuildContext context) {
    print("dldkkdk");
    print(widget.timeDataModel.data.times.length);
    return Scaffold(
        appBar: AppBar(
        backgroundColor: AppColors.secondPrimary,
        toolbarHeight: 0,
    ),
    body:
    SafeArea(
    top: false,
    maintainBottomViewPadding: true,
    child: Stack(
    children: [
    Positioned(
    top: 0,
    right: 0,
    left: 0,
    bottom: 0,

    child: BlocBuilder<ExamRegisterCubit, ExamRegisterState>(
  builder: (context, state) {
    return SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            children: [
              Center(
                child: Image.asset(
                  ImageAssets.userExamImage,
                  fit: BoxFit.cover,
                  height: 300,
                ),
              ),
              const SizedBox(height: 25),
              Container(
                
                decoration: BoxDecoration(
                    
                    border: Border.all(color: AppColors.black,width: 1),borderRadius: BorderRadius.all(Radius.circular(15))),
                child: Row(
                  children: [
                    MySvgWidget(path: ImageAssets.callImage, imageColor: AppColors.black, size: 20),
                    const SizedBox(width: 25),
                    Expanded(
                      child: TextFormField(
                        decoration: InputDecoration(
                          border: InputBorder.none,

                        ),
                        controller: context.read<ExamRegisterCubit>().studentName,
                        enabled: false,
                        style: TextStyle(
                            backgroundColor: AppColors.transparent,

                            color: AppColors.secondPrimary,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(

                    border: Border.all(color: AppColors.black,width: 1),borderRadius: BorderRadius.all(Radius.circular(15))),
                child: Row(
                  children: [
                    MySvgWidget(path: ImageAssets.callImage, imageColor: AppColors.black, size: 20),
                    const SizedBox(width: 25),
                    Expanded(
                      child:  TextFormField(
                        controller: context.read<ExamRegisterCubit>().phoneName,
                        enabled: false,
                        decoration: InputDecoration(
                          border: InputBorder.none,

                        ),
                        style: TextStyle(
                            backgroundColor: AppColors.transparent,

                            color: AppColors.secondPrimary,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(

                    border: Border.all(color: AppColors.black,width: 1),borderRadius: BorderRadius.all(Radius.circular(15))),
                child: Row(
                  children: [
                    MySvgWidget(path: ImageAssets.callImage, imageColor: AppColors.black, size: 20),
                    const SizedBox(width: 25),
                    Expanded(
                      child:  TextFormField(

                        decoration: InputDecoration(
                          border: InputBorder.none,

                        ),
                        controller: context.read<ExamRegisterCubit>().studentCode,
                        enabled: false,
                        style: TextStyle(
                          backgroundColor: AppColors.transparent,
                            color: AppColors.secondPrimary,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 10),

              Container(
                decoration: BoxDecoration(

                    border: Border.all(color: AppColors.black,width: 1),borderRadius: BorderRadius.all(Radius.circular(15))),
                child: Row(
                  children: [
                    MySvgWidget(path: ImageAssets.callImage, imageColor: AppColors.black, size: 20),
                    const SizedBox(width: 25),
                    Expanded(
                      child: DropdownButton(
                        isExpanded: true,
                        icon: Icon(
                          Icons.expand_circle_down,
                          size: 30,

                          color: AppColors.secondPrimary,
                        ),
                        value:dropdownValue,
                        iconSize: 15,
                        elevation: 16,
                        style: TextStyle(color: AppColors.secondPrimary),
                        underline: Container(
                          height: 2,
                          color: AppColors.transparent,
                        ),
                        onChanged: (newValue) {
                          setState(() {
                            dropdownValue = newValue;
                          });
                        },
                        items:widget.timeDataModel.data.times
                            .map<DropdownMenuItem<Time>>((Time value) {
                          return DropdownMenuItem<Time>(
                              value: value,
                              child: Container(

                                  width: 200,

                                  child: Text(
                                   "group_time".tr()+":"+ value.from.replaceRange(value.from.length-3, value.from.length, '')+" - "+value.to.replaceRange(value.to.length-3, value.to.length, ''),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                  )));
                        }).toList(),
                      ),
                    )
                  ],
                ),
              ),



              const SizedBox(height: 25),
              CustomButton(
                text: 'record_data'.tr(),
                color: AppColors.primary,
                onClick: () {
                  context.read<ExamRegisterCubit>().openexam(widget.timeDataModel, dropdownValue!, context);
                },
              ),
            ],
          ),
        ),
      );
  },
)
    ),
      Positioned(
        top: 0,
        right: 0,
        left: 0,
        child: HomePageAppBarWidget(),
      ),]
    )));
  }
}
