class StudentReportsModel {
  List<StudentReports> data;
  String message;
  int code;

  StudentReportsModel({
    required this.data,
    required this.message,
    required this.code,
  });

  factory StudentReportsModel.fromJson(Map<String, dynamic> json) => StudentReportsModel(
    data: List<StudentReports>.from(json["data"].map((x) => StudentReports.fromJson(x))),
    message: json["message"],
    code: json["code"],
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "message": message,
    "code": code,
  };
}

class StudentReports {
  int id;
  String type;
  String report;
  String title;
  String createdAt;
  String updatedAt;

  StudentReports({
    required this.id,
    required this.type,
    required this.report,
    required this.title,
    required this.createdAt,
    required this.updatedAt,
  });

  factory StudentReports.fromJson(Map<String, dynamic> json) => StudentReports(
    id: json["id"],
    type: json["type"],
    report: json["report"],
    title: json["title"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "type": type,
    "report": report,
    "title": title,
    "created_at": createdAt,
    "updated_at": updatedAt,
  };
}
