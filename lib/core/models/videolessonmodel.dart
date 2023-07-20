class VideosofLessonModel {
  List<VideoLessonData> data;
  String message;
  int code;

  VideosofLessonModel({
    required this.data,
    required this.message,
    required this.code,
  });

  factory VideosofLessonModel.fromJson(Map<String, dynamic> json) =>
      VideosofLessonModel(
        data: List<VideoLessonData>.from(
            json["data"].map((x) => VideoLessonData.fromJson(x))),
        message: json["message"],
        code: json["code"],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "message": message,
        "code": code,
      };
}

class VideoLessonData {
  int id;
  String name;
  String status;
  String subscribe;
  dynamic progress;
  String link;
  int time;
  String rate;
  int totalWatch;
  int totalLike;
  int likeActive;
  String videoMinutes;
  int viewActive;
  DateTime createdAt;
  DateTime updatedAt;

  VideoLessonData({
    required this.id,
    required this.name,
    required this.status,
    required this.subscribe,
    required this.progress,
    required this.link,
    required this.time,
    required this.rate,
    required this.totalWatch,
    required this.totalLike,
    required this.likeActive,
    required this.videoMinutes,
    required this.viewActive,
    required this.createdAt,
    required this.updatedAt,
  });

  factory VideoLessonData.fromJson(Map<String, dynamic> json) =>
      VideoLessonData(
        id: json["id"],
        name: json["name"],
        status: json["status"],
        subscribe: json["subscribe"],
        progress: json["progress"],
        link: json["link"],
        time: json["time"],
        rate: json["rate"],
        totalWatch: json["total_watch"],
        totalLike: json["total_like"],
        likeActive: json["like_active"],
        videoMinutes: json["video_minutes"],
        viewActive: json["view_active"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "status": status,
        "subscribe": subscribe,
        "progress": progress,
        "link": link,
        "time": time,
        "rate": rate,
        "total_watch": totalWatch,
        "total_like": totalLike,
        "like_active": likeActive,
        "video_minutes": videoMinutes,
        "view_active": viewActive,
        "created_at":
            "${createdAt.year.toString().padLeft(4, '0')}-${createdAt.month.toString().padLeft(2, '0')}-${createdAt.day.toString().padLeft(2, '0')}",
        "updated_at":
            "${updatedAt.year.toString().padLeft(4, '0')}-${updatedAt.month.toString().padLeft(2, '0')}-${updatedAt.day.toString().padLeft(2, '0')}",
      };
}
