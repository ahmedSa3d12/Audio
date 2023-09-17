import 'comment_data_model.dart';

class SingleCommentModel {
  CommentsModel data;
  String message;
  int code;

  SingleCommentModel({
    required this.data,
    required this.message,
    required this.code,
  });

  factory SingleCommentModel.fromJson(Map<String, dynamic> json) =>
      SingleCommentModel(
        data: CommentsModel.fromJson(json["data"] ?? null),
        message: json["message"],
        code: json["code"],
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
        "message": message,
        "code": code,
      };
}
