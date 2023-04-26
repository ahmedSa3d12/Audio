import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:stroke_text/stroke_text.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/widgets/download_icon_widget.dart';
import '../../homePage/widget/home_page_app_bar_widget.dart';
import '../../start_trip/widgets/expansion_tile_widget.dart';

class SourceReferencesDetails extends StatelessWidget {
  const SourceReferencesDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.secondPrimary,
        toolbarHeight: 0,
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                SizedBox(height: 120),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Container(
                    // padding: EdgeInsets.all(12),
                    height: 110,
                    width: MediaQuery.of(context).size.width ,
                    decoration: BoxDecoration(
                      color: AppColors.greenDownloadColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: DownloadIconWidget(
                            color: AppColors.white,
                            iconColor: AppColors.greenDownloadColor,
                          ),
                        ),
                        // SizedBox(width: 12),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('click_to_download'.tr(),style: TextStyle(color: AppColors.white,),),
                                Text('2 MB'.tr(),style: TextStyle(color: AppColors.white,),),
                              ],
                            ),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: StrokeText(
                                text: "",
                                textStyle: TextStyle(
                                    fontSize: 45,
                                    fontFamily: 'Mada',
                                    color: AppColors.error
                                ),
                                strokeColor: AppColors.white,
                                strokeWidth: 4,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),
                ExpansionTileWidget(
                  title: 'اختر الفصل',
                ),
                SizedBox(height: 20),

              ],
            ),
            Positioned(
              top: 0,
              right: 0,
              left: 0,
              child: HomePageAppBarWidget(),
            ),
          ],
        ),
      ),
    );
  }
}
