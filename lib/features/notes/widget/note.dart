import 'dart:math';

import 'package:flutter/material.dart';
import 'package:new_mazoon/core/models/note_model.dart';
import 'package:new_mazoon/core/utils/app_colors.dart';
import 'package:new_mazoon/core/utils/hex_color.dart';

class NoteWidget extends StatefulWidget {
  const NoteWidget({Key? key, required this.noteModel, required this.index}) : super(key: key);
final NoteModel noteModel;
final int index;

  @override
  State<NoteWidget> createState() => _NoteWidgetState();
}

class _NoteWidgetState extends State<NoteWidget> {
  List<Color> colors=[AppColors.orange,
     AppColors.blue,
    AppColors.purple1
   ];

  @override
  Widget build(BuildContext context) {
    return  Material(
      elevation: 2,
      color: AppColors.unselectedTabColor,
      borderRadius: BorderRadius.all(Radius.circular(16)),
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(

                  color:lighten( colors[Random().nextInt(2)]),
              border: Border(right: BorderSide(color:
                   colors[Random().nextInt(2)]))
              ),
              child: Center(

              ),
            )
          ],
        ),
      ),
    );
  }
}
