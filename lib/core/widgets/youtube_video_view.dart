import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

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
  @override
  void initState() {
    id = YoutubePlayer.convertUrlToId(widget.videoLinkId)!;
    _controller = YoutubePlayerController(
      initialVideoId: id,
      flags: YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
        loop: false,
      ),
    );
    youtubePlayer = YoutubePlayer(controller: _controller, aspectRatio: 16 / 9);
    print('.............................................');
    print(youtubePlayer.controller.value);
    print(youtubePlayer.controller.metadata.title);
    print('.............................................');
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.contain,
      child: YoutubePlayerBuilder(
        builder: (context, player) => player,
        player: youtubePlayer,
      ),
    );
  }
}
