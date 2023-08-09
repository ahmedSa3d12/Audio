class GradeAndRateModel {
  List<GradeAndRateModelData> data;
  String message;
  int code;

  GradeAndRateModel({
    required this.data,
    required this.message,
    required this.code,
  });

  factory GradeAndRateModel.fromJson(Map<String, dynamic> json) =>
      GradeAndRateModel(
        data: List<GradeAndRateModelData>.from(
            json["data"].map((x) => GradeAndRateModelData.fromJson(x))),
        message: json["message"],
        code: json["code"],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "message": message,
        "code": code,
      };
}

class GradeAndRateModelData {
  int id;
  String name;
  String backgroundColor;
  double percentage;
  String degree;

  GradeAndRateModelData({
    required this.id,
    required this.name,
    required this.backgroundColor,
    required this.percentage,
    required this.degree,
  });

  factory GradeAndRateModelData.fromJson(Map<String, dynamic> json) =>
      GradeAndRateModelData(
        id: json["id"],
        name: json["name"],
        backgroundColor: json["background_color"],
        percentage: json["percentage"],
        degree: json["degree"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "background_color": backgroundColor,
        "percentage": percentage,
        "degree": degree,
      };
}
