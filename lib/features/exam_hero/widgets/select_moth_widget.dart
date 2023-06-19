import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_mazoon/features/exam_hero/cubit/exam_hero_cubit.dart';

import '../../../core/utils/app_colors.dart';

class SelectMonthWidget extends StatelessWidget {
  const SelectMonthWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Visibility(
          visible: context.read<ExamHeroCubit>().currentIndex == 2,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: SizedBox(
              width: 180,
              height: 70,
              child: Card(
                elevation: 16,
                shape: BeveledRectangleBorder(
                    borderRadius: BorderRadius.circular(40)),
                child: DropdownSearch<String>(
                  popupProps: const PopupProps.menu(
                    showSelectedItems: true,
                    fit: FlexFit.loose,
                  ),
                  items: ["current_month".tr(), "previous_month".tr()],
                  dropdownDecoratorProps: DropDownDecoratorProps(
                    baseStyle: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: AppColors.gray7,
                    ),
                    dropdownSearchDecoration: InputDecoration(
                      filled: true,
                      // enabled: true,
                      // isCollapsed: false,
                      hintStyle: TextStyle(fontSize: 16),
                      fillColor: AppColors.white,
                      labelStyle: TextStyle(fontSize: 16),
                      hintText: 'اختر الشهر',
                      iconColor: AppColors.primary,
                      suffixIconColor: AppColors.primary,
                      suffixIcon: Icon(
                        Icons.arrow_drop_down_rounded,
                        color: AppColors.primary,
                      ),
                      focusColor: AppColors.primary,
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(40),
                      ),
                    ),
                  ),
                  onChanged: print,
                  selectedItem: "current_month".tr(),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
