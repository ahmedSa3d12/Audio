// To parse this JSON data, do
//
//     final homePageModel = homePageModelFromJson(jsonString);

import 'dart:convert';

import 'class_data.dart';


HomePageModel homePageModelFromJson(String str) =>
    HomePageModel.fromJson(json.decode(str));

String homePageModelToJson(HomePageModel data) => json.encode(data.toJson());

class HomePageModel {
  HomePageModel({
    this.data,
    this.code,
    this.message,
  });

  final HomePageData? data;
  final int? code;
  final String? message;

  factory HomePageModel.fromJson(Map<String, dynamic> json) => HomePageModel(
        data: json["data"] == null ? null : HomePageData.fromJson(json["data"]),
        code: json["code"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
        "code": code,
        "message": message,
      };
}

class HomePageData {
  HomePageData({
    this.lifeExam,
    this.sliders,
    this.videosBasics,
    this.classes,
    this.videosResources,
  });

  final dynamic lifeExam;
  final List<SliderModel>? sliders;
  final List<HomePageVideosModel>? videosBasics;
  final List<AllClasses>? classes;
  final List<FinalReviewModel>? videosResources;

  factory HomePageData.fromJson(Map<String, dynamic> json) => HomePageData(
        lifeExam: json["life_exam"],
        sliders: json["sliders"] == null
            ? []
            : List<SliderModel>.from(
                json["sliders"]!.map((x) => SliderModel.fromJson(x))),
        videosBasics: json["videos_basics"] == null
            ? []
            : List<HomePageVideosModel>.from(json["videos_basics"]!
                .map((x) => HomePageVideosModel.fromJson(x))),
        classes: json["classes"] == null
            ? []
            : List<AllClasses>.from(
                json["classes"]!.map((x) => AllClasses.fromJson(x))),
        videosResources: json["videos_resources"] == null
            ? []
            : List<FinalReviewModel>.from(json["videos_resources"]!
                .map((x) => FinalReviewModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "life_exam": lifeExam,
        "sliders": sliders == null
            ? []
            : List<dynamic>.from(sliders!.map((x) => x.toJson())),
        "videos_basics": videosBasics == null
            ? []
            : List<dynamic>.from(videosBasics!.map((x) => x.toJson())),
        "classes": classes == null
            ? []
            : List<dynamic>.from(classes!.map((x) => x.toJson())),
        "videos_resources": videosResources == null
            ? []
            : List<dynamic>.from(videosResources!.map((x) => x.toJson())),
      };
}

class SliderModel {
  SliderModel({
    this.id,
    this.file,
    this.type,
    this.link,
    this.createdAt,
    this.updatedAt,
  });

  final int? id;
  final String? file;
  final String? type;
  final String? link;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory SliderModel.fromJson(Map<String, dynamic> json) => SliderModel(
        id: json["id"],
        file: json["file"],
        type: json["type"],
        link: json["link"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "file": file,
        "type": type,
        "link": link,
        "created_at":
            "${createdAt!.year.toString().padLeft(4, '0')}-${createdAt!.month.toString().padLeft(2, '0')}-${createdAt!.day.toString().padLeft(2, '0')}",
        "updated_at":
            "${updatedAt!.year.toString().padLeft(4, '0')}-${updatedAt!.month.toString().padLeft(2, '0')}-${updatedAt!.day.toString().padLeft(2, '0')}",
      };
}

class HomePageVideosModel {
  HomePageVideosModel({
    this.id,
    this.name,
    this.time,
    this.videoLink,
    this.backgroundColor,
    this.createdAt,
    this.updatedAt,
  });

  final int? id;
  final String? name;
  final int? time;
  final String? backgroundColor;
  final String? videoLink;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory HomePageVideosModel.fromJson(Map<String, dynamic> json) =>
      HomePageVideosModel(
        id: json["id"],
        name: json["name"],
        time: json["time"],
        videoLink: json["video_link"],
        backgroundColor: json["background_color"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "time": time,
        "video_link": videoLink,
        "background_color": backgroundColor,
        "created_at":
            "${createdAt!.year.toString().padLeft(4, '0')}-${createdAt!.month.toString().padLeft(2, '0')}-${createdAt!.day.toString().padLeft(2, '0')}",
        "updated_at":
            "${updatedAt!.year.toString().padLeft(4, '0')}-${updatedAt!.month.toString().padLeft(2, '0')}-${updatedAt!.day.toString().padLeft(2, '0')}",
      };
}

class FinalReviewModel {
  FinalReviewModel({
    this.id,
    this.name,
    this.type,
    this.backgroundColor,
    this.image,
    this.time,
    this.pathFile,
    this.createdAt,
    this.updatedAt,
  });

  final int? id;
  final String? name;
  final String? type;
  final String? backgroundColor;
  final String? image;
  final int? time;
  final String? pathFile;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory FinalReviewModel.fromJson(Map<String, dynamic> json) => FinalReviewModel(
    id: json["id"],
    name: json["name"],
    type: json["type"],
    backgroundColor: json["background_color"],
    image: json["image"],
    time: json["time"],
    pathFile: json["path_file"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "type": type,
    "background_color": backgroundColor,
    "image": image,
    "time": time,
    "path_file": pathFile,
    "created_at": "${createdAt!.year.toString().padLeft(4, '0')}-${createdAt!.month.toString().padLeft(2, '0')}-${createdAt!.day.toString().padLeft(2, '0')}",
    "updated_at": "${updatedAt!.year.toString().padLeft(4, '0')}-${updatedAt!.month.toString().padLeft(2, '0')}-${updatedAt!.day.toString().padLeft(2, '0')}",
  };
}




class AllExams {
  AllExams({
    this.id,
    this.name,
    this.numOfQuestion,
    this.totalTime,
  });

  final int? id;
  final String? name;
  final int? numOfQuestion;
  final int? totalTime;

  factory AllExams.fromJson(Map<String, dynamic> json) => AllExams(
    id: json["id"],
    name: json["name"],
    numOfQuestion: json["num_of_question"],
    totalTime: json["total_time"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "num_of_question": numOfQuestion,
    "total_time": totalTime,
  };
}