import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:new_mazoon/core/models/count_down_model.dart';

import '../../../core/remote/service.dart';

part 'countdown_state.dart';

class CountdownCubit extends Cubit<CountdownState> {
  final ServiceApi api;

  CountDown? countDown;
  CountdownCubit(this.api) : super(CountdownInitial()){
    getcountDown();
  }
  Future<void> getcountDown() async {

    emit(CountDownLoading());
    final response = await api.getCountDown();
    response.fold(
          (error) => emit(CountDownError()),
          (res) {
        if(res.code==200) {
          countDown = res.data;
        }
        else{

        }
        emit(CountDownLoaded());
      },
    );
  }

}
