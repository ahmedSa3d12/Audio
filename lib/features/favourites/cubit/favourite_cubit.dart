import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:new_mazoon/core/remote/service.dart';

part 'favourite_state.dart';

class FavouriteCubit extends Cubit<FavouriteState> {
  FavouriteCubit(this.api) : super(FavouriteInitial());
  ServiceApi api;
  int currentIndex = 0 ;
  selectTap(int index) {
    currentIndex = index;
    emit(ChangeCurrentIndexTapState());
  }
}
