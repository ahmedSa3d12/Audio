import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';

import '../../../core/models/on_boarding_model.dart';
import '../../../core/remote/service.dart';

part 'on_boarding_state.dart';

class OnBoardingCubit extends Cubit<OnBoardingState> {
  OnBoardingCubit(this.api) : super(OnBoardingInitial()) {
    getOnBoardingData();
  }

  final ServiceApi api;

  List<OnBoardingDatum> listBorderData = [];

  getOnBoardingData() async {
    emit(OnBoardingLoading());
    final response = await api.onBoardingData();
    response.fold(
      (l) => emit(OnBoardingError()),
      (r) {
        if (r.code == 200) {
          listBorderData = r.data!;
          emit(OnBoardingLoaded());
        } else {
          emit(OnBoardingError());
        }
        // emit(OnBoardingLoaded());
      },
    );
  }
}
