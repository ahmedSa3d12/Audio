import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_mazoon/core/utils/app_colors.dart';
import 'package:new_mazoon/features/downloads/cubit/downloadsstate.dart';

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
    return Scaffold(
      backgroundColor: AppColors.black,
      body: Center(
          child: AspectRatio(
              aspectRatio: 16 / 9,
              child: VideoWidgetFile(videoLink: widget.videoPath))),
    );
  }
}
