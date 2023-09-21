
class TimeUpdate {
    TimeUpdateData data;
    String message;
    int code;

    TimeUpdate({
        required this.data,
        required this.message,
        required this.code,
    });

    factory TimeUpdate.fromJson(Map<String, dynamic> json) => TimeUpdate(
        data: TimeUpdateData.fromJson(json["data"]),
        message: json["message"],
        code: json["code"],
    );

    Map<String, dynamic> toJson() => {
        "data": data.toJson(),
        "message": message,
        "code": code,
    };
}

class TimeUpdateData {
    int id;
    String name;
    String link;
    int time;
    int size;
    VideoOpened videoOpened;
    DateTime createdAt;
    DateTime updatedAt;

    TimeUpdateData({
        required this.id,
        required this.name,
        required this.link,
        required this.time,
        required this.size,
        required this.videoOpened,
        required this.createdAt,
        required this.updatedAt,
    });

    factory TimeUpdateData.fromJson(Map<String, dynamic> json) => TimeUpdateData(
        id: json["id"],
        name: json["name"],
        link: json["link"],
        time: json["time"],
        size: json["size"],
        videoOpened: VideoOpened.fromJson(json["videoOpened"]),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "link": link,
        "time": time,
        "size": size,
        "videoOpened": videoOpened.toJson(),
        "created_at": "${createdAt.year.toString().padLeft(4, '0')}-${createdAt.month.toString().padLeft(2, '0')}-${createdAt.day.toString().padLeft(2, '0')}",
        "updated_at": "${updatedAt.year.toString().padLeft(4, '0')}-${updatedAt.month.toString().padLeft(2, '0')}-${updatedAt.day.toString().padLeft(2, '0')}",
    };
}

class VideoOpened {
    int id;
    dynamic minutes;
    String status;
    String type;
    String user;

    VideoOpened({
        required this.id,
        required this.minutes,
        required this.status,
        required this.type,
        required this.user,
    });

    factory VideoOpened.fromJson(Map<String, dynamic> json) => VideoOpened(
        id: json["id"],
        minutes: json["minutes"],
        status: json["status"],
        type: json["type"],
        user: json["user"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "minutes": minutes,
        "status": status,
        "type": type,
        "user": user,
    };
}
