import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_mazoon/core/utils/app_colors.dart';
import 'package:new_mazoon/core/utils/getsize.dart';
import 'package:new_mazoon/features/exam_hero/cubit/exam_hero_cubit.dart';
import 'package:new_mazoon/features/exam_hero/widgets/select_moth_widget.dart';
import 'package:new_mazoon/features/exam_hero/widgets/three_top_exam_hero_widget.dart';
import '../../../core/models/exam_hero.dart';
import '../cubit/exam_hero_state.dart';
import 'order_item_widget.dart';

class ExamHeroDataWidget extends StatelessWidget {
  ExamHeroDataWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExamHeroCubit, ExamHeroState>(
      builder: (context, state) {
        ExamHeroCubit cubit = context.read<ExamHeroCubit>();
        List<ExamHerosModelAuth> data = cubit.num == 0
            ? cubit.dayHeroes
            : cubit.num == 1
                ? cubit.weekHeroes
                : cubit.currentMonthHeroes;
        List<ExamHerosModelAuth> newList =
            data.length > 3 ? data.sublist(3) : data;
        return data.length == 0
            ? Center(child: CircularProgressIndicator())
            : ListView(
                children: [
                  SelectMonthWidget(),
                  ThreeTopExamHeroWidget(
                      threeHeros: cubit.num == 0
                          ? cubit.dayHeroes
                          : cubit.num == 1
                              ? cubit.weekHeroes
                              : cubit.currentMonthHeroes),
                  data.length < 3
                      ? Container()
                      : Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Card(
                            elevation: 5,
                            shape: BeveledRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                            child: Column(
                              children: [
                                cubit.allData!.auth.ordered >= 11
                                    ? Column(
                                        children: [
                                          OrderItemWidget(
                                              model: ExamHerosModelAuth(
                                                  examsTotalDegree: cubit
                                                      .allData!
                                                      .auth
                                                      .examsTotalDegree,
                                                  country: cubit
                                                      .allData!.auth.country,
                                                  id: cubit.allData!.auth.id,
                                                  image:
                                                      cubit.allData!.auth.image,
                                                  name:
                                                      cubit.allData!.auth.name,
                                                  ordered: cubit
                                                      .allData!.auth.ordered,
                                                  studentTotalDegrees: cubit
                                                      .allData!
                                                      .auth
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
              );
      },
    );
  }
}
