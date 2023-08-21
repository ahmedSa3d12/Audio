// To parse this JSON data, do
//
//     final sourcesReferencesByIdModel = sourcesReferencesByIdModelFromJson(jsonString);

import 'dart:convert';

SourcesReferencesByIdModel sourcesReferencesByIdModelFromJson(String str) =>
    SourcesReferencesByIdModel.fromJson(json.decode(str));

String sourcesReferencesByIdModelToJson(SourcesReferencesByIdModel data) =>
    json.encode(data.toJson());

class SourcesReferencesByIdModel {
  final List<SourcesReferencesByIdDatum>? data;
  final String? message;
  final int? code;

  SourcesReferencesByIdModel({
    this.data,
    this.message,
    this.code,
  });

  factory SourcesReferencesByIdModel.fromJson(Map<String, dynamic> json) =>
      SourcesReferencesByIdModel(
        data: json["data"] == null
            ? []
            : List<SourcesReferencesByIdDatum>.from(json["data"]!
                .map((x) => SourcesReferencesByIdDatum.fromJson(x))),
        message: json["message"],
        code: json["code"],
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "message": message,
        "code": code,
      };
}

class SourcesReferencesByIdDatum {
  final int? id;
  final String? title;
  final String? filePath;
  final String? fileType;
  final String? fileTime;
  final String? filePathSize;
  final String? answerPdfFile;
  double progress = 0;
  final String? answerPdfFileSize;
  final String? answerVideoFile;
  final String? answerVideoFileTime;
  final DateTime? createdAt;

  SourcesReferencesByIdDatum({
    this.id,
    this.title,
    this.filePath,
    this.fileType,
    this.fileTime,
    this.filePathSize,
    this.answerPdfFile,
    this.answerPdfFileSize,
    this.answerVideoFile,
    this.answerVideoFileTime,
    this.createdAt,
  });

  factory SourcesReferencesByIdDatum.fromJson(Map<String, dynamic> json) =>
      SourcesReferencesByIdDatum(
        id: json["id"],
        title: json["title"],
        filePath: json["file_path"],
        fileType: json["file_type"],
        fileTime: json["file_time"],
        filePathSize: json["file_path_size"],
        answerPdfFile: json["answer_pdf_file"],
        answerPdfFileSize: json["answer_pdf_file_size"],
        answerVideoFile: json["answer_video_file"],
        answerVideoFileTime: json["answer_video_file_time"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "file_path": filePath,
        "file_type": fileType,
        "file_time": fileTime,
        "file_path_size": filePathSize,
        "answer_pdf_file": answerPdfFile,
        "answer_pdf_file_size": answerPdfFileSize,
        "answer_video_file": answerVideoFile,
        "answer_video_file_time": answerVideoFileTime,
        "created_at":
            "${createdAt!.year.toString().padLeft(4, '0')}-${createdAt!.month.toString().padLeft(2, '0')}-${createdAt!.day.toString().padLeft(2, '0')}",
      };
}
