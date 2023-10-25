import 'package:flutter/material.dart';
import 'package:new_mazoon/core/widgets/youtube_video_view.dart';
import '../../../core/utils/getsize.dart';
import '../../../core/widgets/video_widget.dart';

class AnswerVideoViewScreen extends StatefulWidget {
  AnswerVideoViewScreen({
    required this.videoLink,
    required this.isYoutube,
    super.key,
  });
  final String videoLink;
  int isYoutube;
  @override
  State<AnswerVideoViewScreen> createState() => _AnswerVideoViewScreenState();
}

class _AnswerVideoViewScreenState extends State<AnswerVideoViewScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: widget.isYoutube == 1
              ? YoutubeVideoPlayer(
                  videoLinkId: widget.videoLink,
                  isTablet: getSize(context) >= 700 ? true : false,
                )
              : VideoWidget(
                  videoLink: widget.videoLink,
                  isTablet: getSize(context) >= 700 ? true : false,
                ),
        ),
      ),
    );
  }
}
