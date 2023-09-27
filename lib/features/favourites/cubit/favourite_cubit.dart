import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:new_mazoon/core/remote/service.dart';

import '../../../core/models/all_favourite.dart';

part 'favourite_state.dart';

class FavouriteCubit extends Cubit<FavouriteState> {
  FavouriteCubit(this.api) : super(FavouriteInitial()){
    getAllFavourite();
  }
  ServiceApi api;
  int currentIndex = 0 ;
  AllFavourite? allFavourite;

  //change tabs
  selectTap(int index) {
    currentIndex = index;
    emit(ChangeCurrentIndexTapState());
  }

  //get all favourite data

  getAllFavourite()async{
    emit(LoadingGetFavourite());
    final response = await api.getAllFavourite();
    response.fold((l) => emit(FailureGetFavourite()),
            (r) {
              allFavourite = r ;
       emit(SuccessfullyGetFavourite());

    });
  }
}
