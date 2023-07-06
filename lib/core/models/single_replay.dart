import 'comment_data_model.dart';

class SingleReplayModel {
  Reply data;
  String message;
  int code;

  SingleReplayModel({
    required this.data,
    required this.message,
    required this.code,
  });

  factory SingleReplayModel.fromJson(Map<String, dynamic> json) => SingleReplayModel(
    data: Reply.fromJson(json["data"]),
    message: json["message"],
    code: json["code"],
  );

  Map<String, dynamic> toJson() => {
    "data": data.toJson(),
    "message": message,
    "code": code,
  };
}