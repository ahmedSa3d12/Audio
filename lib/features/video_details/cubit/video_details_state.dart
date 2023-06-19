part of 'video_details_cubit.dart';

@immutable
abstract class VideoDetailsState {}

class VideoDetailsInitial extends VideoDetailsState {}
class VideoDetailsLoaded extends VideoDetailsState {}
class VideoDetailsError extends VideoDetailsState {}
class VideoDetailsLoading extends VideoDetailsState {}
