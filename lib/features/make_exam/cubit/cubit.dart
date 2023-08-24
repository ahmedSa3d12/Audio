import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_mazoon/core/remote/service.dart';
import 'package:new_mazoon/features/make_exam/cubit/state.dart';
import 'package:numberpicker/numberpicker.dart';

import '../../../core/models/make_exam_model.dart';

class MakeYourExamCubit extends Cubit<MakeYourExamState> {
  MakeYourExamCubit(this.api) : super(MakeYourExamInitial());
  ServiceApi api;

  int questionNum = 0;
  addNewQuestion() {
    questionNum++;
    emit(AddewQuestionMakeYourExam());
  }

  deleteNewQuestion() {
    if (questionNum > 0) {
      questionNum--;
      emit(DeleteewQuestionMakeYourExam());
    }
  }

  int currentHour = 0;
  selectHour() {
    emit(SelectHour2MakeYourExam());
    return NumberPicker(
        value: currentHour,
        minValue: 0,
        maxValue: 11,
        onChanged: (value) {
          currentHour = value;
          emit(SelectHourMakeYourExam());
        });
  }

  int currentMinutes = 0;

  selectMinutes() {
    emit(SelectMinutes2MakeYourExam());
    return NumberPicker(
        value: currentMinutes,
        minValue: 0,
        maxValue: 59,
        step: 1,
        onChanged: (value) {
          currentMinutes = value;
          emit(SelectMinutesMakeYourExam());
        });
  }

  final List<String> levels = ['low'.tr(), 'middle'.tr(), 'high'.tr()];
  final List<String> examOn = ['exam_on_class'.tr(), 'exam_on_lesson'.tr()];
  List<String> lessons = [];
  String? selectedValueLevel;
  String? selectedValueExamtype;
  String? selectedValueLesson;
  //////get data

  List<MakeYourExamModelData> allClassesAndLessons = [];
  getDataOfMakeExam() async {
    emit(LoadingGetLessonAndClassOfMakeYourExam());
    final response = await api.getDataOfMakeExam();

    response.fold((l) => emit(ErrorGetLessonAndClassOfMakeYourExam()), (r) {
      allClassesAndLessons = r.data;
      emit(LoadedGetLessonAndClassOfMakeYourExam());
    });
  }

  ///1 class id
  int? currentClassID;

  ///2 totola minutes
  int totalMinutes() {
    return (currentHour * 60) + currentMinutes;
  }

  ///3 questionNum
  int? currentLessonID;
}
