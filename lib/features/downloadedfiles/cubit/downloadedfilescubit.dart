import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_mazoon/core/remote/service.dart';
import 'package:new_mazoon/features/downloadedfiles/cubit/downloadedfilesstate.dart';
import 'package:path_provider/path_provider.dart';

class DownloadedFilesCubit extends Cubit<DownloadedFilesState> {
  DownloadedFilesCubit(this.api) : super(InitDownloadedFilesState());
  ServiceApi api;
  int currentIndex = 0;

  selectTap(int index) {
    currentIndex = index;
    emit(ChangeCurrentIndexTap());
  }

  List<File> localVideos = [];

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
      print('...........................');
      emit(LoadedDownloadedFilesState());
      return videoFiles;
    } else {
      emit(ErrorDownloadedFilesState());
      return [];
    }
  }

  Future<void> deleteDownloadedFile(String fileName) async {
    var dir = await (Platform.isIOS
        ? getApplicationSupportDirectory()
        : getApplicationDocumentsDirectory());
    final file = File('${dir.path}/videos/$fileName');
    if (await file.exists()) {
      await file.delete();
    }
  }

  // Future<void> openPDFFile(String fileName) async {
  //   var dir = await (Platform.isIOS
  //       ? getApplicationSupportDirectory()
  //       : getApplicationDocumentsDirectory());
  //   final filePath = '${dir.path}/videos/$fileName';
  //   Navigator.of(context).push(MaterialPageRoute(
  //     builder: (context) => MyPDFViewerWidget(file: File(filePath)),
  //   ));
  // }
}
