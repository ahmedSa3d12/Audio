import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_mazoon/core/utils/app_colors.dart';
import 'package:new_mazoon/features/downloads/cubit/downloadsstate.dart';
import 'package:video_player/video_player.dart';

import '../cubit/downloadscubit.dart';

class VideoPlayerScreen extends StatefulWidget {
  final File videoPath;

  VideoPlayerScreen({required this.videoPath});

  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  bool isLoading = true;
  @override
  void initState() {
    context.read<DownloadedFilesCubit>().initVideoView(widget.videoPath);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    context.read<DownloadedFilesCubit>().controller!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DownloadedFilesCubit, DownloadedFilesState>(
      listener: (context, state) {
        if (state is LoadingViewVideo) {
          isLoading = true;
        } else {
          isLoading = false;
        }
      },
      builder: (context, state) {
        var cubit = context.read<DownloadedFilesCubit>();
        return Scaffold(
          backgroundColor: AppColors.black,
          body: Center(
              child: isLoading
                  ? CircularProgressIndicator()
                  : Stack(
                      children: [
                        AspectRatio(
                          aspectRatio: cubit.controller!.value.aspectRatio,
                          child: VideoPlayer(
                            cubit.controller!,
                          ),
                        ),
                        Positioned(
                            bottom: 0,
                            width: MediaQuery.of(context).size.width,
                            child: VideoProgressIndicator(
                              cubit.controller!,
                              allowScrubbing: false,
                              colors: VideoProgressColors(
                                  backgroundColor: Colors.blueGrey,
                                  bufferedColor: Colors.blueGrey,
                                  playedColor: AppColors.orange),
                            ))
                      ],
                    )),
          floatingActionButton: FloatingActionButton(
            backgroundColor: AppColors.orange,
            onPressed: () {
              setState(() {
                if (cubit.controller!.value.isPlaying) {
                  cubit.controller!.pause();
                } else {
                  cubit.controller!.play();
                }
              });
            },
            child: Icon(
              cubit.controller!.value.isPlaying
                  ? Icons.pause
                  : Icons.play_arrow,
            ),
          ),
        );
      },
    );
  }
}
