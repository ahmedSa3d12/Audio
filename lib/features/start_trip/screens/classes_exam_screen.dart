import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_mazoon/core/utils/app_colors.dart';
import 'package:new_mazoon/features/start_trip/cubit/start_trip_cubit.dart';

import '../../../core/utils/assets_manager.dart';
import '../../../core/widgets/download_icon_widget.dart';
import '../../../core/widgets/my_svg_widget.dart';
import '../widgets/expansion_tile_widget.dart';

class ClassesExamsScreen extends StatelessWidget {
  const ClassesExamsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // decoration: BoxDecoration(
      //   image: DecorationImage(
      //     image: AssetImage(ImageAssets.chooseClassMessageImage),
      //     fit: BoxFit.contain,
      //   ),
      // ),
      child: RefreshIndicator(
        onRefresh: () async {
          context.read<StartTripCubit>().getExamClassesData();
        },
        child: ListView(
          children: [
            SizedBox(height: 20),
            ExpansionTileWidget(
              title: 'اختر الفصل',
            ),
            SizedBox(height: 20),
            GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 0.85,
                mainAxisSpacing: 15,
                crossAxisSpacing: 20,
                crossAxisCount: 2,
              ),
              itemCount: 5,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Stack(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: double.infinity,
                            height: 110,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: lighten(AppColors.error),
                            ),
                            child: SizedBox(
                              height: 65,
                              width: 55,
                              child: Center(
                                child: Image.asset(
                                  ImageAssets.examPdfImage,
                                  height: 65,
                                  width: 55,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 8),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'اسم الامتحان',
                                  style: TextStyle(
                                    color: AppColors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  '2 MB',
                                  style: TextStyle(
                                    color: AppColors.black,
                                    fontSize: 16,
                                  ),
                                ),
                                SizedBox(height: 10),
                                SizedBox(
                                  width: 210,
                                  child: Row(
                                    // mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        padding: EdgeInsets.all(2),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(18),
                                          color: AppColors.blueColor1,
                                        ),
                                        child: Center(
                                          child: Directionality(
                                            textDirection: TextDirection.ltr,
                                            child: Text(
                                              ' 30 Q',
                                              style: TextStyle(
                                                  color: AppColors.white,
                                                  fontSize: 12),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.all(2),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(18),
                                          color: AppColors.blueColor1,
                                        ),
                                        child: Center(
                                          child: Directionality(
                                            textDirection: TextDirection.ltr,
                                            child: Text(
                                              ' 120 min',
                                              style: TextStyle(
                                                  color: AppColors.white,
                                                  fontSize: 12),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.all(4),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(18),
                                          color: AppColors.error,
                                        ),
                                        child: Center(
                                          child: Directionality(
                                            textDirection: TextDirection.ltr,
                                            child: Icon(Icons.favorite_border,color: AppColors.white,size: 18,),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.all(4),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(18),
                                          color: AppColors.goldColor,
                                        ),
                                        child: Center(
                                          child: Directionality(
                                            textDirection: TextDirection.ltr,
                                            child: MySvgWidget(
                                              path: ImageAssets.answerPdfIcon,
                                              imageColor: AppColors.white,
                                              size: 16,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.all(4),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                          BorderRadius.circular(18),
                                          color: AppColors.skyColor,
                                        ),
                                        child: Center(
                                          child: Directionality(
                                            textDirection: TextDirection.ltr,
                                            child: MySvgWidget(
                                              path: ImageAssets.videoIcon,
                                              imageColor: AppColors.white,
                                              size: 16,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                      Positioned(
                        top: 95,
                        right: 10,
                        child: SizedBox(
                          width: 25,
                          height: 25,
                          child: DownloadIconWidget(
                            color: AppColors.error,
                          ),
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
