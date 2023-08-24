import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/toast_message_method.dart';
import '../../../../core/widgets/container_with_two_color_widget.dart';
import '../../../core/models/class_data.dart';

class MakeExamStartStudyWidget extends StatelessWidget {
  const MakeExamStartStudyWidget({Key? key, required this.classes})
      : super(key: key);
  final List<AllClasses> classes;

  @override
  Widget build(BuildContext context) {
    print('classes.length');
    print(classes.length);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: classes.length,
            itemBuilder: (BuildContext context, int index) {
              return InkWell(
                onTap: () {
                  if (classes[index].status == 'lock') {
                    toastMessage(
                      'open_class'.tr(),
                      context,
                      color: AppColors.error,
                    );
                  } else {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => LessonsClassScreen(
                    //       classId: classes[index].id!,
                    //     ),
                    //   ),
                    // );
                  }
                },
                child: ContainerWithTwoColorWidget(
                  title: classes[index].name!,
                  imagePath: classes[index].image!,
                  color1: AppColors.blueColor1,
                  color2: AppColors.blueColor2,
                  textColor: AppColors.secondPrimary,
                  isHome: true,
                ),
              );
            },
          ),
        )
      ],
    );
  }
}
