import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_mazoon/core/models/elmazoon_model.dart';
import 'package:new_mazoon/core/remote/service.dart';
import 'package:new_mazoon/features/elmazoon_info/cubit/state.dart';

class ElMazoonCubit extends Cubit<ElMazoonState> {
  ElMazoonCubit(this.api) : super(ElMazoonInitial());
  ServiceApi api;
  int currentIndex = 0;
  selectTap(int index) {
    currentIndex = index;
    emit(ChangeCurrentIndexTap());
  }

  /// about me
  List<ELmazoonModelDataExperience> qualifications = [];
  List<ELmazoonModelDataExperience> experiences = [];
  List<ELmazoonModelDataExperience> skills = [];

  ELmazoonModelData? data;
  aboutMeMethod() async {
    emit(LoadingGetAboutMe());
    var response = await api.getAboutMe();
    response.fold((l) {
      emit(ErrorGetAboutMe());
    }, (r) {
      qualifications = r.data.qualifications;
      experiences = r.data.experiences;
      skills = r.data.skills;
      data = r.data;
      emit(LoadedGetAboutMe());
    });
  }
}
