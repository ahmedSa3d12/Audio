import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:new_mazoon/core/models/videoModel.dart';

import '../../../core/remote/service.dart';

part 'video_details_state.dart';

class VideoDetailsCubit extends Cubit<VideoDetailsState> {
  final ServiceApi api;
int? video_id;
String? type;
  VideoModel? videoModel;

  VideoDetailsCubit(this.api) : super(VideoDetailsInitial()){

  }
  getVideoDetails(int video_id,String type) async {
    this.video_id=video_id;
    this.type=type;
    emit(VideoDetailsLoading());
    final response = await api.getVideoDetails(video_id: video_id, type: type);
    response.fold(
          (l) => emit(VideoDetailsError()),
          (r) {
        videoModel = r.data!;
        emit(VideoDetailsLoaded());
      },
    );
  }

}
