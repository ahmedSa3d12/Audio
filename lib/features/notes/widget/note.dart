import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_mazoon/core/models/note_model.dart';
import 'package:new_mazoon/core/utils/app_colors.dart';
import 'package:new_mazoon/core/utils/assets_manager.dart';
import 'package:new_mazoon/core/utils/getsize.dart';
import 'package:new_mazoon/core/widgets/my_svg_widget.dart';

import '../cubit/note_cubit.dart';

class NoteWidget extends StatefulWidget {
  NoteWidget(
      {Key? key,
      required this.noteModel,
      required this.onTap,
      required this.onPressed,
      required this.index})
      : super(key: key);
  final NoteModel noteModel;
  final int index;
  void Function()? onPressed;
  void Function()? onTap;
  @override
  State<NoteWidget> createState() => _NoteWidgetState();
}

class _NoteWidgetState extends State<NoteWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NoteCubit, NoteState>(
      builder: (context, state) {
        var cubit = context.read<NoteCubit>();
        return InkWell(
          onTap: widget.onTap,
          child: Material(
            elevation: 2,
            color: AppColors.unselectedTabColor,
            borderRadius:
                BorderRadius.circular(MediaQuery.of(context).size.width / 22),
            child: Container(
              padding: EdgeInsets.all(getSize(context) / 88),
              color: AppColors.white,
              height: MediaQuery.of(context).size.width / 3.5,
              width: MediaQuery.of(context).size.width,
              child: Row(
                children: [
                  Stack(
                    alignment: Alignment.centerRight,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width / 10,
                        height: MediaQuery.of(context).size.width / 3.5,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                              MediaQuery.of(context).size.width / 32),
                          color: cubit.colors[widget.index % 3],
                        ),
                        child: Container(),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            right: MediaQuery.of(context).size.width / 72),
                        width: MediaQuery.of(context).size.width / 8,
                        decoration: BoxDecoration(
                            color: cubit.colorsLight[widget.index % 3],
                            borderRadius: BorderRadius.all(Radius.circular(
                                MediaQuery.of(context).size.width / 44))),
                        child: Center(
                            child: Text(
                          '${(widget.index < 10) ? '0' : ''}${widget.index + 1}',
                          style: TextStyle(
                              color: cubit.colors[widget.index % 3],
                              fontWeight: FontWeight.bold,
                              fontSize: getSize(context) / 22),
                        )),
                      )
                    ],
                  ),
                  Flexible(
                    fit: FlexFit.tight,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: getSize(context) / 44),
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
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: cubit.colors[widget.index % 3],
                                  fontWeight: FontWeight.bold,
                                  fontSize: getSize(context) / 24),
                            ),
                          ),
                          Text(
                            widget.noteModel.note,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: AppColors.liveExamGrayTextColor,
                                fontWeight: FontWeight.w300,
                                fontSize:
                                    MediaQuery.of(context).size.width / 26),
                          ),
                          // Text(
                          //   DateFormat.yMMMEd().format(widget.noteModel.date),
                          //   maxLines: 1,
                          //   overflow: TextOverflow.ellipsis,
                          //   style: TextStyle(
                          //       color: AppColors.liveExamGrayTextColor,
                          //       fontWeight: FontWeight.w200,
                          //       fontSize:
                          //           MediaQuery.of(context).size.width / 32),
                          // ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.topCenter,
                    child: IconButton(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.width / 44),
                      alignment: Alignment.topCenter,
                      icon: MySvgWidget(
                          path: ImageAssets.deleteIcon,
                          imageColor: AppColors.red,
                          size: MediaQuery.of(context).size.width / 18),
                      onPressed: widget.onPressed,
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
