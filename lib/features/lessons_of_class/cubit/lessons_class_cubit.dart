import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_mazoon/core/models/class_data.dart';
import 'package:new_mazoon/core/remote/service.dart';
import 'package:path_provider/path_provider.dart';

import '../../../core/models/lessonexammodel.dart';
import '../../../core/models/lessons_model.dart';
import '../../../core/models/videolessonmodel.dart';
import '../../../core/utils/toast_message_method.dart';
import '../../examdegreeaccreditation/cubit/examdegreedependcubit.dart';

part 'lessons_class_state.dart';

class LessonsClassCubit extends Cubit<LessonsClassState> {
  LessonsClassCubit(this.api) : super(LessonsClassInitial());

  final ServiceApi api;

  List<AllLessonsModel> lessons = [];
  AllClasses? oneClass;

  getLessonsClassData(int id, int? lessonId, BuildContext context, bool isGrade,
      bool isLesson, bool isClass) async {
    emit(LessonsClassLoading());

    await api.lessonsByClassData(id).then((value) {
      value.fold(
        (l) => emit(LessonsClassError()),
        (r) {
          lessons = r.data!.lessons!;
          oneClass = r.data!.dataClass!;
          emit(LessonsClassLoaded());
        },
      );
      if (isGrade) {
        if (isLesson) {
          context.read<ExamDegreeAccreditationCubit>().setlesson();
          emit(LessonsClassLoaded());
        } else if (isClass) {
          context
              .read<ExamDegreeAccreditationCubit>()
              .classesExamGradeAndRate(classId: id);
        } else {
          context.read<ExamDegreeAccreditationCubit>().setHomeGrade();
          emit(LessonsClassLoaded());
        }
        emit(LessonsClassError());
      }
    }).onError((error, stackTrace) {
      toastMessage(error.toString(), context);
      emit(LessonsClassError());
    });
  }

  int currentIndex = 0;

  selectTap(int index) {
    currentIndex = index;
    emit(ChangeCurrentIndexTap());
  }

  List<VideoLessonData> videosofLessons = [];

  getVideosofLessonsData(int lessonId) async {
    emit(VideoLessonsLoading());
    final response = await api.videosOfLessonData(lessonId);
    response.fold(
      (l) => emit(VideoLessonsError()),
      (r) {
        videosofLessons = r.data;
        emit(VideoLessonsLoaded());
      },
    );
  }

  ///need handle
  List<LessonExamData> examsofLessons = [];

  getExamsofLessonsData(int lessonId) async {
    emit(ExamLessonsLoading());
    final response = await api.examOfLessonData(lessonId);
    response.fold(
      (l) => emit(ExamLessonsError()),
      (r) {
        examsofLessons = r.data;
        emit(ExamLessonsLoaded());
      },
    );
  }

  downloadPdfOfLesson(LessonExamData model) async {
    final dio = Dio();
    int index = examsofLessons.indexOf(model);

    var dir = await (Platform.isIOS
        ? getApplicationSupportDirectory()
        : getApplicationDocumentsDirectory());
    await dio.download(
      model.pdfExamUpload,
      dir.path + "/pdf/" + model.pdfExamUpload.split("/").toList().last,
      onReceiveProgress: (count, total) {
        model.progress = (count / total);
        examsofLessons.removeAt(index);
        examsofLessons.insert(index, model);
        emit(LessonExamClassesLoaded());
      },
    ).whenComplete(
      () {
        model.progress = 0;
        examsofLessons.removeAt(index);
        examsofLessons.insert(index, model);
        emit(LessonExamClassesLoaded());
      },
    );
  }
}
