import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_mazoon/features/video_details/cubit/video_details_cubit.dart';
import 'package:video_player/video_player.dart';

import '../utils/app_colors.dart';

class VideoWidget extends StatefulWidget {
  const VideoWidget({Key? key, required this.videoLink, required this.videoId})
      : super(key: key);
  final String videoLink;
  final int videoId;

  @override
  State<VideoWidget> createState() => _VideoWidgetState();
}

class _VideoWidgetState extends State<VideoWidget> {
  late VideoPlayerController _videoPlayerController;
  ChewieController? _chewieController;

  void checkVideo() {
 //   print('video dlldkdkdk');

    context.read<VideoDetailsCubit>().setduration(_videoPlayerController.value.position);
    if (_videoPlayerController.value.position ==
        Duration(seconds: 0, minutes: 0, hours: 0)) {
      print('video Started');
    }
    if (_videoPlayerController.value.position ==
        _videoPlayerController.value.duration) {
      // context.read<StudyPageCubit>().accessNextVideo(widget.videoId);
      print('video Ended');
    }
  }

  @override
  void initState() {
    super.initState();
    initializePlayer();
  }

  Future<void> initializePlayer() async {
    _videoPlayerController = VideoPlayerController.network(widget.videoLink);
    _videoPlayerController.addListener(
      () {
        checkVideo();
      },
    );
    await Future.wait([_videoPlayerController.initialize()]);
    _createChewieController();
    setState(() {});
  }

  void _createChewieController() {
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      autoPlay: false,
      allowFullScreen: false,
      aspectRatio: 2.06,
      controlsSafeAreaMinimum: EdgeInsets.zero,
      looping: false,
      hideControlsTimer: const Duration(seconds: 3),
    );
  }

  @override
  void dispose() {
    context.read<VideoDetailsCubit>().setduration( _videoPlayerController.value.duration);
    _videoPlayerController.dispose();
    _chewieController?.dispose();
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
