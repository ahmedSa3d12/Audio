import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:new_mazoon/core/remote/service.dart';
import 'package:path_provider/path_provider.dart';

import '../../../core/models/sources_references_model.dart';
import '../../../core/models/sources_referenes_by_id_model.dart';

part 'source_references_state.dart';

class SourceReferencesCubit extends Cubit<SourceReferencesState> {
  SourceReferencesCubit(this.api) : super(SourceReferencesInitial()) {
    sourcesAndReferencesData();
  }

  final ServiceApi api;
  List<SourcesReferencesDatum> sourcesReferencesList = [];
  List<SourcesReferencesByIdDatum> sourcesReferencesByIdList = [];
  late SourcesReferencesDatum referenceModel;

  sourcesAndReferencesData() async {
    emit(SourceReferencesLoading());
    final response = await api.sourcesAndReferencesData();
    response.fold(
      (l) => emit(SourceReferencesError()),
      (r) {
        sourcesReferencesList = r.data!;
        emit(SourceReferencesLoaded());
      },
    );
  }

  sourcesAndReferencesDataById(int classId) async {
    emit(SourceReferencesByIdLoading());
    final response =
        await api.sourcesAndReferencesByIdData(referenceModel.id!, classId);
    response.fold(
      (l) => emit(SourceReferencesByIdError()),
      (r) {
        sourcesReferencesByIdList = r.data!;
        emit(SourceReferencesByIdLoaded());
      },
    );
  }

  downloadPdf(SourcesReferencesDatum model) async {
    final dio = Dio();
    // int index = sourcesReferencesList.indexOf(model);
    var dir = await (Platform.isIOS
        ? getApplicationSupportDirectory()
        : getApplicationDocumentsDirectory());
    await dio.download(
      model.filePath!,
      dir.path + "/pdf/" + model.filePath!.split("/").toList().last,
      onReceiveProgress: (count, total) {
        model.progress = (count / total);
        // sourcesReferencesList.removeAt(index);
        // sourcesReferencesList.insert(index, model);
        emit(PDFSourceReferencesByIdLoaded());
      },
    ).whenComplete(
      () {
        model.progress = 0;
        // sourcesReferencesList.removeAt(index);
        // sourcesReferencesList.insert(index, model);
        emit(PDFSourceReferencesByIdLoaded());
      },
    );
  }

  downloadPdfLessons(SourcesReferencesByIdDatum model) async {
    final dio = Dio();
    int index = sourcesReferencesByIdList.indexOf(model);
    var dir = await (Platform.isIOS
        ? getApplicationSupportDirectory()
        : getApplicationDocumentsDirectory());
    await dio.download(
      model.filePath!,
      dir.path + "/pdf/" + model.filePath!.split("/").toList().last,
      onReceiveProgress: (count, total) {
        model.progress = (count / total);
        sourcesReferencesByIdList.removeAt(index);
        sourcesReferencesByIdList.insert(index, model);
        emit(PDFSLessonourceReferencesByIdLoaded());
      },
    ).whenComplete(
      () {
        model.progress = 0;
        sourcesReferencesByIdList.removeAt(index);
        sourcesReferencesByIdList.insert(index, model);
        emit(PDFSLessonourceReferencesByIdLoaded());
      },
    );
  }
}
