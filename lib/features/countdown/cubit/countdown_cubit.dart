import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'countdown_state.dart';

class CountdownCubit extends Cubit<CountdownState> {
  CountdownCubit() : super(CountdownInitial());
}
