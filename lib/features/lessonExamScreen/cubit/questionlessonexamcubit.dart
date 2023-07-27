import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/models/applylessonexammodel.dart';
import '../../../core/models/questionmodel.dart';
import '../../../core/remote/service.dart';
import 'lessonexamstate.dart';

class QuestionsLessonExamCubit extends Cubit<QuestionsOfLessonExamState> {
  QuestionsLessonExamCubit(this.api) : super(InitLessonExam()) {}

  final ServiceApi api;
  QuestionDateModel? questionOfLessonData;
  getQuestionsOfLessonExam(
      {required int lessonId, required String exam_type}) async {
    emit(LoadingLessonExam());
    final response = await api.getQuestionsOfLessonExam(lessonId, exam_type);
    response.fold(
      (l) => emit(ErrorLessonExam()),
      (r) {
        questionOfLessonData = r.data;
        print('.........................');
        print(r.data);
        print('.........................');
        emit(LoadedLessonExam());
      },
    );
  }

  void solveQuestion(int index) {
    questionOfLessonData!.questions[index].isSolving = true;
  }

  ResponseOfApplyLessonExmamData? responseOfApplyLessonExmamData;
  applyLessonExam({
    required int lessonId,
    required String exam_type,
  }) async {
    emit(LoadingApplyLessonExam());
    final response = await api.applyLessonExam(
        lessonId: lessonId, exam_type: exam_type, details: details);
    response.fold(
      (l) => emit(ErrorApplyLessonExam()),
      (r) {
        print('.........................');

        responseOfApplyLessonExmamData = r.data;
        print('.........................');

        emit(LoadedApplyLessonExam());
      },
    );
  }

  List<ApplyStudentExam> details = [];
}
