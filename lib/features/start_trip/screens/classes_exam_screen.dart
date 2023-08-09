import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_mazoon/core/utils/app_colors.dart';
import 'package:new_mazoon/core/utils/getsize.dart';
import 'package:new_mazoon/features/start_trip/cubit/start_trip_cubit.dart';

import '../../../config/routes/app_routes.dart';
import '../../../core/utils/assets_manager.dart';
import '../../../core/widgets/pdf_screen.dart';
import '../../examinstructions/cubit/examinstructions_cubit.dart';
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
              cubit.examClassList = [];
              cubit.getExamClassesData();
            },
            child: ListView(
              children: [
                SizedBox(height: 20),
                ExpansionTileWidget(
                  title: 'choose_class'.tr(),
                  type: 'classes_exam',
                ),
                SizedBox(height: 20),
                state is StartTripExamsClassByIdLoading
                    ? SizedBox(
                        height: getSize(context) / 2,
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
                            return InkWell(
                              onTap: () {
                                if (cubit.examClassList[index].type ==
                                    'online') {
                                  context
                                      .read<ExaminstructionsCubit>()
                                      .examInstructions(
                                          cubit.examClassList[index].id!,
                                          "online_exam");
                                  Navigator.pushNamed(
                                      context, Routes.examInstructionsRoute,
                                      arguments: [
                                        cubit.examClassList[index].id,
                                        "online_exam"
                                      ]);
                                } else {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => PdfScreen(
                                        pdfTitle:
                                            cubit.examClassList[index].name!,
                                        pdfLink: cubit.examClassList[index]
                                            .pdfExamUpload!,
                                      ),
                                    ),
                                  );
                                }
                              },
                              child: ClassesExamItemWidget(
                                model: cubit.examClassList[index],
                              ),
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
