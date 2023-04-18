import 'home_page_model.dart';

class AllClasses {
  AllClasses({
    this.id,
    this.status,
    this.image,
    this.backgroundColor,
    this.name,
    this.title,
    this.totalWatch,
    this.numOfLessons,
    this.numOfVideos,
    this.totalTimes,
    this.exams,
    this.createdAt,
    this.updatedAt,
  });

  final int? id;
  final String? status;
  final String? image;
  final String? backgroundColor;
  final String? name;
  final String? title;
  final int? totalWatch;
  final int? numOfLessons;
  final int? numOfVideos;
  final int? totalTimes;
  final List<AllExams>? exams;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory AllClasses.fromJson(Map<String, dynamic> json) => AllClasses(
    id: json["id"],
    status: json["status"],
    image: json["image"],
    backgroundColor: json["background_color"],
    name: json["name"],
    title: json["title"],
    totalWatch: json["total_watch"],
    numOfLessons: json["num_of_lessons"],
    numOfVideos: json["num_of_videos"],
    totalTimes: json["total_times"],
    exams: json["exams"] == null
        ? []
        : List<AllExams>.from(
        json["exams"]!.map((x) => AllExams.fromJson(x))),
    createdAt: json["created_at"] == null
        ? null
        : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null
        ? null
        : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "status": status,
    "image": image,
    "background_color": backgroundColor,
    "name": name,
    "title": title,
    "total_watch": totalWatch,
    "num_of_lessons": numOfLessons,
    "num_of_videos": numOfVideos,
    "total_times": totalTimes,
    "exams": exams == null
        ? []
        : List<dynamic>.from(exams!.map((x) => x.toJson())),
    "created_at":
    "${createdAt!.year.toString().padLeft(4, '0')}-${createdAt!.month.toString().padLeft(2, '0')}-${createdAt!.day.toString().padLeft(2, '0')}",
    "updated_at":
    "${updatedAt!.year.toString().padLeft(4, '0')}-${updatedAt!.month.toString().padLeft(2, '0')}-${updatedAt!.day.toString().padLeft(2, '0')}",
  };
}
