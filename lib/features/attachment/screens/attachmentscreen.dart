import 'package:flutter/material.dart';
import 'package:new_mazoon/core/utils/assets_manager.dart';
import 'package:new_mazoon/core/utils/getsize.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:new_mazoon/core/widgets/my_svg_widget.dart';
import '../../../core/models/videoModel.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/widgets/title_with_circle_background_widget.dart';
import '../../homePage/widget/home_page_app_bar_widget.dart';

class AttachmentScreen extends StatefulWidget {
  AttachmentScreen({required this.model, super.key});
  VideoModel model;

  @override
  State<AttachmentScreen> createState() => _AttachmentScreenState();
}

class _AttachmentScreenState extends State<AttachmentScreen> {
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
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: getSize(context) / 4.2),
                Positioned(
                  top: 0,
                  right: 0,
                  left: 0,
                  bottom: 0,
                  child:
                      TitleWithCircleBackgroundWidget(title: widget.model.name),
                ),
                SizedBox(height: getSize(context) / 22),
                Flexible(
                    child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  ClipRRect(
                                      borderRadius: BorderRadius.circular(500),
                                      child: Container(
                                        padding: EdgeInsets.all(20),
                                        color: AppColors.unselectedTabColor,
                                        child: MySvgWidget(
                                            path: ImageAssets.rec,
                                            imageColor: AppColors.blue5,
                                            size: getSize(context) / 20),
                                      )),
                                  Text("records".tr())
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  ClipRRect(
                                      borderRadius: BorderRadius.circular(500),
                                      child: Container(
                                        padding: EdgeInsets.all(20),
                                        color: AppColors.unselectedTabColor,
                                        child: MySvgWidget(
                                            path: ImageAssets.pdf,
                                            imageColor: AppColors.blue5,
                                            size: getSize(context) / 20),
                                      )),
                                  Text("summary".tr())
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  ClipRRect(
                                      borderRadius: BorderRadius.circular(500),
                                      child: Container(
                                        padding: EdgeInsets.all(20),
                                        color: AppColors.unselectedTabColor,
                                        child: MySvgWidget(
                                            path: ImageAssets.homework,
                                            imageColor: AppColors.blue5,
                                            size: getSize(context) / 20),
                                      )),
                                  Text("homework".tr())
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  ClipRRect(
                                      borderRadius: BorderRadius.circular(500),
                                      child: Container(
                                          padding: EdgeInsets.all(20),
                                          color: AppColors.orange,
                                          child: MySvgWidget(
                                              path: ImageAssets.rate_us,
                                              imageColor: AppColors.white,
                                              size: 20))),
                                  Text("rate_us".tr())
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ))
              ],
            ),
            Positioned(
              top: 0,
              right: 0,
              left: 0,
              child: HomePageAppBarWidget(isHome: false),
            ),
          ],
        ),
      ),
    );
  }
}
