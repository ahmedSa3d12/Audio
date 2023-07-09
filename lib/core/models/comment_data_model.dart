class CommentsDataModel {
  Comments comments;
  String message;
  int code;

  CommentsDataModel({
    required this.comments,
    required this.message,
    required this.code,
  });

  factory CommentsDataModel.fromJson(Map<String, dynamic> json) => CommentsDataModel(
    comments:json["comments"]!=null? Comments.fromJson(json["comments"]):Comments(data: [],
        ),
    message: json["message"],
    code: json["code"]??0,
  );

  Map<String, dynamic> toJson() => {
    "comments": comments.toJson(),
    "message": message,
    "code": code,
  };
}

class Comments {
  List<CommentsModel> data;
  Links? links;
  Meta? meta;

  Comments({
    required this.data,
  this.links,
    this.meta
  });

  factory Comments.fromJson(Map<String, dynamic> json) => Comments(
    data: List<CommentsModel>.from(json["data"].map((x) => CommentsModel.fromJson(x))),
    links: Links.fromJson(json["links"]),
    meta: Meta.fromJson(json["meta"]),
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "links": links!.toJson(),
    "meta": meta!.toJson(),
  };
}

class CommentsModel {
  int id;
  String comment;
  String audio;
  String image;
  String type;
  User user;
  String time;
  bool show=false;
  List<Reply> replies;
  DateTime createdAt;
  DateTime updatedAt;

  CommentsModel({
    required this.id,
    required this.comment,
    required this.audio,
    required this.image,
    required this.type,
    required this.user,
    required this.replies,
    required this.createdAt,
    required this.updatedAt,
    required this.time
  });

  factory CommentsModel.fromJson(Map<String, dynamic> json) => CommentsModel(
    id: json["id"],
    comment: json["comment"],
    audio: json["audio"],
    image: json["image"],
    type: json["type"],
    time: json["time"],
    user: User.fromJson(json["user"]),
    replies: List<Reply>.from(json["replies"].map((x) => Reply.fromJson(x))),
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "comment": comment,
    "audio": audio,
    "image": image,
    "type": type,
    "time": time,
    "user": user.toJson(),
    "replies": List<dynamic>.from(replies.map((x) => x.toJson())),
    "created_at": "${createdAt.year.toString().padLeft(4, '0')}-${createdAt.month.toString().padLeft(2, '0')}-${createdAt.day.toString().padLeft(2, '0')}",
    "updated_at": "${updatedAt.year.toString().padLeft(4, '0')}-${updatedAt.month.toString().padLeft(2, '0')}-${updatedAt.day.toString().padLeft(2, '0')}",
  };
}

class Reply {
  int id;
  String comment;
  String audio;
  String image;
  String type;
  User user;
  DateTime createdAt;
  DateTime updatedAt;
String time;

  bool show=false;
  Reply({
    required this.id,
    required this.comment,
    required this.audio,
    required this.image,
    required this.type,
    required this.user,
    required this.createdAt,
    required this.updatedAt,
    required this.time,
  });

  factory Reply.fromJson(Map<String, dynamic> json) => Reply(
    id: json["id"],
    comment: json["comment"]??'',
    audio: json["audio"],
    image: json["image"],
    type: json["type"],
    time: json["time"],
    user: User.fromJson(json["user"]),
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "comment": comment,
    "audio": audio,
    "image": image,
    "type": type,
    "time": time,
    "user": user.toJson(),
    "created_at": "${createdAt.year.toString().padLeft(4, '0')}-${createdAt.month.toString().padLeft(2, '0')}-${createdAt.day.toString().padLeft(2, '0')}",
    "updated_at": "${updatedAt.year.toString().padLeft(4, '0')}-${updatedAt.month.toString().padLeft(2, '0')}-${updatedAt.day.toString().padLeft(2, '0')}",
  };
}

class User {
  int id;
  String name;
  String? email;
  String image;
  DateTime createdAt;
  DateTime updatedAt;
  String? phone;
  Season? season;
  Season? term;
  String? fatherPhone;
  String? userStatus;
  String? code;
  DateTime? dateStartCode;
  DateTime? dateEndCode;
  City? city;
  City? country;
  String? token;

