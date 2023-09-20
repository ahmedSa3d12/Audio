import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_mazoon/core/utils/getsize.dart';
import 'package:new_mazoon/features/exam_hero/cubit/exam_hero_cubit.dart';

import '../../../core/utils/app_colors.dart';
import '../cubit/exam_hero_state.dart';

class SelectMonthWidget extends StatelessWidget {
  const SelectMonthWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExamHeroCubit, ExamHeroState>(
      builder: (context, state) {
        var cubit = context.read<ExamHeroCubit>();
        return Row(
          children: [
            Visibility(
              visible: context.read<ExamHeroCubit>().currentIndex == 2,
              child: Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: getSize(context) / 22),
                child: SizedBox(
                  width: getSize(context) / 2,
                  height: getSize(context) / 5,
                  child: DropdownSearch<String>(
                    popupProps: const PopupProps.menu(
                      showSelectedItems: true,
                      fit: FlexFit.loose,
                    ),
                    items: ["current_month".tr(), "previous_month".tr()],
                    dropdownDecoratorProps: DropDownDecoratorProps(
                      baseStyle: TextStyle(
                        fontSize: getSize(context) / 24,
                        fontFamily: 'Cairo',
                        fontWeight: FontWeight.w500,
                        color: AppColors.gray7,
                      ),
                      dropdownSearchDecoration: InputDecoration(
                        filled: true,
                        hintStyle: TextStyle(
                          fontSize: getSize(context) / 24,
                          fontFamily: 'Cairo',
                          fontWeight: FontWeight.w500,
                          color: AppColors.gray7,
                        ),
                        fillColor: AppColors.white,
                        labelStyle: TextStyle(
                          fontSize: getSize(context) / 24,
                          fontFamily: 'Cairo',
                          fontWeight: FontWeight.w700,
                          color: AppColors.gray7,
                        ),
                        hintText: 'current_month'.tr(),
                        iconColor: AppColors.primary,
                        suffixIconColor: AppColors.primary,
                        suffixIcon: Icon(
                          Icons.arrow_drop_down_rounded,
                          color: AppColors.primary,
                        ),
                        focusColor: AppColors.primary,
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius:
                              BorderRadius.circular(getSize(context) / 22),
                        ),
                      ),
                    ),
                    onChanged: (value) {
                      cubit.switchCurrentAndLast(value ?? 'current_month'.tr());
                    },
                    selectedItem: 'current_month'.tr(),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
