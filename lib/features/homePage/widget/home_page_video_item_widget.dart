import 'package:flutter/material.dart';
import 'package:new_mazoon/config/routes/app_routes.dart';
import 'package:new_mazoon/core/utils/hex_color.dart';

import '../../../../core/models/home_page_model.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/assets_manager.dart';
import '../../../../core/widgets/my_svg_widget.dart';
import '../../../core/widgets/title_with_circle_background_widget.dart';

class HomePageVideoWidget extends StatelessWidget {
  const HomePageVideoWidget(
      {Key? key, required this.videosBasics, required this.title})
      : super(key: key);
  final List<HomePageVideosModel> videosBasics;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 10),
        TitleWithCircleBackgroundWidget(title: title),
        SizedBox(height: 20),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              ...List.generate(
                videosBasics.length,
                (index) => InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, Routes.videoDetailsScreenRoute,
                        arguments: {
                          'type': 'video_basic',
                          'videoId': videosBasics[index].id!,
                        });
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Container(
                      height: 120,
                      width: MediaQuery.of(context).size.width * 0.45,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: HexColor(
                            videosBasics[index].backgroundColor ?? '#E4312A'),
                      ),
                      child: Column(
                        children: [
                          Spacer(),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(
                              videosBasics[index].name!,
                              style: TextStyle(
                                fontSize: 16,
                                color: AppColors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Spacer(),
                          Row(
                            children: [
                              // Spacer(),
                              SizedBox(width: 16),
                              MySvgWidget(
                                path: ImageAssets.clockIcon,
                                imageColor: AppColors.white,
                                size: 16,
                              ),
                              SizedBox(width: 10),
                              // Spacer(),
                              Text(
                                '${videosBasics[index].time!} ساعه ',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: AppColors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Spacer(),
                            ],
                          ),
                          Spacer(),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 40),
      ],
    );
  }
}
