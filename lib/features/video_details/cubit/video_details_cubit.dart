import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'package:cached_video_player/cached_video_player.dart';

import 'package:flutter/cupertino.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:new_mazoon/core/models/videoModel.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

import '../../../core/models/comment_data_model.dart';
import '../../../core/remote/service.dart';

part 'video_details_state.dart';

class VideoDetailsCubit extends Cubit<VideoDetailsState> {
  final ServiceApi api;
  TextEditingController comment_control = TextEditingController();
  TextEditingController replay_control = TextEditingController();
  int? video_id;
  String? type;
  XFile? imageFile;
  String imagePath = '';
  String audioPath = '';
  VideoModel? videoModel;
  Comments? comments;
  CommentsModel? commentsModel;
  bool isRecording = false;
  final audioRecorder = Record();
  Stream<FileResponse>? fileStream;

  double progress = 0;

  Future<void> start() async {
    try {
      if (await audioRecorder.hasPermission()) {
        await audioRecorder.start();

        isRecording = await audioRecorder.isRecording();

        emit(CommentsLoaded());
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> stop(int type) async {
    final path = await audioRecorder.stop();
    isRecording = false;
    if (type == 1) {
      addcommment("audio", '', path.toString());
    } else {
      addreplay("audio", '', path!);
    }
  }

  VideoDetailsCubit(this.api) : super(VideoDetailsInitial()) {}

  pickImage({required String type, required String type1}) async {
    imageFile = await ImagePicker().pickImage(
      source: type == 'camera' ? ImageSource.camera : ImageSource.gallery,
    );
    CroppedFile? croppedFile = await ImageCropper.platform.cropImage(
      sourcePath: imageFile!.path,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio7x5,
        CropAspectRatioPreset.ratio16x9
      ],
      cropStyle: CropStyle.rectangle,
      compressFormat: ImageCompressFormat.png,
      compressQuality: 90,
    );
    imagePath = croppedFile!.path;
    if (type1 == "1") {
      addcommment("file", imagePath, '');
    } else {
      addreplay("file", imagePath, '');
    }
  }

  getVideoDetails(int video_id, String type) async {
    this.video_id = video_id;
    this.type = type;
    emit(VideoDetailsLoading());
    final response = await api.getVideoDetails(video_id: video_id, type: type);
    response.fold(
      (l) => emit(VideoDetailsError()),
      (r) {
        videoModel = r.data!;
        getcomments(videoModel!.id!, type);

        emit(VideoDetailsLoaded());
      },
    );
  }

  getcomments(int video_id, String type) async {
    this.video_id = video_id;
    this.type = type;
    emit(CommentsLoading());
    final response = await api.getcomments(video_id: video_id, type: type);
    response.fold(
      (l) => emit(CommentsError()),
      (r) {
        comments = r.comments!;
        emit(CommentsLoaded());
      },
    );
  }

  void updateicone() {
    emit(CommentsLoaded());
  }

  addcommment(String type, String imagePath, String audio) async {
    final response = await api.addComments(
        video_id: videoModel!.id,
        type: type,
        text: comment_control.text,
        image: imagePath,
        audio: audio);
    response.fold(
      (l) => {print(l.toString()), emit(CommentsError())},
      (r) {
        comments!.data.insert(0, r.data);
        comment_control.text = '';
        imagePath = '';
        audioPath = '';
        emit(CommentsLoaded());
      },
    );
  }

  addreplay(String type, String imagePath, String audio) async {
    final response = await api.addreplay(
        comment_id: commentsModel!.id,
        type: type,
        text: replay_control.text,
        audio: audio,
        image: imagePath);
    response.fold(
      (l) => emit(CommentsError()),
      (r) {
        commentsModel!.replies.add(r.data);

        replay_control.text = '';
        emit(CommentsLoaded());
      },
    );
  }

  favourite(String type, String action) async {
    final response = await api.addToFavourite(
      action: action,
      video_id: video_id!,
      type: type,
    );
    response.fold(
      (l) => emit(VideoDetailsError()),
      (r) {
        videoModel!.favorite == "un_favorite"
            ? videoModel!.favorite = "favorite"
            : videoModel!.favorite = "un_favorite";
        emit(VideoDetailsLoaded());
      },
    );
  }

  downloadvideo() async {
    final dio = Dio();

    var dir = await (Platform.isIOS
        ? getApplicationSupportDirectory()
        : getApplicationDocumentsDirectory());
    await dio.download(
      videoModel!.link,
      dir.path + "/videos/" + videoModel!.link.split("/").toList().last,
      onReceiveProgress: (count, total) {
        progress = (count / total);
        print(progress);
        emit(VideoDetailsLoaded());
      },
    ).whenComplete(
      () {
        progress = 0;
        emit(VideoDetailsLoaded());
      },
    );
  }
}
