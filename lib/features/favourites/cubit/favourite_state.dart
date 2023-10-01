part of 'favourite_cubit.dart';

@immutable
abstract class FavouriteState {}

class FavouriteInitial extends FavouriteState {}

class ChangeCurrentIndexTapState extends FavouriteState {}

class SuccessfullyGetFavourite extends FavouriteState {}

class LoadingGetFavourite extends FavouriteState {}

class FailureGetFavourite extends FavouriteState {}

class VideoDetailsLoaded extends FavouriteState {}

class VideoDetailsError extends FavouriteState {}
