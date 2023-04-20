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
  ClassesExamDatumModel({
    required this.id,
    required this.name,
    required this.type,
    this.pdfExamUpload,
    this.answerPdfFile,
    this.answerVideoFile,
    required this.numOfQuestion,
    required this.totalTime,
  });

  int id;
  String name;
  String type;
  String? pdfExamUpload;
  String? answerPdfFile;
  String? answerVideoFile;
  int numOfQuestion;
  int totalTime;

  factory ClassesExamDatumModel.fromJson(Map<String, dynamic> json) => ClassesExamDatumModel(
    id: json["id"],
    name: json["name"],
    type: json["type"],
    pdfExamUpload: json["pdf_exam_upload"],
    answerPdfFile: json["answer_pdf_file"],
    answerVideoFile: json["answer_video_file"],
    numOfQuestion: json["num_of_question"],
    totalTime: json["total_time"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "type": type,
    "pdf_exam_upload": pdfExamUpload,
    "answer_pdf_file": answerPdfFile,
    "answer_video_file": answerVideoFile,
    "num_of_question": numOfQuestion,
    "total_time": totalTime,
  };
}
