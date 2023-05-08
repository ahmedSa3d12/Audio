import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

part 'paper_detials_state.dart';

class PaperDetialsCubit extends Cubit<PaperDetialsState> {
  TextEditingController name = TextEditingController();
  TextEditingController examtime = TextEditingController();
  TextEditingController examPlace = TextEditingController();
  TextEditingController examHall = TextEditingController();

  PaperDetialsCubit() : super(PaperDetialsInitial());
}
