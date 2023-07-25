import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:meta/meta.dart';
import 'package:new_mazoon/core/models/note_model.dart';

import '../../../core/models/datesofnotes.dart';
import '../../../core/remote/service.dart';

part 'note_state.dart';

class NoteCubit extends Cubit<NoteState> {
  List<NoteModel> noteplanList = [];

  String date = DateFormat('yyyy-MM-dd').format(DateTime.now());
  DateTime datefoucse = DateTime.now();
  DateTime datecurrent = DateTime.now();
  NoteCubit(this.api) : super(NoteInitial());
  final ServiceApi api;

  Future<void> getNotes(
      String date, DateTime dateFoucse, DateTime dateCurrent) async {
    this.date = date;
    this.datefoucse = dateFoucse;
    this.datecurrent = dateCurrent;
    emit(NoteLoading());
    final response = await api.getNotes(date);
    response.fold(
      (error) => emit(NoteError()),
      (res) {
        if (res.data != null) {
          noteplanList = res.data;
        } else {
          noteplanList = [];
        }
        emit(NoteLoaded());
      },
    );
  }

  List<DatesOfNotesData> datesOfNotes = [];
  Future<void> getDatesOfNotes() async {
    emit(DatesNoteLoading());
    final response = await api.getDatesOfNotes();
    response.fold(
      (error) => emit(DatesNoteError()),
      (res) {
        if (res.data.isNotEmpty) {
          datesOfNotes = res.data;
        } else {
          datesOfNotes = [];
        }
        emit(DatesNoteLoaded());
      },
    );
  }
}
