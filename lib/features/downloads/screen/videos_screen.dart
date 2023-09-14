import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_mazoon/core/utils/app_colors.dart';
import 'package:new_mazoon/core/utils/assets_manager.dart';
import 'package:new_mazoon/core/utils/getsize.dart';
import 'package:new_mazoon/core/widgets/my_svg_widget.dart';
import 'package:new_mazoon/features/downloads/screen/video_view.dart';

import '../cubit/downloadscubit.dart';
import '../cubit/downloadsstate.dart';

class VideosDownloadedScreen extends StatefulWidget {
  const VideosDownloadedScreen({super.key});

  @override
  State<VideosDownloadedScreen> createState() => _VideosDownloadedScreenState();
}

class _VideosDownloadedScreenState extends State<VideosDownloadedScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DownloadedFilesCubit, DownloadedFilesState>(
      builder: (context, state) {
        var cubit = context.read<DownloadedFilesCubit>();
        return Scaffold(
          body: cubit.savedList.isEmpty
              ? Center(
                  child: Text('no_data'.tr()),
                )
              : ListView.builder(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemCount: cubit.savedList.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => VideoPlayerScreen(
                                    videoPath:
                                        File(cubit.savedList[index].path))));
                      },
                      child: Container(
                        margin: EdgeInsets.all(getSize(context) / 88),
                        height: getSize(context) / 4,
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(getSize(context) / 88)),
                        child: Row(
                          children: [
                            Container(
                              width: getSize(context) / 3,
                              height: getSize(context) / 4.5,
                              decoration: BoxDecoration(
                                  color: AppColors.bink,
                                  borderRadius: BorderRadius.circular(
                                      getSize(context) / 44)),
                              child: Image.asset(
                                'assets/images/register.png',
                                width: getSize(context) / 4.5,
                              ),
                            ),
                            Flexible(
                              fit: FlexFit.tight,
                              child: Container(
                                padding: EdgeInsets.all(getSize(context) / 44),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      cubit.savedList[index].path
                                          .split('/')
                                          .last
                                          .split('.')
                                          .first,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                        color: AppColors.black,
                                        fontSize: getSize(context) / 28,
                                        fontFamily: 'Cairo',
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    // Row(
                                    //   children: [
                                    //     Text(
                                    //       '2',
                                    //       textAlign: TextAlign.right,
                                    //       style: TextStyle(
                                    //         color: AppColors.gray1,
                                    //         fontSize: getSize(context) / 32,
                                    //         fontFamily: 'Cairo',
                                    //         fontWeight: FontWeight.w400,
                                    //         height: 0,
                                    //       ),
                                    //     ),
                                    //     SizedBox(width: getSize(context) / 88),
                                    //     MySvgWidget(
                                    //         path: ImageAssets.eyeIcon,
                                    //         imageColor: AppColors.gray,
                                    //         size: getSize(context) / 22),
                                    //     SizedBox(width: getSize(context) / 88),
                                    //     Text(
                                    //       '205',
                                    //       textAlign: TextAlign.right,
                                    //       style: TextStyle(
                                    //         color: AppColors.gray1,
                                    //         fontSize: getSize(context) / 32,
                                    //         fontFamily: 'Cairo',
                                    //         fontWeight: FontWeight.w400,
                                    //         height: 0,
                                    //       ),
                                    //     ),
                                    //     SizedBox(width: getSize(context) / 88),
                                    //     MySvgWidget(
                                    //         path: ImageAssets.likeIcon,
                                    //         imageColor:
                                    //             AppColors.greenDownloadColor,
                                    //         size: getSize(context) / 22),
                                    //     Flexible(child: SizedBox()),
                                    //   ],
                                    // )
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              alignment: Alignment.topCenter,
                              child: IconButton(
                                  onPressed: () {
                                    cubit.deleteDownloadedFile(cubit
                                        .savedList[index].path
                                        .split('/')
                                        .last);
                                  },
                                  icon: Icon(CupertinoIcons.delete,
                                      color: AppColors.red)),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
        );
      },
      listener: (context, state) {},
    );
  }
}
