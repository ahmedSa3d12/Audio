// To parse this JSON data, do
//
//     final classesExamDataModel = classesExamDataModelFromJson(jsonString);

import 'dart:convert';

ClassesExamDataModel classesExamDataModelFromJson(String str) => ClassesExamDataModel.fromJson(json.decode(str));

String classesExamDataModelToJson(ClassesExamDataModel data) => json.encode(data.toJson());

class ClassesExamDataModel {
  ClassesExamDataModel({
    required this.data,
    required this.message,
    required this.code,
  });

  List<ClassesExamDatumModel> data;
  String message;
  int code;

  factory ClassesExamDataModel.fromJson(Map<String, dynamic> json) => ClassesExamDataModel(
    data: List<ClassesExamDatumModel>.from(json["data"].map((x) => ClassesExamDatumModel.fromJson(x))),
    message: json["message"],
    code: json["code"],
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "message": message,
    "code": code,
  };
}

class ClassesExamDatumModel {
  final int? id;
  final String? name;
  final String? type;
  final String? backgroundColor;
  final String? examsFavorite;
  final dynamic pdfExamUpload;
  final dynamic answerPdfFile;
  final dynamic answerVideoFile;
  final int? numOfQuestion;
  final int? totalTime;
  final int? examPdfSize;
  final int? answerPdfSize;
  final int? answerVideoSize;

  ClassesExamDatumModel({
    this.id,
    this.name,
    this.type,
    this.backgroundColor,
    this.examsFavorite,
    this.pdfExamUpload,
    this.answerPdfFile,
    this.answerVideoFile,
    this.numOfQuestion,
    this.totalTime,
    this.examPdfSize,
    this.answerPdfSize,
    this.answerVideoSize,
  });

  factory ClassesExamDatumModel.fromJson(Map<String, dynamic> json) => ClassesExamDatumModel(
    id: json["id"],
    name: json["name"],
    type: json["type"],
    backgroundColor: json["background_color"],
    examsFavorite: json["exams_favorite"],
    pdfExamUpload: json["pdf_exam_upload"],
    answerPdfFile: json["answer_pdf_file"],
    answerVideoFile: json["answer_video_file"],
    numOfQuestion: json["num_of_question"],
    totalTime: json["total_time"],
    examPdfSize: json["exam_pdf_size"],
    answerPdfSize: json["answer_pdf_size"],
    answerVideoSize: json["answer_video_size"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "type": type,
    "background_color": backgroundColor,
    "exams_favorite": examsFavorite,
    "pdf_exam_upload": pdfExamUpload,
    "answer_pdf_file": answerPdfFile,
    "answer_video_file": answerVideoFile,
    "num_of_question": numOfQuestion,
    "total_time": totalTime,
    "exam_pdf_size": examPdfSize,
    "answer_pdf_size": answerPdfSize,
    "answer_video_size": answerVideoSize,
  };
}
