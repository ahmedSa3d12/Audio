part of 'start_trip_cubit.dart';

@immutable
abstract class StartTripState {}

class StartTripInitial extends StartTripState {}

class ChangeCurrentIndexTap extends StartTripState {}

class StartTripExplanationLoading extends StartTripState {}
class StartTripExplanationLoaded extends StartTripState {}
class StartTripExplanationError extends StartTripState {}

