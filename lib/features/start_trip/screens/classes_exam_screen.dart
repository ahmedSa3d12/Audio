import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_mazoon/core/utils/app_colors.dart';
import 'package:new_mazoon/core/widgets/show_loading_indicator.dart';
import 'package:new_mazoon/features/start_trip/cubit/start_trip_cubit.dart';

import '../../../core/utils/assets_manager.dart';
import '../../../core/widgets/download_icon_widget.dart';
import '../../../core/widgets/my_svg_widget.dart';
import '../widgets/classes_exam_item_widget.dart';
import '../widgets/expansion_tile_widget.dart';

class ClassesExamsScreen extends StatelessWidget {
  const ClassesExamsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StartTripCubit, StartTripState>(
      builder: (context, state) {
        StartTripCubit cubit = context.read<StartTripCubit>();
        return Container(
          decoration: (state is StartTripExamsClassByIdLoading ||
                  cubit.examClassList.isNotEmpty)
              ? null
              : BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(ImageAssets.chooseClassMessageImage),
                    fit: BoxFit.contain,
                  ),
                ),
          child: RefreshIndicator(
            onRefresh: () async {
              cubit.getExamClassesData();
            },
            child: ListView(
              children: [
                SizedBox(height: 20),
                ExpansionTileWidget(
                  title: 'اختر الفصل',
                ),
                SizedBox(height: 20),
                state is StartTripExamsClassByIdLoading
                    ? SizedBox(
                        height: MediaQuery.of(context).size.height / 2,
                        child: Center(
                          child: CircularProgressIndicator(
                            color: AppColors.primary,
                          ),
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: GridView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio: 0.70,
                            mainAxisSpacing: 12,
                            crossAxisSpacing: 20,
                            crossAxisCount: 2,
                          ),
                          itemCount: cubit.examClassList.length,
                          itemBuilder: (BuildContext context, int index) {
                            return ClassesExamItemWidget(
                              model: cubit.examClassList[index],
                            );
                          },
                        ),
                      ),
              ],
            ),
          ),
        );
      },
    );
  }
}
