class HeroExamModel {
  HeroExamModelData? data;
  String message;
  int code;

  HeroExamModel({
    required this.data,
    required this.message,
    required this.code,
  });

  factory HeroExamModel.fromJson(Map<String, dynamic> json) => HeroExamModel(
        data: json["data"] == null
            ? null
            : HeroExamModelData.fromJson(json["data"]),
        message: json["message"],
        code: json["code"],
      );

  Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
        "message": message,
        "code": code,
      };
}

class HeroExamModelData {
  CurrentMonthModel? day;
  CurrentMonthModel? week;
  CurrentMonthModel? currentMonth;
  CurrentMonthModel? lastMonth;
  List<CurrentMonthModel>? dayHeroes;
  List<CurrentMonthModel>? weekHeroes;
  List<CurrentMonthModel>? currentMonthHeroes;
  List<CurrentMonthModel>? lastMonthHeroes;

  HeroExamModelData({
    required this.day,
    required this.week,
    required this.currentMonth,
    required this.lastMonth,
    required this.dayHeroes,
    required this.weekHeroes,
    required this.currentMonthHeroes,
    required this.lastMonthHeroes,
  });
  factory HeroExamModelData.fromJson(Map<String, dynamic> json) =>
      HeroExamModelData(
        day: json["day"] == null
            ? null
            : CurrentMonthModel.fromJson(json["day"]),
        week: json["week"] == null
            ? null
            : CurrentMonthModel.fromJson(json["week"]),
        currentMonth: json["current_month"] == null
            ? null
            : CurrentMonthModel.fromJson(json["current_month"]),
        lastMonth: json["last_month"] == null
            ? null
            : CurrentMonthModel.fromJson(json["last_month"]),
        dayHeroes: json["day_heroes"] == null
            ? null
            : List<CurrentMonthModel>.from(
                json["day_heroes"].map((x) => CurrentMonthModel.fromJson(x))),
        weekHeroes: json["week_heroes"] == null
            ? null
            : List<CurrentMonthModel>.from(
                json["week_heroes"].map((x) => CurrentMonthModel.fromJson(x))),
        currentMonthHeroes: json["current_month_heroes"] == null
            ? null
            : List<CurrentMonthModel>.from(json["current_month_heroes"]
                .map((x) => CurrentMonthModel.fromJson(x))),
        lastMonthHeroes: json["last_month_heroes"] == null
            ? null
            : List<CurrentMonthModel>.from(json["last_month_heroes"]
                .map((x) => CurrentMonthModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "day": day!.toJson(),
        "week": week!.toJson(),
        "current_month": currentMonth!.toJson(),
        "last_month": lastMonth!.toJson(),
        "day_heroes": List<dynamic>.from(dayHeroes!.map((x) => x.toJson())),
        "week_heroes": List<dynamic>.from(weekHeroes!.map((x) => x.toJson())),
        "current_month_heroes":
            List<dynamic>.from(currentMonthHeroes!.map((x) => x.toJson())),
        "last_month_heroes": List<dynamic>.from(lastMonthHeroes!.map((x) => x)),
      };
}

class CurrentMonthModel {
  int id;
  String name;
  String country;
  int ordered;
  int studentTotalDegrees;
  int examsTotalDegree;
  String image;

  CurrentMonthModel({
    required this.id,
    required this.name,
    required this.country,
    required this.ordered,
    required this.studentTotalDegrees,
    required this.examsTotalDegree,
    required this.image,
  });

  factory CurrentMonthModel.fromJson(Map<String, dynamic> json) =>
      CurrentMonthModel(
        id: json["id"],
        name: json["name"],
        country: json["country"]!,
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
