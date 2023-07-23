import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_mazoon/features/attachment/cubit/attachmentstate.dart';

import '../../../core/models/audiolessonmodel.dart';
import '../../../core/models/examlessonmodel.dart';
import '../../../core/models/lessonexammodel.dart';
import '../../../core/remote/service.dart';

class AttachmentCubit extends Cubit<AttachmentState> {
  AttachmentCubit(this.api) : super(InitAttchmentState());
  final ServiceApi api;

  List<LessonAudioData> audioLessonData = [];

  audioOfLessonData(int lessonId) async {
    emit(LoadingAudioAttchmentState());
    final response = await api.audioOfLessonData(lessonId);
    response.fold(
      (l) => emit(ErrorAudioAttchmentState()),
      (r) {
        audioLessonData = r.data;
        emit(SucessAudioAttchmentState());
      },
    );
  }

  List<LessonAudioData> pdfLessonData = [];

  pdfOfLessonData(int lessonId) async {
    emit(LoadingPdfAttchmentState());
    final response = await api.pdfOfLessonData(lessonId);
    response.fold(
      (l) => emit(ErrorPdfAttchmentState()),
      (r) {
        pdfLessonData = r.data;
        emit(SucessPdfAttchmentState());
      },
    );
  }

  late LessonExamData2 homeworkLessonData;

  homeworkOfLessonData(int lessonId) async {
    emit(LoadingHomeworkttchmentState());
    final response = await api.homeworkOfLessonData(lessonId);
    response.fold(
      (l) => emit(ErrorHomeworkAttchmentState()),
      (r) {
        homeworkLessonData = r.data;
        emit(SucessHomeworkAttchmentState());
      },
    );
  }
}
