import 'package:new_mazoon/core/models/videoModel.dart';

class VideoDataModel {
  VideoModel data;
  String message;
  int code;

  VideoDataModel({
    required this.data,
    required this.message,
    required this.code,
  });

  factory VideoDataModel.fromJson(Map<String, dynamic> json) => VideoDataModel(
        data: VideoModel.fromJson(json["data"]),
        message: json["message"],
        code: json["code"],
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
        "message": message,
        "code": code,
      };
}
