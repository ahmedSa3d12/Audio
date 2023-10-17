import 'TimeModel.dart';

class PaperExam {
  String? nameOfExam;
  DateTime? dateExam;
  String? time;
  String? address;
  String? section;
  int id;
  String name;
  String description;
  String from;
  String to;
  List<Time> times;
  PaperExam(
      {this.nameOfExam,
      this.dateExam,
      this.time,
      this.address,
      this.section,
      required this.times,
      required this.id,
      required this.name,
      required this.from,
      required this.to,
      required this.description});

  factory PaperExam.fromJson(Map<String, dynamic> json) => PaperExam(
        nameOfExam: json["nameOfExam"] ?? '',
        dateExam:
            json["dateExam"] == null ? null : DateTime.parse(json["dateExam"]),
        time: json["time"] ?? '',
        address: json["address"] ?? '',
        section: json["section"] ?? '',
        times: json["times"] != null
            ? List<Time>.from(json["times"].map((x) => Time.fromJson(x)))
            : [],
        id: json["id"] ?? 0,
        name: json["name"] ?? '',
        from: json["from"] ?? '',
        to: json["to"] ?? '',
        description: json["description"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "nameOfExam": nameOfExam,
        "dateExam":
            "${dateExam!.year.toString().padLeft(4, '0')}-${dateExam!.month.toString().padLeft(2, '0')}-${dateExam!.day.toString().padLeft(2, '0')}",
        "time": time,
        "address": address,
        "section": section,
        "times": List<dynamic>.from(times.map((x) => x.toJson())),
        "id": id,
        "name": name,
        "from": from,
        "to": to,
        "description": description,
      };
}
