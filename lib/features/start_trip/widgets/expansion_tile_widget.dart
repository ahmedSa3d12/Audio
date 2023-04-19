import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_mazoon/core/widgets/show_loading_indicator.dart';
import 'package:new_mazoon/features/start_trip/cubit/start_trip_cubit.dart';
import 'package:new_mazoon/features/start_trip/cubit/start_trip_cubit.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/utils/assets_manager.dart';
import '../../../core/utils/toast_message_method.dart';
import '../../../core/widgets/my_svg_widget.dart';

class ExpansionTileWidget extends StatefulWidget {
  final String title;

  const ExpansionTileWidget({super.key, required this.title});

  @override
  State<ExpansionTileWidget> createState() => _ExpansionTileWidgetState();
}

class _ExpansionTileWidgetState extends State<ExpansionTileWidget> {
  bool isTitle = false;
  bool isExpanded = false;

  List<String> classNumber = [
    'الفصل الاول',
    'الفصل الثانى',
    'الفصل الثالث',
    'الفصل الرابع',
    'الفصل الخامس',
    'الفصل السادس',
    'الفصل السابع',
    'الفصل الثامن'
  ];
  List<String> classPresents = ['50', '20', '30', '0', '0', '0', '0', '0'];
  List<String> examsNumbers = ['5', '2', '3', '1', '4', '7', '3', '5'];

  @override
  void initState() {
    super.initState();
    title = widget.title;
  }

  String title = '';
  UniqueKey keyTile = UniqueKey();

  void expandTile() {
    setState(() {
      isExpanded = true;
      keyTile = UniqueKey();
    });
  }

  void shrinkTile() {
    setState(() {
      isExpanded = true;
      keyTile = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StartTripCubit, StartTripState>(
      builder: (context, state) {
        StartTripCubit cubit = context.read<StartTripCubit>();
        return Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(25),
                  child: ExpansionTile(
                    iconColor: AppColors.white,
                    key: keyTile,
                    trailing: Icon(
                      Icons.arrow_drop_down_outlined,
                      size: 35,
                    ),
                    backgroundColor: AppColors.orangeThirdPrimary,
                    collapsedBackgroundColor:
                        darken(AppColors.orangeThirdPrimary, 0.05),
                    // textColor: AppColors.white,
                    title: Text(
                      title,
                      style: TextStyle(color: AppColors.white),
                    ),
                    children: [
                      ...List.generate(
                        classNumber.length,
                        (index) => ListTile(
                          title: Text(
                            classNumber[index],
                            style: TextStyle(
                              color: title == classNumber[index]
                                  ? AppColors.primary
                                  : AppColors.white,
                              fontSize: title == classNumber[index] ? 20 : 16,
                              fontWeight: title == classNumber[index]
                                  ? FontWeight.bold
                                  : null,
                            ),
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              classPresents[index] == '0'
                                  ? MySvgWidget(
                                      size: 16,
                                      imageColor: AppColors.white,
                                      path: ImageAssets.lockIcon,
                                    )
                                  : SizedBox(),
                              SizedBox(width: 8),
                              Container(
                                width: 25,
                                height: 25,
                                padding: EdgeInsets.all(2),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25),
                                  color: title == classNumber[index]
                                      ? AppColors.primary
                                      : AppColors.white,
                                ),
                                child: Center(
                                  child: Text(
                                    examsNumbers[index],
                                    style: TextStyle(
                                      color: title == classNumber[index]
                                          ? AppColors.white
                                          : AppColors.orangeThirdPrimary,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          onTap: () {
                            if (classPresents[index] != '0') {
                              isExpanded ? shrinkTile() : expandTile();
                              title = classNumber[index];
                              setState(() {
                                isTitle = !isTitle;
                                title = classNumber[index];
                              });
                            } else {
                              toastMessage(
                                'هذا الفصل لم يفتح بعد',
                                context,
                                color: AppColors.error,
                              );
                            }
                          },
                        ),
                      ),
                      ListTile(
                        title: Text(
                          'امتحانات شاملة على الفصول',
                          style: TextStyle(
                            color: title == 'امتحانات شاملة على الفصول'
                                ? AppColors.primary
                                : AppColors.liveExamGrayTextColor,
                            fontSize:
                                title == 'امتحانات شاملة على الفصول' ? 20 : 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onTap: () {
                          isExpanded ? shrinkTile() : expandTile();
                          title = 'امتحانات شاملة على الفصول';
                          setState(() {
                            isTitle = !isTitle;
                            title = 'امتحانات شاملة على الفصول';
                          });
                        },
                      )
                    ],
                    onExpansionChanged: (value) {
                      setState(() {});
                    },
                  ),
                ),
              ),
            ),
            Visibility(
              visible: state is StartTripFinalReviewLoading,
              child: ShowLoadingIndicator(),
            )
          ],
        );
      },
    );
  }
}
