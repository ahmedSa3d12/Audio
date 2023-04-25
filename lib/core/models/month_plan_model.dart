class MothPlanModel
{
  List<MothData>? data;
  String? message;
  int? code;

  MothPlanModel({this.data, this.message, this.code});

  MothPlanModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <MothData>[];
      json['data'].forEach((v) {
        data!.add(new MothData.fromJson(v));
      });
    }
    message = json['message'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    data['code'] = this.code;
    return data;
  }
}

class MothData {
  MothData({
    this.id,
    this.backgroundColor,
    this.date,
    this.title,
    this.description,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? backgroundColor;
  DateTime? date;
  String? title;
  String? description;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory MothData.fromJson(Map<String, dynamic> json) => MothData(
    id: json["id"],
    backgroundColor: json["background_color"],
    date: json["date"] == null ? null : DateTime.parse(json["date"]),
    title: json["title"],
    description: json["description"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "background_color": backgroundColor,
    "date": "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
    "title": title,
    "description": description,
    "created_at": "${createdAt!.year.toString().padLeft(4, '0')}-${createdAt!.month.toString().padLeft(2, '0')}-${createdAt!.day.toString().padLeft(2, '0')}",
    "updated_at": "${updatedAt!.year.toString().padLeft(4, '0')}-${updatedAt!.month.toString().padLeft(2, '0')}-${updatedAt!.day.toString().padLeft(2, '0')}",
  };
}

