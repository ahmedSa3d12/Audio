
class DatesOfNotes {
  List<DatesOfNotesData> data;
  String message;
  int code;

  DatesOfNotes({
    required this.data,
    required this.message,
    required this.code,
  });

  factory DatesOfNotes.fromJson(Map<String, dynamic> json) => DatesOfNotes(
        data: List<DatesOfNotesData>.from(
            json["data"].map((x) => DatesOfNotesData.fromJson(x))),
        message: json["message"],
        code: json["code"],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "message": message,
        "code": code,
      };
}

class DatesOfNotesData {
  int id;
  DateTime date;

  DatesOfNotesData({
    required this.id,
    required this.date,
  });

  factory DatesOfNotesData.fromJson(Map<String, dynamic> json) =>
      DatesOfNotesData(
        id: json["id"],
        date: DateTime.parse(json["date"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "date":
            "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
      };
}
