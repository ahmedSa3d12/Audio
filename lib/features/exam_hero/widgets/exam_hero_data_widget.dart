import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_mazoon/core/utils/getsize.dart';
import 'package:new_mazoon/features/exam_hero/cubit/exam_hero_cubit.dart';
import 'package:new_mazoon/features/exam_hero/widgets/select_moth_widget.dart';
import 'package:new_mazoon/features/exam_hero/widgets/three_top_exam_hero_widget.dart';
import '../../../core/models/exam_hero.dart';
import '../../../core/utils/app_colors.dart';
import '../cubit/exam_hero_state.dart';
import 'order_item_widget.dart';

class ExamHeroDataWidget extends StatelessWidget {
  ExamHeroDataWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExamHeroCubit, ExamHeroState>(
      builder: (context, state) {
        ExamHeroCubit cubit = context.read<ExamHeroCubit>();
        List<CurrentMonthModel> data = cubit.num == 0
            ? cubit.dayHeroes
            : cubit.num == 1
                ? cubit.weekHeroes
                : cubit.num == 2
                    ? cubit.currentMonthHeroes
                    : cubit.lastMonthHeroes;
        List<CurrentMonthModel> newList =
            data.length > 3 ? data.sublist(3) : data;
        CurrentMonthModel? currentHeroOrder = cubit.num == 0
            ? cubit.heroDay
            : cubit.num == 1
                ? cubit.heroWeek
                : cubit.num == 2
                    ? cubit.heroMonth
                    : cubit.heroLastMonth;
        return RefreshIndicator(
          onRefresh: () async {
            cubit.getExamHero(context);
          },
          child: ListView(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            children: [
              SelectMonthWidget(),
              data.isEmpty
                  ? Container()
                  : ThreeTopExamHeroWidget(
                      threeHeros: cubit.num == 0
                          ? cubit.dayHeroes
                          : cubit.num == 1
                              ? cubit.weekHeroes
                              : cubit.currentMonthHeroes),
              data.isEmpty
                  ? Container(
                      height: getSize(context) / 2,
                      alignment: Alignment.center,
                      child: Text(
                        'no_data'.tr(),
                        style: TextStyle(
                          fontSize: getSize(context) / 24,
                          fontFamily: 'Cairo',
                          fontWeight: FontWeight.w500,
                          color: AppColors.gray7,
                        ),
                      ),
                    )
                  : data.length < 3
                      ? Container()
                      : Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Card(
                            elevation: 5,
                            shape: BeveledRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                            child: Column(
                              children: [
                                currentHeroOrder!.ordered >= 11
                                    ? Column(
                                        children: [
                                          OrderItemWidget(
                                              model: CurrentMonthModel(
                                                  examsTotalDegree:
                                                      currentHeroOrder
                                                          .examsTotalDegree,
                                                  country:
                                                      currentHeroOrder.country,
                                                  id: currentHeroOrder.id,
                                                  image: currentHeroOrder.image,
                                                  name: currentHeroOrder.name,
                                                  ordered:
                                                      currentHeroOrder.ordered,
                                                  studentTotalDegrees:
                                                      currentHeroOrder
                                                          .studentTotalDegrees)),
                                          Container(
                                            width: getSize(context) / 1.2,
                                            decoration: ShapeDecoration(
                                              shape: RoundedRectangleBorder(
                                                side: BorderSide(
                                                  width: 1,
                                                  strokeAlign: BorderSide
                                                      .strokeAlignCenter,
                                                  color: Color(0xFFF5F5F5),
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      )
                                    : Container(),
                                ...List.generate(
                                  newList.length,
                                  (index) =>
                                      OrderItemWidget(model: newList[index]),
                                ),
                              ],
                            ),
                          ),
                        )
            ],
          ),
        );
      },
    );
  }
}
