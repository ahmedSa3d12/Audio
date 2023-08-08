class AddNewTryExam {
  dynamic data;
  String message;
  int code;

  AddNewTryExam({
    this.data,
    required this.message,
    required this.code,
  });

  factory AddNewTryExam.fromJson(Map<String, dynamic> json) => AddNewTryExam(
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
