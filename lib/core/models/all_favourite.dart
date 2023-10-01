// To parse this JSON data, do
//
//     final allFavourite = allFavouriteFromJson(jsonString);

import 'dart:convert';

import 'classes_exam_data_model.dart';

AllFavourite allFavouriteFromJson(String str) => AllFavourite.fromJson(json.decode(str));

String allFavouriteToJson(AllFavourite data) => json.encode(data.toJson());

class AllFavourite {
  final Data? data;
  final String? message;
  final int? code;

  AllFavourite({
    this.data,
    this.message,
    this.code,
  });

  factory AllFavourite.fromJson(Map<String, dynamic> json) => AllFavourite(
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
    message: json["message"],
    code: json["code"],
  );

  Map<String, dynamic> toJson() => {
    "data": data?.toJson(),
    "message": message,
    "code": code,
  };
}

class Data {
  final List<ClassesExamDatumModel>? onlineExams;//
  final List<dynamic>? allExams;
  final List<dynamic>? liveExams;
  final List<VideoBasic>? videoBasics;
  final List<VideoResource>? videoResources;//
  final List<VideoPart>? videoParts;

  Data({
    this.onlineExams,
    this.allExams,
    this.liveExams,
    this.videoBasics,
    this.videoResources,
    this.videoParts,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    onlineExams: json["online_exams"] == null ? [] : List<ClassesExamDatumModel>.from(json["online_exams"]!.map((x) => ClassesExamDatumModel.fromJson(x))),
    allExams: json["all_exams"] == null ? [] : List<dynamic>.from(json["all_exams"]!.map((x) => x)),
    liveExams: json["live_exams"] == null ? [] : List<dynamic>.from(json["live_exams"]!.map((x) => x)),
    videoBasics: json["video_basics"] == null ? [] : List<VideoBasic>.from(json["video_basics"]!.map((x) => VideoBasic.fromJson(x))),
    videoResources: json["video_resources"] == null ? [] : List<VideoResource>.from(json["video_resources"]!.map((x) => VideoResource.fromJson(x))),
    videoParts: json["video_parts"] == null ? [] : List<VideoPart>.from(json["video_parts"]!.map((x) => VideoPart.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "online_exams": onlineExams == null ? [] : List<dynamic>.from(onlineExams!.map((x) => x.toJson())),
    "all_exams": allExams == null ? [] : List<dynamic>.from(allExams!.map((x) => x)),
    "live_exams": liveExams == null ? [] : List<dynamic>.from(liveExams!.map((x) => x)),
    "video_basics": videoBasics == null ? [] : List<dynamic>.from(videoBasics!.map((x) => x.toJson())),
    "video_resources": videoResources == null ? [] : List<dynamic>.from(videoResources!.map((x) => x.toJson())),
    "video_parts": videoParts == null ? [] : List<dynamic>.from(videoParts!.map((x) => x.toJson())),
  };
}
//
// class OnlineExam {
//   final int? id;
//   final String? name;
//   final String? type;
//   final String? backgroundColor;
//   final String? examsFavorite;
//   final String? pdfExamUpload;
//   final String? answerPdfFile;
//   final String? answerVideoFile;
//   final int? numOfQuestion;
//   final int? totalTime;
//   final int? examPdfSize;
//   final int? answerPdfSize;
//   final int? answerVideoSize;
//
//   OnlineExam({
//     this.id,
//     this.name,
//     this.type,
//     this.backgroundColor,
//     this.examsFavorite,
//     this.pdfExamUpload,
//     this.answerPdfFile,
//     this.answerVideoFile,
//     this.numOfQuestion,
//     this.totalTime,
//     this.examPdfSize,
//     this.answerPdfSize,
//     this.answerVideoSize,
//   });
//
//   factory OnlineExam.fromJson(Map<String, dynamic> json) => OnlineExam(
//     id: json["id"],
//     name: json["name"],
//     type: json["type"],
//     backgroundColor: json["background_color"],
//     examsFavorite: json["exams_favorite"],
//     pdfExamUpload: json["pdf_exam_upload"],
//     answerPdfFile: json["answer_pdf_file"],
//     answerVideoFile: json["answer_video_file"],
//     numOfQuestion: json["num_of_question"],
//     totalTime: json["total_time"],
//     examPdfSize: json["exam_pdf_size"],
//     answerPdfSize: json["answer_pdf_size"],
//     answerVideoSize: json["answer_video_size"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "name": name,
//     "type": type,
//     "background_color": backgroundColor,
//     "exams_favorite": examsFavorite,
//     "pdf_exam_upload": pdfExamUpload,
//     "answer_pdf_file": answerPdfFile,
//     "answer_video_file": answerVideoFile,
//     "num_of_question": numOfQuestion,
//     "total_time": totalTime,
//     "exam_pdf_size": examPdfSize,
//     "answer_pdf_size": answerPdfSize,
//     "answer_video_size": answerVideoSize,
//   };
// }

class VideoBasic {
  final int? id;
  final String? name;
  final String? time;
  final int? size;
  final String? backgroundColor;
  final String? videoLink;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  VideoBasic({
    this.id,
    this.name,
    this.time,
    this.size,
    this.backgroundColor,
    this.videoLink,
    this.createdAt,
    this.updatedAt,
  });

  factory VideoBasic.fromJson(Map<String, dynamic> json) => VideoBasic(
    id: json["id"],
    name: json["name"],
    time: json["time"],
    size: json["size"],
    backgroundColor: json["background_color"],
    videoLink: json["video_link"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "time": time,
    "size": size,
    "background_color": backgroundColor,
    "video_link": videoLink,
    "created_at": "${createdAt!.year.toString().padLeft(4, '0')}-${createdAt!.month.toString().padLeft(2, '0')}-${createdAt!.day.toString().padLeft(2, '0')}",
    "updated_at": "${updatedAt!.year.toString().padLeft(4, '0')}-${updatedAt!.month.toString().padLeft(2, '0')}-${updatedAt!.day.toString().padLeft(2, '0')}",
  };
}

class VideoPart {
  final int? id;
  final String? name;
  final String? link;
  final int? time;
  final int? size;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  VideoPart({
    this.id,
    this.name,
    this.link,
    this.time,
    this.size,
    this.createdAt,
    this.updatedAt,
  });

  factory VideoPart.fromJson(Map<String, dynamic> json) => VideoPart(
    id: json["id"],
    name: json["name"],
    link: json["link"],
    time: json["time"],
    size: json["size"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "link": link,
    "time": time,
    "size": size,
    "created_at": "${createdAt!.year.toString().padLeft(4, '0')}-${createdAt!.month.toString().padLeft(2, '0')}-${createdAt!.day.toString().padLeft(2, '0')}",
    "updated_at": "${updatedAt!.year.toString().padLeft(4, '0')}-${updatedAt!.month.toString().padLeft(2, '0')}-${updatedAt!.day.toString().padLeft(2, '0')}",
  };
}

class VideoResource {
  final int? id;
  final String? name;
  final String? type;
  final String? backgroundColor;
  final String? image;
  final String? time;
  final String? pathFile;
  final int? size;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  VideoResource({
    this.id,
    this.name,
    this.type,
    this.backgroundColor,
    this.image,
    this.time,
    this.pathFile,
    this.size,
    this.createdAt,
    this.updatedAt,
  });

  factory VideoResource.fromJson(Map<String, dynamic> json) => VideoResource(
    id: json["id"],
    name: json["name"],
    type: json["type"],
    backgroundColor: json["background_color"],
    image: json["image"],
    time: json["time"],
    pathFile: json["path_file"],
    size: json["size"],
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
    "size": size,
    "created_at": "${createdAt!.year.toString().padLeft(4, '0')}-${createdAt!.month.toString().padLeft(2, '0')}-${createdAt!.day.toString().padLeft(2, '0')}",
    "updated_at": "${updatedAt!.year.toString().padLeft(4, '0')}-${updatedAt!.month.toString().padLeft(2, '0')}-${updatedAt!.day.toString().padLeft(2, '0')}",
  };
}
