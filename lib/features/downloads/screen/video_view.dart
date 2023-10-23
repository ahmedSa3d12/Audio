import 'dart:io';
import 'package:flutter/material.dart';
import 'package:new_mazoon/core/utils/app_colors.dart';

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
      body: Center(child: VideoWidgetFile(videoLink: widget.videoPath)),
    );
  }
}
