import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:new_mazoon/core/remote/service.dart';

import '../../../core/models/class_data.dart';

part 'start_trip_state.dart';

class StartTripCubit extends Cubit<StartTripState> {
  StartTripCubit(this.api) : super(StartTripInitial()){
    getExplanationData();
  }
  final ServiceApi api;

  List<AllClasses> classesData= [];
  int currentIndex = 0;

  selectTap(int index) {
    currentIndex = index;
    emit(ChangeCurrentIndexTap());
  }

  getExplanationData() async {
    emit(StartTripExplanationLoading());
    final response = await api.explanationData();
    response.fold(
      (l) => emit(StartTripExplanationError()),
      (r) {
        classesData = r.data!;

        emit(StartTripExplanationLoaded());
      },
    );
  }
}
