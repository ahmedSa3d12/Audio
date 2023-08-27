import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_mazoon/core/remote/service.dart';
import 'package:new_mazoon/core/utils/toast_message_method.dart';
import 'package:new_mazoon/features/make_exam/cubit/state.dart';
import 'package:numberpicker/numberpicker.dart';

import '../../../core/models/applaymakeexammodel.dart';
import '../../../core/models/make_exam_model.dart';
import '../../../core/models/questionsmakeexam.dart';

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
  List<Lesson> lessons = [];
  String? selectedValueLevel;
  String? selectedValueExamtype;
  String? selectedValueLesson;
  Lesson? currentLesson;
  int? lessonId;
  MakeYourExamModelData? classModel;

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

  QuestionsOfMakeExamModelData? allData;
  Future MakeYourExam(
      {int? lessonIdd, int? classId, required BuildContext context}) async {
    emit(LoadingPostLessonAndClassOfMakeYourExam());
    final response = await api.MakeYourExam(
      num_of_questions: questionNum,
      questions_type: selectedValueLevel == 'low'.tr()
          ? 'low'
          : selectedValueLevel == 'middle'.tr()
              ? 'mid'
              : 'high',
      total_time: totalMinutes(),
      lesson_id: lessonIdd,
      subject_class_id: classId,
    );
    response.fold((l) => emit(ErrorPostLessonAndClassOfMakeYourExam()), (r) {
      if (r.data == null) {
        toastMessage(r.data.toString(), context);
      } else {
        allData = r.data;
        print(r.data);
        print('aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa');
        emit(LoadedPostLessonAndClassOfMakeYourExam());
      }
    });
  }

  void solveQuestion(int index) {
    allData!.questions[index].isSolving = true;
    print('tttttttttttttttttttttttttttttttttttttttt');
  }

  List<ApplyMakeExam> details = [];

  ///
  ResponseOfMakeExamData? resultData;
  Future applyMakeExam({required BuildContext context}) async {
    emit(LoadingApplyMakeYourExam());
    // await MakeYourExam(
      
    // );
    final response =
        await api.applyMakeExam(lessonId: allData!.id, details: details);
    response.fold((l) => emit(ErrorApplyMakeYourExam()), (r) {
      resultData = r.data;
      questionColor();

      for (int i = 0; i < resultData!.examQuestions.questions.length; i++) {
        print(resultData!.examQuestions.questions[i].questionStatus);
        print('qsqssqsqsqsqsqsqssqsqsqsqsqsqsqsqsqsqsqsqssssssssssssq');
      }
      emit(LoadedApplyMakeYourExam());
    });
  }

  questionColor() {
    for (int i = 0; i < resultData!.examQuestions.questions.length; i++) {
      for (int j = 0;
          j < resultData!.examQuestions.questions[i].answers.length;
          j++) {
        if (resultData!.examQuestions.questions[i].answerUser ==
                resultData!.examQuestions.questions[i].answers[j].id &&
            resultData!.examQuestions.questions[i].answers[j].answerStatus ==
                'correct' &&
            resultData!.examQuestions.questions[i].questionType == 'choice') {
          resultData!.examQuestions.questions[i].questionStatus = true;
        }
      }
      emit(ChangeColorsOfMakeExamState());
    }
  }
}
