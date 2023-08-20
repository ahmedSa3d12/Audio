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

class SelectDateFromDatePicker extends NoteState {}

class AddNewNoteLoaded extends NoteState {}

class AddNewNoteLoading extends NoteState {}

class AddNewNoteError extends NoteState {}

class DeleteoteLoaded extends NoteState {}

class DeleteNoteLoading extends NoteState {}

class DeleteNoteError extends NoteState {}
