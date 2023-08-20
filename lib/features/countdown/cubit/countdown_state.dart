part of 'countdown_cubit.dart';

@immutable
abstract class CountdownState {}

class CountdownInitial extends CountdownState {}
class CountDownLoaded extends CountdownState {}
class CountDownError extends CountdownState {}
class CountDownLoading extends CountdownState {}
