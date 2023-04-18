import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../core/models/user_model.dart';
import '../../../../core/preferences/preferences.dart';
import '../../../core/models/class_data.dart';
import '../../../core/models/home_page_model.dart';
import '../../../core/remote/service.dart';

part 'home_page_state.dart';

class HomePageCubit extends Cubit<HomePageState> {
  HomePageCubit(this.api) : super(HomePageInitial()) {
    getUserData().then((value) => getHomePageData());
  }

  UserModel? userModel;

  Future<void> getUserData() async {
    emit(HomePageLoading());
    userModel = await Preferences.instance.getUserModel();
  }

  final ServiceApi api;
  List<AllClasses> classes = [];
  List<SliderModel> sliders = [];
  List<HomePageVideosModel> videosBasics = [];
  List<FinalReviewModel> videosResources = [];

  getHomePageData() async {
    emit(HomePageLoading());
    final response = await api.getHomePageData();
    response.fold(
      (error) => emit(HomePageError()),
      (res) {
        classes = res.data!.classes!;
        sliders=res.data!.sliders!;
        videosBasics=res.data!.videosBasics!;
        videosResources=res.data!.videosResources!;

        emit(HomePageLoaded(res));
      },
    );
  }
}
