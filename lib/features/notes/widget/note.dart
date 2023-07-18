import 'package:flutter/material.dart';
import 'package:new_mazoon/core/models/note_model.dart';
import 'package:new_mazoon/core/utils/app_colors.dart';
import 'package:new_mazoon/core/utils/assets_manager.dart';
import 'package:new_mazoon/core/widgets/my_svg_widget.dart';

class NoteWidget extends StatefulWidget {
  const NoteWidget({Key? key, required this.noteModel, required this.index})
      : super(key: key);
  final NoteModel noteModel;
  final int index;

  @override
  State<NoteWidget> createState() => _NoteWidgetState();
}

class _NoteWidgetState extends State<NoteWidget> {
  List<Color> colors = [AppColors.orange, AppColors.blue, AppColors.purple1];
  List<Color> colorsLight = [
    AppColors.orangelight,
    AppColors.bluelight,
    AppColors.purple1light
  ];

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 2,
      color: AppColors.unselectedTabColor,
      borderRadius:
          BorderRadius.circular(MediaQuery.of(context).size.width / 22),
      child: Container(
        color: AppColors.white,
        height: MediaQuery.of(context).size.width / 3.5,
        width: MediaQuery.of(context).size.width,
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Stack(
                alignment: Alignment.centerRight,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width / 10,
                    height: MediaQuery.of(context).size.width / 3.5,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                          MediaQuery.of(context).size.width / 32),
                      color: colors[widget.index % 3],
                    ),
                    child: Container(),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        right: MediaQuery.of(context).size.width / 72),
                    width: MediaQuery.of(context).size.width / 8,
                    decoration: BoxDecoration(
                        color: colorsLight[widget.index % 3],
                        borderRadius: BorderRadius.all(Radius.circular(
                            MediaQuery.of(context).size.width / 44))),
                    child: Center(
                        child: Text(
                      '${(widget.index < 10) ? '0' : ''}${widget.index + 1}',
                      style: TextStyle(
                          color: colors[widget.index % 3],
                          fontWeight: FontWeight.bold,
                          fontSize: MediaQuery.of(context).size.width / 16),
                    )),
                  )
                ],
              ),
            ),
            Expanded(
              flex: 9,
              child: Container(
                margin: EdgeInsets.symmetric(
                    vertical: MediaQuery.of(context).size.width / 88),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      child: Text(
                        widget.noteModel.title,
                        maxLines: 1,
                        overflow: TextOverflow.clip,
                        style: TextStyle(
                            color: colors[widget.index % 3],
                            fontWeight: FontWeight.bold,
                            fontSize: MediaQuery.of(context).size.width / 16),
                      ),
                    ),
                    Text(
                      widget.noteModel.note,
                      maxLines: 2,
                      overflow: TextOverflow.clip,
                      style: TextStyle(
                          color: AppColors.liveExamGrayTextColor,
                          fontWeight: FontWeight.w400,
                          fontSize: MediaQuery.of(context).size.width / 18),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
                child: Container(
              alignment: Alignment.topCenter,
              child: IconButton(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.width / 44),
                alignment: Alignment.topCenter,
                icon: MySvgWidget(
                    path: ImageAssets.deleteIcon,
                    imageColor: AppColors.red,
                    size: MediaQuery.of(context).size.width / 18),
                onPressed: () {
                  //
                },
              ),
            ))
          ],
        ),
      ),
    );
  }
}
