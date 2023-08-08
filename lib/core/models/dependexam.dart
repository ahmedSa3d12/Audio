class AppendLessonExam {
  dynamic data;
  String message;
  int code;

  AppendLessonExam({
    this.data,
    required this.message,
    required this.code,
  });

  factory AppendLessonExam.fromJson(Map<String, dynamic> json) =>
      AppendLessonExam(
        data: json["data"],
        message: json["message"],
        code: json["code"],
      );

  Map<String, dynamic> toJson() => {
        "data": data,
        "message": message,
        "code": code,
      };
}
