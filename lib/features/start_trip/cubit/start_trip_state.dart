part of 'start_trip_cubit.dart';

@immutable
abstract class StartTripState {}

class StartTripInitial extends StartTripState {}

class ChangeCurrentIndexTap extends StartTripState {}

class StartTripExplanationLoading extends StartTripState {}

class StartTripExplanationLoaded extends StartTripState {}

class StartTripExplanationError extends StartTripState {}

class StartTripFinalReviewLoading extends StartTripState {}

class StartTripFinalReviewLoaded extends StartTripState {}

class StartTripFinalReviewError extends StartTripState {}

class StartTripExamClassesLoading extends StartTripState {}

class StartTripExamClassesLoaded extends StartTripState {}

class StartTripExamClassesError extends StartTripState {}

class StartTripExamsClassByIdLoading extends StartTripState {}

class StartTripExamsClassByIdLoaded extends StartTripState {}

class StartTripExamsClassByIdError extends StartTripState {}

class StartTripExamsClassLoading extends StartTripState {}

class StartTripExamsClassLoaded extends StartTripState {}

class StartTripExamsClassError extends StartTripState {}

class ErrorAddHomeWorkToFavorite extends StartTripState {}

class LoadedAddHomeWorkToFavorite extends StartTripState {}
