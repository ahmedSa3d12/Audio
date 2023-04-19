// To parse this JSON data, do
//
//     final startTripFinalReviewModel = startTripFinalReviewModelFromJson(jsonString);

import 'dart:convert';

import 'home_page_model.dart';

StartTripFinalReviewModel startTripFinalReviewModelFromJson(String str) => StartTripFinalReviewModel.fromJson(json.decode(str));

String startTripFinalReviewModelToJson(StartTripFinalReviewModel data) => json.encode(data.toJson());

class StartTripFinalReviewModel {
  StartTripFinalReviewModel({
    this.data,
    this.message,
    this.code,
  });

  final List<FinalReviewModel>? data;
  final String? message;
  final int? code;

  factory StartTripFinalReviewModel.fromJson(Map<String, dynamic> json) => StartTripFinalReviewModel(
    data: json["data"] == null ? [] : List<FinalReviewModel>.from(json["data"]!.map((x) => FinalReviewModel.fromJson(x))),
    message: json["message"],
    code: json["code"],
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "message": message,
    "code": code,
  };
}