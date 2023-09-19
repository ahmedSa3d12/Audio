import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_mazoon/core/utils/toast_message_method.dart';

import '../../../config/routes/app_routes.dart';
import '../../../core/models/applylessonexammodel.dart';
import '../../../core/models/dependexam.dart';
import '../../../core/models/questionmodel.dart';
import '../../../core/remote/service.dart';
import 'lessonexamstate.dart';

class QuestionsLessonExamCubit extends Cubit<QuestionsOfLessonExamState> {
  QuestionsLessonExamCubit(this.api) : super(InitLessonExam()) {}

  final ServiceApi api;
  QuestionDateModel? questionOfLessonData;
  getQuestionsOfLessonExam(
      {required int lessonId,
      required BuildContext context,
      required String exam_type}) async {
    emit(LoadingLessonExam());
    final response = await api.getQuestionsOfLessonExam(lessonId, exam_type);
    response.fold(
      (l) => emit(ErrorLessonExam()),
      (r) {
        if (r.code == 200) {
          questionOfLessonData = r.data;
          Navigator.pushNamed(
              arguments: {"exam_type": exam_type, "lessonId": lessonId},
              context,
              Routes.lessonExamScreen);
          emit(LoadedLessonExam());
        } else {
          toastMessage(r.message, context);
        }
        emit(LoadedLessonExam());
      },
    );
  }

  void solveQuestion(int index) {
    questionOfLessonData!.questions[index].isSolving = true;
  }

  ResponseOfApplyLessonExmamData? responseOfApplyLessonExmamData;
  applyLessonExam(
      {required int lessonId,
      required String exam_type,
      required int minutesLeft,
      required BuildContext context}) async {
//////////////////////

    ////////////////////
    emit(LoadingApplyLessonExam());
    setDetailsList(minutesLeft);
    final response = await api.applyLessonExam(
        lessonId: lessonId, exam_type: exam_type, details: details);
    response.fold(
      (l) => emit(ErrorApplyLessonExam()),
      (r) {
        if (r.code == 200) {
          responseOfApplyLessonExmamData = r.data;
          Navigator.pushReplacementNamed(
              context, arguments: r.data, Routes.resultOfLessonExam);
          details.clear();
        } else if (r.code == 416) {
          toastMessage(r.message, context);
        } else {
          toastMessage(r.message, context);
        }

        emit(LoadedApplyLessonExam());
      },
    );
  }

//////////////fill List of details
  // setDetailsList(int minutesLeft) {
  //   if (questionOfLessonData!.questions.length == details.length) {
  //     print('all added');
  //   } else {
  //     int missingDetailsCount =
  //         questionOfLessonData!.questions.length - details.length;
  //     if (missingDetailsCount > 0) {}
  //     for (int i = 0; i < questionOfLessonData!.questions.length; i++) {
  //       for (int j = 0; j < details.length; j++) {
  //         if (questionOfLessonData!.questions[i].id ==
  //             int.parse(details[j].question)) {
  //           print('skip ${details[j].question}');
  //           continue;
  //         } else {
  //           print('---------------------added item $j-----------');
  //           addUniqueApplyMakeExam(ApplyStudentExam(
  //               timer: (questionOfLessonData!.quizMinute - minutesLeft),
  //               answer: '',
  //               question: questionOfLessonData!.questions[i].id.toString()));
  //         }
  //       }
  //     }
  //   }
  // }
  setDetailsList(int minutesLeft) {
    for (int i = 0; i < questionOfLessonData!.questions.length; i++) {
      bool questionExistsInDetails = details.any((detail) =>
          int.parse(detail.question) == questionOfLessonData!.questions[i].id);
      if (!questionExistsInDetails) {
        addUniqueApplyMakeExam(ApplyStudentExam(
            timer: (questionOfLessonData!.quizMinute - minutesLeft),
            answer: '',
            question: questionOfLessonData!.questions[i].id.toString()));
      }
    }
  }

  List<ApplyStudentExam> details = [];
  addUniqueApplyMakeExam(ApplyStudentExam exam) {
    int isfound = -1;
    if (details.isEmpty) {
      details.add(exam);
    } else {
      for (int i = 0; i < details.length; i++) {
        if (details[i].question == exam.question &&
            details[i].answer != exam.answer) {
          details[i] = exam;
        } else {}
        if (details[i].question == exam.question) {
          isfound = i;
          return;
        }
      }
      if (isfound != -1) {
        details.removeAt(isfound);
      }
      details.add(exam);
    }
  }

  ///
  ///
  AppendLessonExam? appendLessonExam;

  appendDegreeLessonExam(
      {required int lessonId,
      required BuildContext context,
      required String exam_type}) async {
    emit(LoadingAppendLessonExam());

    final response = await api.appendDegreeLessonExam(
        lessonId: lessonId, exam_type: exam_type);

    response.fold((l) => emit(ErrorAppendLessonExam()), (r) {
      toastMessage(r.message, context);

      Navigator.pushReplacementNamed(context, Routes.myGradeAndRating);
//nav
      emit(LoadedAppendLessonExam());
    });
  }

  //try if more 30

  tryAtEndOfExam(
      {required int lessonId,
      required BuildContext context,
      required String type,
      required int time}) async {
    emit(LoadingAddNewtryExamLessonExam());

    final response =
        await api.tryAtEndOfExam(lessonId: lessonId, time: time, type: type);
    response.fold((l) => emit(ErrorAddNewtryExamLessonExam()), (r) {
      toastMessage(r.message, context);
//nav
      emit(LoadedAddNewtryExamLessonExam());
    });
  }
}
