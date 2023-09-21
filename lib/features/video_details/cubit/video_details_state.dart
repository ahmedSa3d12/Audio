part of 'video_details_cubit.dart';

@immutable
abstract class VideoDetailsState {}

class VideoDetailsInitial extends VideoDetailsState {}

class VideoDetailsLoaded extends VideoDetailsState {}

class VideoDetailsError extends VideoDetailsState {}

class VideoDetailsLoading extends VideoDetailsState {}

class CommentsLoaded extends VideoDetailsState {}

class CommentsError extends VideoDetailsState {}

class CommentsLoading extends VideoDetailsState {}

class VideoUpdateTimeLoaded extends VideoDetailsState {}

class VideoUpdateTimeError extends VideoDetailsState {}

class VideoUpdateTimeLoading extends VideoDetailsState {}
