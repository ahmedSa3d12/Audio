import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_mazoon/core/utils/app_colors.dart';
import 'package:new_mazoon/features/downloads/cubit/downloadsstate.dart';
import 'package:video_player/video_player.dart';

import '../cubit/downloadscubit.dart';
import '../widget/video_player.dart';

class VideoPlayerScreen extends StatefulWidget {
  final File videoPath;

  VideoPlayerScreen({required this.videoPath});

  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DownloadedFilesCubit, DownloadedFilesState>(
      builder: (context, state) {
        var cubit = context.read<DownloadedFilesCubit>();
        return Scaffold(
          backgroundColor: AppColors.black,
          body: Center(
              child: AspectRatio(
                  aspectRatio: cubit.controller!.value.aspectRatio,
                  child: VideoWidgetFile(
                      videoId: 0, videoLink: widget.videoPath))),
        );
      },
    );
  }
}
