import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/cupertino.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:new_mazoon/core/models/videoModel.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

import '../../../core/models/comment_data_model.dart';
import '../../../core/remote/service.dart';
import '../../../core/utils/appwidget.dart';

part 'video_details_state.dart';

class VideoDetailsCubit extends Cubit<VideoDetailsState> {
  final ServiceApi api;
  TextEditingController report_control = TextEditingController();
  TextEditingController comment_control = TextEditingController();
  TextEditingController editcomment_control = TextEditingController();
  TextEditingController replay_control = TextEditingController();
  TextEditingController editreplay_control = TextEditingController();
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

  double pos = 50;

  int ishour = 0;

  Duration? duration;

  Future<void> start() async {
    try {
      if (await audioRecorder.hasPermission()) {
        await audioRecorder.start();

        isRecording = await audioRecorder.isRecording();
        pos = 200;
        emit(CommentsLoaded());
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> stop(int type) async {
    final path = await audioRecorder.stop();
    isRecording = false;
    pos = 50;
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
        videoModel = r.data;
        getcomments(videoModel!.id, type);

        emit(VideoDetailsLoaded());
      },
    );
  }

  getcomments(int video_id, String type) async {
    this.video_id = video_id;
    this.type = type;
    emit(CommentsLoading());
    print("loading comment");
    print('type');
    print(type);
    print(video_id);

    final response = await api.getcomments(video_id: video_id, type: type);
    response.fold(
      (l) {
        emit(CommentsError());
        print('error comment');
      },
      (r) {
        print("loaded comment");
        comments = r.comments;

        print(comments!.data.length);
        emit(CommentsLoaded());
      },
    );
  }

  void updateicone() {
    emit(CommentsLoaded());
  }

  addcommment(String type, String imagePath, String audio) async {
    final response = await api.addComments(
        videoType: this.type!,
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

  editcommment(String type, int index) async {
    final response = await api.editComments(
      comment_id: comments!.data.elementAt(index)!.id,
      type: type,
      text: editcomment_control.text,
    );
    response.fold(
      (l) => {print(l.toString()), emit(CommentsError())},
      (r) {
        comments!.data.removeAt(index);
        comments!.data.insert(index, r.data);
        editcomment_control.text = '';

        emit(CommentsLoaded());
      },
    );
  }

  editreplay(String type, int index) async {
    final response = await api.editReplay(
      comment_id: commentsModel!.replies.elementAt(index).id,
      type: type,
      text: editreplay_control.text,
    );
    response.fold(
      (l) => {print(l.toString()), emit(CommentsError())},
      (r) {
        commentsModel!.replies.removeAt(index);
        commentsModel!.replies.insert(index, r.data);
        editreplay_control.text = '';

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
      dir.path +
          "/videos/" +
          videoModel!.name.split("/").toList().last +
          '.mp4',
      onReceiveProgress: (count, total) {
        progress = (count / total);
        print(progress);
        emit(VideoDetailsLoaded());
      },
    ).whenComplete(
      () {
        print(videoModel!.name);
        progress = 0;
        emit(VideoDetailsLoaded());
      },
    );
  }

  Future<void> delecomment(int id, int index) async {
    print("lllll");
    print(id);
    final response = await api.delecomment(
      commnet_id: id,
    );
    response.fold(
      (l) => {print(l.toString()), emit(CommentsError())},
      (r) {
        comments!.data.removeAt(index);

        emit(CommentsLoaded());
      },
    );
  }

  Future<void> delereplay(int id, int index) async {
    print("lllll");
    print(id);
    final response = await api.delecomment(
      commnet_id: id,
    );
    response.fold(
      (l) => {print(l.toString()), emit(CommentsError())},
      (r) {
        commentsModel!.replies!.removeAt(index);

        emit(CommentsLoaded());
      },
    );
  }

  void showEdittext(int index) {
    CommentsModel commentsModel = comments!.data.elementAt(index);
    commentsModel.show = !commentsModel.show;
    comments!.data.removeAt(index);
    comments!.data.insert(index, commentsModel);
    emit(CommentsLoaded());
  }

  void showreplayEdittext(int index) {
    Reply reply = commentsModel!.replies.elementAt(index);
    reply.show = !reply.show;
    commentsModel!.replies.removeAt(index);
    commentsModel!.replies.insert(index, reply);
    emit(CommentsLoaded());
  }

  Future<void> report(BuildContext context) async {
    AppWidget.createProgressDialog(context, 'wait'.tr());
    print("lllll");

    final response = await api.addreport(
      video_id: videoModel!.id,
      type: type!,
      comment: report_control.text,
    );
    response.fold(
      (l) =>
          {print(l.toString()), Navigator.pop(context), Navigator.pop(context)},
      (r) {
        Navigator.pop(context);
        Navigator.pop(context);
        report_control.text = '';
        emit(CommentsLoaded());
      },
    );
  }

  void setduration(Duration duration) {
    print("ddlldldl0");
    this.duration = duration;
    emit(CommentsLoaded());
  }

  Future<void> updateTime() async {
    if (type == "video_part") {
      if (duration! >
          Duration(
              seconds: int.parse(videoModel!.video_minutes.split(":")[0]),
              minutes: int.parse(videoModel!.video_minutes.split(":")[1]),
              hours: int.parse(videoModel!.video_minutes.split(":")[2]))) {
        final response = await api.updateVideoTime(
          video_id: videoModel!.id,
          minutes: duration!.inHours.toString() +
              ":" +
              duration!.inMinutes.toString() +
              ":" +
              duration!.inSeconds.toString(),
        );
        response.fold(
          (l) => {
            print(l.toString()),
          },
          (r) {
            getVideoDetails(video_id!, type!);
            emit(CommentsLoaded());
          },
        );
      }
    }
  }
}
