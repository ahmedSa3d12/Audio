import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

import '../../../core/models/make_exam_model.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/getsize.dart';

class CustomDropDown3 extends StatelessWidget {
  CustomDropDown3(
      {required this.items,
      required this.msg,
      required this.onChanged,
      required this.label,
      this.value,
      super.key});
  List<Lesson> items;
  String label;
  Lesson? value;

  String msg;
  Function(Lesson?)? onChanged;
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: getSize(context) / 22),
      child: DropdownButtonFormField2<Lesson>(
        isExpanded: true,
        decoration: InputDecoration(
          fillColor: AppColors.unselectedTabColor,
          filled: true,
          contentPadding: const EdgeInsets.symmetric(vertical: 16),
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        value: value,
        hint: Text(
          label,
          maxLines: 1,
          style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: getSize(context) / 24,
              color: AppColors.primary),
        ),
        items: items
            .map((item) => DropdownMenuItem<Lesson>(
                  value: item,
                  child: Text(
                    item.name,
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: getSize(context) / 24,
                        color: AppColors.primary),
                  ),
                ))
            .toList(),
        validator: (value) {
          if (value == null) {
            return msg;
          }
          return null;
        },
        onChanged: onChanged,
        buttonStyleData: const ButtonStyleData(
          padding: EdgeInsets.only(right: 8),
        ),
        iconStyleData: IconStyleData(
          icon: Icon(
            Icons.arrow_drop_down,
            color: AppColors.primary,
          ),
          iconSize: getSize(context) / 12,
        ),
        dropdownStyleData: DropdownStyleData(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        menuItemStyleData: const MenuItemStyleData(
          padding: EdgeInsets.symmetric(horizontal: 16),
        ),
      ),
    );
  }
}
