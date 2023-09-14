import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_mazoon/core/remote/service.dart';
import 'package:new_mazoon/features/downloads/cubit/downloadsstate.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:video_player/video_player.dart';

import '../../../core/utils/dialogs.dart';

class DownloadedFilesCubit extends Cubit<DownloadedFilesState> {
  DownloadedFilesCubit(this.api) : super(InitDownloadedFilesState()) {
    getPDFs();
    getDownloadvideo();
  }
  ServiceApi api;
  int currentIndex = 0;

  selectTap(int index) {
    currentIndex = index;
    emit(ChangeCurrentIndexTap());
  }

  List<File> savedList = [];
  getDownloadvideo() async {
    emit(LoadingDownloadedFilesState());
    var dir = await (Platform.isIOS
        ? getApplicationSupportDirectory()
        : getApplicationDocumentsDirectory());
    final videoDirectory = Directory('${dir.path}/videos/');
    if (await videoDirectory.exists()) {
      final videoFiles = videoDirectory
          .listSync()
          .where((file) => file is File)
          .cast<File>()
          .toList();
      print('...........................');
      print(videoFiles.length);
      savedList = videoFiles;
      print(savedList.length);
      print('...........................');
      emit(LoadedDownloadedFilesState());
      return videoFiles;
    } else {
      emit(ErrorDownloadedFilesState());
      return [];
    }
  }

  Future<void> deleteDownloadedFile(String fileName) async {
    emit(LoadingDeleteVideoFile());
    var dir = await (Platform.isIOS
        ? getApplicationSupportDirectory()
        : getApplicationDocumentsDirectory());
    final file = File('${dir.path}/videos/$fileName');
    if (await file.exists()) {
      await file.delete();
      getDownloadvideo();
      emit(LoadedDeleteVideoFile());
    }
  }

  Future<void> deleteDownloadedFilePDF(String fileName) async {
    emit(LoadingDeletePDFile());
    var dir = await (Platform.isIOS
        ? getApplicationSupportDirectory()
        : getApplicationDocumentsDirectory());
    final file = File('${dir.path}/pdf/$fileName');
    if (await file.exists()) {
      await file.delete();
      getPDFs();
      emit(LoadedDeletePDFFile());
    }
  }

  List<File> files = [];
  getPDFs() async {
    emit(DownloadsPDFLoading());
    try {
      var dir = await (Platform.isIOS
          ? getApplicationSupportDirectory()
          : getApplicationDocumentsDirectory());
      Directory directory = Directory('${dir.path}/pdf/');
      if (await directory.exists()) {
        final filess = directory
            .listSync()
            .where((file) => file is File)
            .cast<File>()
            .toList();
        print('--------------------------');
        print(filess.length);
        print(filess.first.path);
        print('--------------------------');
        files = filess;
      } else {
        files = [];
      }
      print("object");
      print(files.length);
      emit(DownloadsPDFLoaded());
    } catch (e) {
      print(e);
      emit(DownloadsPDFError());
    }
  }

  VideoPlayerController? controller;
  initVideoView(videoPath) {
    emit(LoadingViewVideo());
    Permission.storage.request().then((status) {
      if (status.isGranted) {
        final file = videoPath;
        controller = VideoPlayerController.file(file)
          ..initialize().then((_) {
            print('initialized');
            emit(LoadedViewVideo());
          }).onError((error, stackTrace) {
            errorGetBar(error.toString());
            print(error.toString());
            emit(ErrorViewVideo());
          });
      } else {}
    });
  }
}