  User({
    required this.id,
    required this.name,
    this.email,
    required this.image,
    required this.createdAt,
    required this.updatedAt,
    this.phone,
    this.season,
    this.term,
    this.fatherPhone,
    this.userStatus,
    this.code,
    this.dateStartCode,
    this.dateEndCode,
    this.city,
    this.country,
    this.token,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    image: json["image"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    phone: json["phone"],
    season: json["season"] == null ? null : Season.fromJson(json["season"]),
    term: json["term"] == null ? null : Season.fromJson(json["term"]),
    fatherPhone: json["father_phone"],
    userStatus: json["user_status"],
    code: json["code"],
    dateStartCode: json["date_start_code"] == null ? null : DateTime.parse(json["date_start_code"]),
    dateEndCode: json["date_end_code"] == null ? null : DateTime.parse(json["date_end_code"]),
    city: json["city"] == null ? null : City.fromJson(json["city"]),
    country: json["country"] == null ? null : City.fromJson(json["country"]),
    token: json["token"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "image": image,
    "created_at": "${createdAt.year.toString().padLeft(4, '0')}-${createdAt.month.toString().padLeft(2, '0')}-${createdAt.day.toString().padLeft(2, '0')}",
    "updated_at": "${updatedAt.year.toString().padLeft(4, '0')}-${updatedAt.month.toString().padLeft(2, '0')}-${updatedAt.day.toString().padLeft(2, '0')}",
    "phone": phone,
    "season": season?.toJson(),
    "term": term?.toJson(),
    "father_phone": fatherPhone,
    "user_status": userStatus,
    "code": code,
    "date_start_code": "${dateStartCode!.year.toString().padLeft(4, '0')}-${dateStartCode!.month.toString().padLeft(2, '0')}-${dateStartCode!.day.toString().padLeft(2, '0')}",
    "date_end_code": "${dateEndCode!.year.toString().padLeft(4, '0')}-${dateEndCode!.month.toString().padLeft(2, '0')}-${dateEndCode!.day.toString().padLeft(2, '0')}",
    "city": city?.toJson(),
    "country": country?.toJson(),
    "token": token,
  };
}

class City {
  int id;
  String nameAr;
  String nameEn;
  dynamic createdAt;
  dynamic updatedAt;

  City({
    required this.id,
    required this.nameAr,
    required this.nameEn,
    required this.createdAt,
    required this.updatedAt,
  });

  factory City.fromJson(Map<String, dynamic> json) => City(
    id: json["id"],
    nameAr: json["name_ar"],
    nameEn: json["name_en"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name_ar": nameAr,
    "name_en": nameEn,
    "created_at": createdAt,
    "updated_at": updatedAt,
  };
}

class Season {
  int id;
  String nameAr;
  String nameEn;
  String? status;

  Season({
    required this.id,
    required this.nameAr,
    required this.nameEn,
    this.status,
  });

  factory Season.fromJson(Map<String, dynamic> json) => Season(
    id: json["id"],
    nameAr: json["name_ar"],
    nameEn: json["name_en"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name_ar": nameAr,
    "name_en": nameEn,
    "status": status,
  };
}

class Links {
  String first;
  String last;
  dynamic prev;
  dynamic next;

  Links({
    required this.first,
    required this.last,
    this.prev,
    this.next,
  });

  factory Links.fromJson(Map<String, dynamic> json) => Links(
    first: json["first"],
    last: json["last"],
    prev: json["prev"],
    next: json["next"],
  );

  Map<String, dynamic> toJson() => {
    "first": first,
    "last": last,
    "prev": prev,
    "next": next,
  };
}

class Meta {
  int currentPage;
  int from;
  int lastPage;
  List<Link> links;
  String path;
  int perPage;
  int to;
  int total;

  Meta({
    required this.currentPage,
    required this.from,
    required this.lastPage,
    required this.links,
    required this.path,
    required this.perPage,
    required this.to,
    required this.total,
  });

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
    currentPage: json["current_page"],
    from: json["from"],
    lastPage: json["last_page"],
    links: List<Link>.from(json["links"].map((x) => Link.fromJson(x))),
    path: json["path"],
    perPage: json["per_page"],
    to: json["to"],
    total: json["total"],
  );

  Map<String, dynamic> toJson() => {
    "current_page": currentPage,
    "from": from,
    "last_page": lastPage,
    "links": List<dynamic>.from(links.map((x) => x.toJson())),
    "path": path,
    "per_page": perPage,
    "to": to,
    "total": total,
  };
}

class Link {
  String? url;
  String label;
  bool active;

  Link({
    this.url,
    required this.label,
    required this.active,
  });

  factory Link.fromJson(Map<String, dynamic> json) => Link(
    url: json["url"],
    label: json["label"],
    active: json["active"],
  );

  Map<String, dynamic> toJson() => {
    "url": url,
    "label": label,
    "active": active,
  };
}
