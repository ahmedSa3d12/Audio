import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_mazoon/features/video_details/cubit/video_details_cubit.dart';
import 'package:video_player/video_player.dart';

import '../../../core/utils/getsize.dart';

class VideoWidgetFile extends StatefulWidget {
  const VideoWidgetFile({Key? key, required this.videoLink}) : super(key: key);
  final File videoLink;
  // final int videoId;

  @override
  State<VideoWidgetFile> createState() => _VideoWidgetFileState();
}

class _VideoWidgetFileState extends State<VideoWidgetFile> {
  VideoPlayerController? _videoPlayerController;
  ChewieController? _chewieController;

  void checkVideo() {
    context
        .read<VideoDetailsCubit>()
        .setduration(_videoPlayerController!.value.position);
    if (_videoPlayerController!.value.position ==
        Duration(seconds: 0, minutes: 0, hours: 0)) {
      print('video Started');
    }
    if (_videoPlayerController!.value.position ==
        _videoPlayerController!.value.duration) {
      print('video Ended');
    }
  }

  @override
  void initState() {
    super.initState();
    initializePlayer();
  }

  Future<void> initializePlayer() async {
    _videoPlayerController = VideoPlayerController.file(widget.videoLink);
    _videoPlayerController!.addListener(
      () {
        checkVideo();
      },
    );
    await Future.wait([_videoPlayerController!.initialize()]);
    _createChewieController();
    setState(() {});
  }

  void _createChewieController() {
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController!,
      autoPlay: true,
      allowFullScreen: true,
      aspectRatio: 2.06,
      controlsSafeAreaMinimum: EdgeInsets.all(getSize(context) / 88),
      looping: false,
      fullScreenByDefault: false,
      hideControlsTimer: const Duration(seconds: 3),
    );
  }

  @override
  void dispose() {
    _videoPlayerController!.dispose();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 4,
      width: MediaQuery.of(context).size.width,
      child: _chewieController != null &&
              _chewieController!.videoPlayerController.value.isInitialized
          ? Chewie(controller: _chewieController!)
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                CircularProgressIndicator(),
              ],
            ),
    );
  }
}
