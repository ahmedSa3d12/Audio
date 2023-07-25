part of 'note_cubit.dart';

@immutable
abstract class NoteState {}

class NoteInitial extends NoteState {}

class NoteLoaded extends NoteState {}

class NoteLoading extends NoteState {}

class NoteError extends NoteState {}

class DatesNoteLoaded extends NoteState {}

class DatesNoteLoading extends NoteState {}

class DatesNoteError extends NoteState {}
