import 'dart:convert';

AllFavourite allFavouriteFromJson(String str) =>
    AllFavourite.fromJson(json.decode(str));

String allFavouriteToJson(AllFavourite data) => json.encode(data.toJson());

class AllFavourite {
  AllFavouriteData data;
  String message;
  int code;

  AllFavourite({
    required this.data,
    required this.message,
    required this.code,
  });

  factory AllFavourite.fromJson(Map<String, dynamic> json) => AllFavourite(
        data: AllFavouriteData.fromJson(json["data"]),
        message: json["message"],
        code: json["code"],
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
        "message": message,
        "code": code,
      };
}

class AllFavouriteData {
  List<AllVideoFavorite>? allVideoFavorites;
  List<AllExamFavorite>? allExamFavorites;

  AllFavouriteData({
    required this.allVideoFavorites,
    required this.allExamFavorites,
  });

  factory AllFavouriteData.fromJson(Map<String, dynamic> json) =>
      AllFavouriteData(
        allVideoFavorites: List<AllVideoFavorite>.from(
            json["all_video_favorites"]
                .map((x) => AllVideoFavorite.fromJson(x))),
        allExamFavorites: List<AllExamFavorite>.from(
            json["all_exam_favorites"].map((x) => AllExamFavorite.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "all_video_favorites":
            List<dynamic>.from(allVideoFavorites!.map((x) => x.toJson())),
        "all_exam_favorites":
            List<dynamic>.from(allExamFavorites!.map((x) => x.toJson())),
      };
}

class AllExamFavorite {
  int id;
  String image;
  int? numOfQuestions;
  String? answerPdfFile;
  String? answerVideoFile;
  String name;
  double progress;
  String ?pdfFileUpload;
  String type;
  String backgroundColor;
  int quizMinutes;
  String examType;
  int examId;

  AllExamFavorite({
    required this.id,
    required this.image,
    required this.numOfQuestions,
    required this.answerPdfFile,
    required this.answerVideoFile,
    required this.name,
    required this.pdfFileUpload,
    this.progress = 0,
    required this.type,
    required this.backgroundColor,
    required this.quizMinutes,
    required this.examType,
    required this.examId,
  });

  factory AllExamFavorite.fromJson(Map<String, dynamic> json) =>
      AllExamFavorite(
        id: json["id"],
        pdfFileUpload:json['pdf_file_upload'],
        image: json["image"],
        numOfQuestions: json["num_of_questions"],
        answerPdfFile: json["answer_pdf_file"],
        answerVideoFile: json["answer_video_file"],
        name: json["name"],
        type: json["type"],
        backgroundColor: json["background_color"],
        quizMinutes: json["quiz_minutes"],
        examType: json["exam_type"],
        examId: json["exam_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
    'pdf_file_upload':pdfFileUpload,
        "image": image,
        "num_of_questions": numOfQuestions,
        "answer_pdf_file": answerPdfFile,
        "answer_video_file": answerVideoFile,
        "name": name,
        "type": type,
        "background_color": backgroundColor,
        "quiz_minutes": quizMinutes,
        "exam_type": examType,
        "exam_id": examId,
      };
}

class AllVideoFavorite {
  int id;
  int videoId;
  String image;
  String? time;
  String type;
  String? name;
  String path;

  AllVideoFavorite({
    required this.id,
    required this.videoId,
    required this.image,
    required this.time,
    required this.type,
    required this.name,
    required this.path,
  });

  factory AllVideoFavorite.fromJson(Map<String, dynamic> json) =>
      AllVideoFavorite(
        id: json["id"],
        videoId: json["video_id"],
        image: json["image"],
        time: json["time"],
        type: json["type"],
        name: json["name"],
        path: json["path"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "video_id": videoId,
        "image": image,
        "time": time,
        "type": type,
        "name": name,
        "path": path,
      };
}
