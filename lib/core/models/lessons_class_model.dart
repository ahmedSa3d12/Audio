// To parse this JSON data, do
//
//     final lessonsClassModel = lessonsClassModelFromJson(jsonString);

import 'dart:convert';

import 'class_data.dart';
import 'lessons_model.dart';

LessonsClassModel lessonsClassModelFromJson(String str) =>
    LessonsClassModel.fromJson(json.decode(str));

String lessonsClassModelToJson(LessonsClassModel data) =>
    json.encode(data.toJson());

class LessonsClassModel {
  LessonsClassModel({
    this.data,
    this.code,
    this.message,
  });

  final LessonsClassData? data;
  final int? code;
  final String? message;

  factory LessonsClassModel.fromJson(Map<String, dynamic> json) =>
      LessonsClassModel(
        data: json["data"] == null
            ? null
            : LessonsClassData.fromJson(json["data"]),
        code: json["code"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
        "code": code,
        "message": message,
      };
}

class LessonsClassData {
  LessonsClassData({
    this.dataClass,
    this.lessons,
  });

  final AllClasses? dataClass;
  final List<AllLessonsModel>? lessons;

  factory LessonsClassData.fromJson(Map<String, dynamic> json) =>
      LessonsClassData(
        dataClass:
            json["class"] == null ? null : AllClasses.fromJson(json["class"]),
        lessons: json["lessons"] == null
            ? []
            : List<AllLessonsModel>.from(
                json["lessons"]!.map((x) => AllLessonsModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "class": dataClass?.toJson(),
        "lessons": lessons == null
            ? []
            : List<dynamic>.from(lessons!.map((x) => x.toJson())),
      };
}
