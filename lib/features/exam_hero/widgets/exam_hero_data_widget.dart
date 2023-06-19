import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_mazoon/core/utils/assets_manager.dart';
import 'package:new_mazoon/core/widgets/network_image.dart';
import 'package:new_mazoon/features/exam_hero/cubit/exam_hero_cubit.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:new_mazoon/features/exam_hero/widgets/select_moth_widget.dart';
import 'package:new_mazoon/features/exam_hero/widgets/three_top_exam_hero_widget.dart';

import '../../../core/utils/app_colors.dart';
import 'order_item_widget.dart';

class ExamHeroDataWidget extends StatelessWidget {
  const ExamHeroDataWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExamHeroCubit, ExamHeroState>(
      builder: (context, state) {
        ExamHeroCubit cubit = context.read<ExamHeroCubit>();
        return ListView(
          children: [
            SelectMonthWidget(),
            ThreeTopExamHeroWidget(),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Card(
                elevation: 5,
                shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(8)),
                child: Column(
                  children: [
                    ...List.generate(
                      8,
                      (index) => OrderItemWidget(),
                    ),
                  ],
                ),
              ),
            )
          ],
        );
      },
    );
  }
}
