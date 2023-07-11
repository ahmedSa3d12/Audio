class VideoModel {
  int id;
  String name;
  String link;
  String rate;
  String favorite;
  int totalWatch;
  int totalLike;
  int likeActive;
  int viewActive;
 String video_minutes;
  DateTime createdAt;
  DateTime updatedAt;

  VideoModel({
    required this.id,
    required this.name,
    required this.link,
    required this.rate,
    required this.favorite,
    required this.totalWatch,
    required this.totalLike,
    required this.likeActive,
    required this.viewActive,
    required this.createdAt,
    required this.updatedAt,
    required this.video_minutes,
  });

  factory VideoModel.fromJson(Map<String, dynamic> json) => VideoModel(
    id: json["id"],
    name: json["name"],
    link: json["link"],
    rate: json["rate"],
    favorite: json["favorite"],
    totalWatch: json["total_watch"],
    totalLike: json["total_like"],
    likeActive: json["like_active"],
    viewActive: json["view_active"],
    video_minutes: json["video_minutes"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "link": link,
    "rate": rate,
    "favorite": favorite,
    "total_watch": totalWatch,
    "total_like": totalLike,
    "like_active": likeActive,
    "view_active": viewActive,
    "video_minutes":video_minutes,
    "created_at": "${createdAt.year.toString().padLeft(4, '0')}-${createdAt.month.toString().padLeft(2, '0')}-${createdAt.day.toString().padLeft(2, '0')}",
    "updated_at": "${updatedAt.year.toString().padLeft(4, '0')}-${updatedAt.month.toString().padLeft(2, '0')}-${updatedAt.day.toString().padLeft(2, '0')}",
  };
}
