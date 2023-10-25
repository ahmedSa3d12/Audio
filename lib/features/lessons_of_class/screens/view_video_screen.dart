import 'package:flutter/material.dart';
import '../../../core/utils/getsize.dart';
import '../../../core/widgets/video_widget.dart';

class AnswerVideoViewScreen extends StatefulWidget {
  const AnswerVideoViewScreen({
    required this.videoLink,
    super.key,
  });
  final String videoLink;
  @override
  State<AnswerVideoViewScreen> createState() => _AnswerVideoViewScreenState();
}

class _AnswerVideoViewScreenState extends State<AnswerVideoViewScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: VideoWidget(
            videoLink: widget.videoLink,
            isTablet: getSize(context) >= 700 ? true : false,
          ),
        ),
      ),
    );
  }
}
