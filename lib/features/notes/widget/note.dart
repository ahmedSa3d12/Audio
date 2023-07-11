import 'package:flutter/material.dart';
import 'package:new_mazoon/core/models/note_model.dart';

class NoteWidget extends StatefulWidget {
  const NoteWidget({Key? key, required this.noteModel}) : super(key: key);
final NoteModel noteModel;
  @override
  State<NoteWidget> createState() => _NoteWidgetState();
}

class _NoteWidgetState extends State<NoteWidget> {
  @override
  Widget build(BuildContext context) {
    return  Container();
  }
}
