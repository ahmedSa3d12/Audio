import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../../features/video_details/cubit/video_details_cubit.dart';

///https://www.youtube.com/watch?v=ODoquUbOXxw
class YoutubeVideoPlayer extends StatefulWidget {
  YoutubeVideoPlayer({required this.videoLinkId, super.key});
  String videoLinkId;
  @override
  State<YoutubeVideoPlayer> createState() => _YoutubeVideoPlayerState();
}

class _YoutubeVideoPlayerState extends State<YoutubeVideoPlayer> {
  late YoutubePlayerController _controller;
  late YoutubePlayer youtubePlayer;
  late String id;
  void checkVideo() {
    context.read<VideoDetailsCubit>().setduration(_controller.value.position);
    if (_controller.value.position ==
        Duration(seconds: 0, minutes: 0, hours: 0)) {
      print('video Started');
    }
    if (_controller.value.position == _controller.value.metaData.duration) {
      print('video Ended');
    }
  }

  @override
  void initState() {
    id = YoutubePlayer.convertUrlToId(widget.videoLinkId)!;
    _controller = YoutubePlayerController(
      initialVideoId: id,
      flags: YoutubePlayerFlags(
        autoPlay: false,
        // forceHD: true,
        mute: false,
        loop: false,
        hideThumbnail: true,
      ),
    );
    youtubePlayer = YoutubePlayer(
      controller: _controller,
      aspectRatio: 2.06,
      showVideoProgressIndicator: true,
    );
    print('.............................................');
    print(youtubePlayer.controller.value);
    print(youtubePlayer.controller.metadata.title);
    print('.............................................');

    _controller.addListener(
      () {
        checkVideo();
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: YoutubePlayerBuilder(
        builder: (context, player) => player,
        player: youtubePlayer,
      ),
    );
  }
}
