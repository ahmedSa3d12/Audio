class AllLessonsModel {
  AllLessonsModel({
    this.id,
    this.backgroundColor,
    this.title,
    this.name,
    this.note,
    this.status,
    this.numOfVideos,
    this.totalWatch,
    this.totalTimes,
    this.createdAt,
    this.updatedAt,
  });

  final int? id;
  final String? backgroundColor;
  final String? title;
  final String? name;
  final String? note;
  final String? status;
  final int? numOfVideos;
  final dynamic totalWatch;
  final dynamic totalTimes;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory AllLessonsModel.fromJson(Map<String, dynamic> json) =>
      AllLessonsModel(
        id: json["id"],
        backgroundColor: json["background_color"],
        title: json["title"],
        name: json["name"],
        note: json["note"],
        status: json["status"],
        numOfVideos: json["num_of_videos"],
        totalWatch: json["total_watch"],
        totalTimes: json["total_times"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "background_color": backgroundColor,
        "title": title,
        "name": name,
        "note": note,
        "status": status,
        "num_of_videos": numOfVideos,
        "total_watch": totalWatch,
        "total_times": totalTimes,
        "created_at":
            "${createdAt!.year.toString().padLeft(4, '0')}-${createdAt!.month.toString().padLeft(2, '0')}-${createdAt!.day.toString().padLeft(2, '0')}",
        "updated_at":
            "${updatedAt!.year.toString().padLeft(4, '0')}-${updatedAt!.month.toString().padLeft(2, '0')}-${updatedAt!.day.toString().padLeft(2, '0')}",
      };
}
