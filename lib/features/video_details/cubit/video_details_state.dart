part of 'video_details_cubit.dart';

@immutable
abstract class VideoDetailsState {}

class VideoDetailsInitial extends VideoDetailsState {}

class VideoDetailsLoaded extends VideoDetailsState {}

class VideoDetailsError extends VideoDetailsState {}

class VideoDetailsLoading extends VideoDetailsState {}

class VideoDetailsLikeLoaded extends VideoDetailsState {}

class VideoDetailsOnTapEditLoaded extends VideoDetailsState {}

class VideoDetailsLikeError extends VideoDetailsState {}

class VideoDetailsLikeLoading extends VideoDetailsState {}

class CommentsLoaded extends VideoDetailsState {}
class UpdateTimeDoneLoaded extends VideoDetailsState {}

class CommentsError extends VideoDetailsState {}

class CommentsLoading extends VideoDetailsState {}

class VideoUpdateTimeLoaded extends VideoDetailsState {}

class VideoUpdateTimeError extends VideoDetailsState {}

class VideoUpdateTimeLoading extends VideoDetailsState {}

class StopRecordingState extends VideoDetailsState {}
