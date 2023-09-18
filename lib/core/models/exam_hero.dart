class ExamHerosModel {
  ExamHerosModelData data;
  String message;
  int code;

  ExamHerosModel({
    required this.data,
    required this.message,
    required this.code,
  });

  factory ExamHerosModel.fromJson(Map<String, dynamic> json) => ExamHerosModel(
        data: ExamHerosModelData.fromJson(json["data"] ?? null),
        message: json["message"],
        code: json["code"],
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
        "message": message,
        "code": code,
      };
}

class ExamHerosModelData {
  ExamHerosModelAuth auth;
  List<ExamHerosModelAuth> dayHeroes;
  List<ExamHerosModelAuth> weekHeroes;
  List<ExamHerosModelAuth> currentMonthHeroes;
  List<ExamHerosModelAuth> lastMonthHeroes;

  ExamHerosModelData({
    required this.auth,
    required this.dayHeroes,
    required this.weekHeroes,
    required this.currentMonthHeroes,
    required this.lastMonthHeroes,
  });

  factory ExamHerosModelData.fromJson(Map<String, dynamic> json) =>
      ExamHerosModelData(
        auth: ExamHerosModelAuth.fromJson(json["auth"] ?? null),
        dayHeroes: List<ExamHerosModelAuth>.from(
            json["day_heroes"].map((x) => ExamHerosModelAuth.fromJson(x))),
        weekHeroes: List<ExamHerosModelAuth>.from(
            json["week_heroes"].map((x) => ExamHerosModelAuth.fromJson(x))),
        currentMonthHeroes: List<ExamHerosModelAuth>.from(
            json["current_month_heroes"]
                .map((x) => ExamHerosModelAuth.fromJson(x))),
        lastMonthHeroes: List<ExamHerosModelAuth>.from(json["last_month_heroes"]
            .map((x) => ExamHerosModelAuth.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "auth": auth.toJson(),
        "day_heroes": List<dynamic>.from(dayHeroes.map((x) => x)),
        "week_heroes": List<dynamic>.from(weekHeroes.map((x) => x)),
        "current_month_heroes":
            List<dynamic>.from(currentMonthHeroes.map((x) => x.toJson())),
        "last_month_heroes": List<dynamic>.from(lastMonthHeroes.map((x) => x)),
      };
}

class ExamHerosModelAuth {
  int id;
  String name;
  String country;
  int ordered;
  int studentTotalDegrees;
  int examsTotalDegree;
  String image;

  ExamHerosModelAuth({
    required this.id,
    required this.name,
    required this.country,
    required this.ordered,
    required this.studentTotalDegrees,
    required this.examsTotalDegree,
    required this.image,
  });

  factory ExamHerosModelAuth.fromJson(Map<String, dynamic> json) =>
      ExamHerosModelAuth(
        id: json["id"],
        name: json["name"],
        country: json["country"],
        ordered: json["ordered"],
        studentTotalDegrees: json["student_total_degrees"],
        examsTotalDegree: json["exams_total_degree"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "country": country,
        "ordered": ordered,
        "student_total_degrees": studentTotalDegrees,
        "exams_total_degree": examsTotalDegree,
        "image": image,
      };
}
