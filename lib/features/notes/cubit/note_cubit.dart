import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:new_mazoon/core/models/note_model.dart';

import '../../../core/models/addnotebystudent.dart';
import '../../../core/models/datesofnotes.dart';
import '../../../core/remote/service.dart';
import '../../../core/utils/app_colors.dart';

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
        emit(NoteLoaded());
      },
    );
  }

  ///
  ///
  ///
  TextEditingController dateController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController noteController = TextEditingController();
  DateTime selectedDate = DateTime.now();

  AddNewNoteModelData? addNewNoteData;
  Future<void> addNewNote(
    BuildContext context,
  ) async {
    emit(AddNewNoteLoading());
    final response = await api.addNewNote(
        note: noteController.text,
        note_date: dateController.text,
        title: titleController.text);
    response.fold(
      (error) => emit(AddNewNoteError()),
      (res) {
        if (res.data != null) {
          Navigator.pop(context);
          addNewNoteData = res.data;
          dateController.clear();
          titleController.clear();
          noteController.clear();
          emit(NoteLoaded());
        }
      },
    );
  }

  List<Color> colors = [AppColors.orange, AppColors.blue, AppColors.purple1];
  List<Color> colorsLight = [
    AppColors.orangelight,
    AppColors.bluelight,
    AppColors.purple1light
  ];
  Future<void> deleteNote(int id, int index) async {
    emit(DeleteNoteLoading());
    final response = await api.deleteNote(
      noteId: id,
    );
    response.fold(
      (l) => {emit(DeleteNoteError())},
      (r) {
        noteplanList.removeAt(index);
        emit(NoteLoaded());
      },
    );
  }

  /*
  
  
   Future<void> delecomment(int id, int index) async {
    print("lllll");
    print(id);
    final response = await api.delecomment(
      commnet_id: id,
    );
    response.fold(
      (l) => {print(l.toString()), emit(CommentsError())},
      (r) {
        comments!.data.removeAt(index);

        emit(CommentsLoaded());
      },
    );
  } */
}
