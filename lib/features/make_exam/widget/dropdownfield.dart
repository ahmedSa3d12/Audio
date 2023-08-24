import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/utils/getsize.dart';

class CustomDropDown2 extends StatelessWidget {
  CustomDropDown2(
      {required this.items,
      required this.msg,
      required this.onChanged,
      required this.label,
      this.value,
      super.key});
  List items;
  String label;
  String? value;

  String msg;
  Function(String?)? onChanged;
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: getSize(context) / 22),
      child: DropdownButtonFormField2<String>(
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
            .map((item) => DropdownMenuItem<String>(
                  value: item,
                  child: Text(
                    item,
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
