import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';
import '../../../core/utils/getsize.dart';
import '../cubit/source_references_cubit.dart';

class VideoWidgetLink extends StatefulWidget {
  const VideoWidgetLink({Key? key, required this.videoLink}) : super(key: key);
  final String videoLink;
  // final int videoId;

  @override
  State<VideoWidgetLink> createState() => _VideoWidgetLinkState();
}

class _VideoWidgetLinkState extends State<VideoWidgetLink> {
  VideoPlayerController? _videoPlayerController;
  ChewieController? _chewieController;

  void checkVideo() {
    context
        .read<SourceReferencesCubit>()
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
    _videoPlayerController = VideoPlayerController.network(
      widget.videoLink,
    );
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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
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
        ),
      ),
    );
  }
}
