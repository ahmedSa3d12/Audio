// To parse this JSON data, do
//
//     final sourcesReferencesModel = sourcesReferencesModelFromJson(jsonString);

import 'dart:convert';

SourcesReferencesModel sourcesReferencesModelFromJson(String str) =>
    SourcesReferencesModel.fromJson(json.decode(str));

String sourcesReferencesModelToJson(SourcesReferencesModel data) =>
    json.encode(data.toJson());

class SourcesReferencesModel {
  final List<SourcesReferencesDatum>? data;
  final String? message;
  final int? code;

  SourcesReferencesModel({
    this.data,
    this.message,
    this.code,
  });

  factory SourcesReferencesModel.fromJson(Map<String, dynamic> json) =>
      SourcesReferencesModel(
        data: json["data"] == null
            ? []
            : List<SourcesReferencesDatum>.from(
                json["data"]!.map((x) => SourcesReferencesDatum.fromJson(x))),
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

class SourcesReferencesDatum {
  final int? id;
  final String? title;
  final String? color;
  final String? filePath;
  final String? icon;
  final String? filePathSize;
  final String? description;
  final DateTime? createdAt;

  SourcesReferencesDatum({
    this.id,
    this.title,
    this.color,
    this.filePath,
    this.icon,
    this.filePathSize,
    this.description,
    this.createdAt,
  });

  factory SourcesReferencesDatum.fromJson(Map<String, dynamic> json) =>
      SourcesReferencesDatum(
        id: json["id"],
        title: json["title"],
        color: json["color"] ?? '#FF9201',
        filePath: json["file_path"],
        icon: json["icon"],
        filePathSize: json["file_path_size"],
        description: json["description"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "color": color,
        "file_path": filePath,
        "icon": icon,
        "file_path_size": filePathSize,
        "description": description,
        "created_at":
            "${createdAt!.year.toString().padLeft(4, '0')}-${createdAt!.month.toString().padLeft(2, '0')}-${createdAt!.day.toString().padLeft(2, '0')}",
      };
}
