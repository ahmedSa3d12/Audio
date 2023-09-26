import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_mazoon/core/utils/dialogs.dart';
import 'package:new_mazoon/features/attachment/cubit/attachmentstate.dart';

import '../../../core/models/audiolessonmodel.dart';
import '../../../core/models/examlessonmodel.dart';
import '../../../core/models/rate_your_self.dart';
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

  LessonExamData2? homeworkLessonData;

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

  ///rete yourself
  ///
  RateYourselfModelData? rateYourselfModelData;
  rateYourselfLessonExam(int lessonId) async {
    emit(LoadingRateYourselfttchmentState());
    final response = await api.rateYourSelfLessonExam(lessonId: lessonId);
    response.fold(
      (l) => emit(ErrorRateYourselfAttchmentState()),
      (r) {
        rateYourselfModelData = r.data;
        questionColor();
        emit(SucessRateYourselfAttchmentState());
      },
    );
  }

  questionColor() {
    for (int i = 0;
        i < rateYourselfModelData!.examQuestions.questions.length;
        i++) {
      for (int j = 0;
          j < rateYourselfModelData!.examQuestions.questions[i].answers.length;
          j++) {
        if (rateYourselfModelData!.examQuestions.questions[i].answers[j].id ==
                rateYourselfModelData!.examQuestions.questions[i].answerUser &&
            rateYourselfModelData!
                    .examQuestions.questions[i].answers[j].answerStatus ==
                'correct' &&
            rateYourselfModelData!.examQuestions.questions[i].questionType ==
                'choice') {
          rateYourselfModelData!.examQuestions.questions[i].questionStatus =
              true;
        }
      }
      emit(TruequestionStatusRateYourselfAttchmentState());
    }
  }
  ////add homework to fav

  favourite(String type, String action, int lessonId) async {
    final response = await api.addToFavouriteExam(
      action: action,
      video_id: lessonId,
      type: type,
    );
    response.fold(
      (l) => emit(ErrorAddHomeWorkToFavorite()),
      (r) {
        homeworkLessonData!.examsFavorite == "un_favorite"
            ? homeworkLessonData!.examsFavorite = "favorite"
            : homeworkLessonData!.examsFavorite = "un_favorite";
        successGetBar(r.message);
        emit(LoadedAddHomeWorkToFavorite());
      },
    );
  }
}
