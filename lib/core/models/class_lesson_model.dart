// To parse this JSON data, do
//
//     final classLessonModel = classLessonModelFromJson(jsonString);

import 'dart:convert';

import 'package:new_mazoon/core/models/class_data.dart';

ClassLessonModel classLessonModelFromJson(String str) =>
    ClassLessonModel.fromJson(json.decode(str));

String classLessonModelToJson(ClassLessonModel data) =>
    json.encode(data.toJson());

class ClassLessonModel {
  ClassLessonModel({
    this.data,
    this.message,
    this.code,
  });

  final List<AllClasses>? data;
  final String? message;
  final int? code;

  factory ClassLessonModel.fromJson(Map<String, dynamic> json) =>
      ClassLessonModel(
        data: json["data"] == null
            ? []
            : List<AllClasses>.from(json["data"]!.map(
                (x) => AllClasses.fromJson(x),
              )),
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
