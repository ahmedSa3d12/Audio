import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/utils/assets_manager.dart';
import '../../../core/utils/getsize.dart';
import '../../../core/widgets/my_svg_widget.dart';
import '../cubit/cubit.dart';
import '../cubit/state.dart';

void showDilogofmakeexam(BuildContext context, MakeYourExamCubit cubit) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) {
      return BlocBuilder<MakeYourExamCubit, MakeYourExamState>(
        builder: (context, state) {
          return AlertDialog(
            insetPadding: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.all(Radius.circular(getSize(context) / 44))),
            actionsAlignment: MainAxisAlignment.center,
            titlePadding: EdgeInsets.all(0),
            title: Container(
              alignment: Alignment.topLeft,
              child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                    cubit.currentHour = 0;
                    cubit.currentMinutes = 0;
                  },
                  icon: MySvgWidget(
                      path: ImageAssets.close2,
                      imageColor: AppColors.red,
                      size: getSize(context) / 24)),
            ),
            content: Container(
              width: MediaQuery.of(context).size.width / 1.25,
              child: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            'min'.tr(),
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              color: AppColors.black,
                              fontSize: getSize(context) / 24,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            'hours'.tr(),
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              color: AppColors.black,
                              fontSize: getSize(context) / 24,
                              fontWeight: FontWeight.w700,
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: getSize(context) / 22,
                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          cubit.selectMinutes(),
                          cubit.selectHour(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            actions: <Widget>[
              InkWell(
                onTap: () {
                  print(cubit.totalMinutes());
                  Navigator.pop(context);
                },
                child: Container(
                  width: getSize(context) / 3,
                  height: getSize(context) / 8,
                  alignment: Alignment.center,
                  decoration: ShapeDecoration(
                    color: AppColors.green11,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 0.50,
                        strokeAlign: BorderSide.strokeAlignOutside,
                        color: AppColors.green12,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    'ok'.tr(),
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      color: AppColors.green12,
                      fontSize: getSize(context) / 24,
                      fontFamily: 'Cairo',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              )
            ],
          );
        },
      );
    },
  );
}
