// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

class AddNewNoteModel {
  AddNewNoteModelData? data;
  String message;
  int code;

  AddNewNoteModel({
    required this.data,
    required this.message,
    required this.code,
  });

  factory AddNewNoteModel.fromJson(Map<String, dynamic> json) =>
      AddNewNoteModel(
        data: json["data"] == null
            ? null
            : AddNewNoteModelData.fromJson(json["data"]),
        message: json["message"],
        code: json["code"],
      );

  Map<String, dynamic> toJson() => {
        "data": data!.toJson(),
        "message": message,
        "code": code,
      };
}

class AddNewNoteModelData {
  int id;
  String day;
  String title;
  String note;
  DateTime date;
  DateTime createdAt;
  DateTime updatedAt;

  AddNewNoteModelData({
    required this.id,
    required this.day,
    required this.title,
    required this.note,
    required this.date,
    required this.createdAt,
    required this.updatedAt,
  });

  factory AddNewNoteModelData.fromJson(Map<String, dynamic> json) =>
      AddNewNoteModelData(
        id: json["id"],
        day: json["day"],
        title: json["title"],
        note: json["note"],
        date: DateTime.parse(json["date"]),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "day": day,
        "title": title,
        "note": note,
        "date":
            "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "created_at":
            "${createdAt.year.toString().padLeft(4, '0')}-${createdAt.month.toString().padLeft(2, '0')}-${createdAt.day.toString().padLeft(2, '0')}",
        "updated_at":
            "${updatedAt.year.toString().padLeft(4, '0')}-${updatedAt.month.toString().padLeft(2, '0')}-${updatedAt.day.toString().padLeft(2, '0')}",
      };
}
