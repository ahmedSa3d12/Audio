import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:meta/meta.dart';
import 'package:new_mazoon/core/remote/service.dart';
import 'package:path_provider/path_provider.dart';

import '../../../core/models/all_favourite.dart';
import '../../../core/utils/dialogs.dart';

part 'favourite_state.dart';

class FavouriteCubit extends Cubit<FavouriteState> {
  FavouriteCubit(this.api) : super(FavouriteInitial()) {
    getAllFavourite();
  }
  ServiceApi api;
  int currentIndex = 0;
  AllFavourite? allFavourite;

  //change tabs
  selectTap(int index) {
    currentIndex = index;
    emit(ChangeCurrentIndexTapState());
  }

  //get all favourite data

  getAllFavourite() async {
    emit(LoadingGetFavourite());
    final response = await api.getAllFavourite();
    response.fold((l) => emit(FailureGetFavourite()), (r) {
      allFavourite = r;
      emit(SuccessfullyGetFavourite());
    });
  }

  removeFavouriteVideo(String type, String action, int video_id) async {
    final response = await api.addToFavourite(
      action: action,
      video_id: video_id,
      type: type,
    );
    response.fold(
      (l) {
        emit(VideoDetailsError());
      },
      (r) {
        getAllFavourite();
        successGetBar(r.message);
        emit(VideoDetailsLoaded());
      },
    );
  }

  downloadPdf(AllExamFavorite model) async {
    emit(FavDownloadPdfLoading());
    final dio = Dio();
    int index = allFavourite!.data.allExamFavorites!.indexOf(model);

    var dir = await (Platform.isIOS
        ? getApplicationSupportDirectory()
        : getApplicationDocumentsDirectory());
    await dio.download(
      model.pdfFileUpload!,
      dir.path + "/pdf/" + model.name!.split("/").toList().last + '.pdf',
      onReceiveProgress: (count, total) {
        model.progress = (count / total);
        allFavourite!.data.allExamFavorites!.removeAt(index);
        allFavourite!.data.allExamFavorites!.insert(index, model);
        emit(FavDownloadPdfLoaded());
      },
    ).whenComplete(
      () {
        successGetBar('success_download'.tr());

        model.progress = 0;
        allFavourite!.data.allExamFavorites!.removeAt(index);
        allFavourite!.data.allExamFavorites!.insert(index, model);
        emit(Fav2DownloadPdfLoaded());
      },
    );
  }

  removeFavouriteExam(String type, String action, int video_id, int index) async {
    print("________________________________________________________________________");
    print("type = $type , action = $action , video_id = $video_id   , index = $index");
    final response = await api.addToFavouriteExam(
      action: 'un_favorite',
      exam_id: video_id,
      type: type,
    );
    response.fold(
          (l) => emit(ErrorRemoveFavoriteExam()),
          (r) {
            emit(SuccessRemoveFavoriteExam());
        successGetBar(r.message);

      },
    );
  }
}
