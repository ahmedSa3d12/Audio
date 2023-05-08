class ExamInstructionModel {
  Data? data;
  String? message;
  int? code;

  ExamInstructionModel({
    this.data,
    this.message,
    this.code,
  });

  factory ExamInstructionModel.fromJson(Map<String, dynamic> json) => ExamInstructionModel(
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
    message: json["message"],
    code: json["code"],
  );

  Map<String, dynamic> toJson() => {
    "data": data?.toJson(),
    "message": message,
    "code": code,
  };
}

class Data {
  User? user;
  Details? details;

  Data({
    this.user,
    this.details,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    user: json["user"] == null ? null : User.fromJson(json["user"]),
    details: json["details"] == null ? null : Details.fromJson(json["details"]),
  );

  Map<String, dynamic> toJson() => {
    "user": user?.toJson(),
    "details": details?.toJson(),
  };
}

class Details {
  int? id;
  String? name;
  String? type;
  int? tryingNumber;
  int? numOfQuestion;
  int? totalTime;
  List<String>? instruction;

  Details({
    this.id,
    this.name,
    this.type,
    this.tryingNumber,
    this.numOfQuestion,
    this.totalTime,
    this.instruction,
  });

  factory Details.fromJson(Map<String, dynamic> json) => Details(
    id: json["id"],
    name: json["name"],
    type: json["type"],
    tryingNumber: json["trying_number"],
    numOfQuestion: json["num_of_question"],
    totalTime: json["total_time"],
    instruction: json["instruction"] == null ? [] : List<String>.from(json["instruction"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "type": type,
    "trying_number": tryingNumber,
    "num_of_question": numOfQuestion,
    "total_time": totalTime,
    "instruction": instruction == null ? [] : List<dynamic>.from(instruction!.map((x) => x)),
  };
}

class User {
  int? id;
  String? name;
  String? image;
  int? degree;
  double? per;
  int? totalTime;
  String? timeExam;
  City? city;

  User({
    this.id,
    this.name,
    this.image,
    this.degree,
    this.per,
    this.totalTime,
    this.timeExam,
    this.city,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    name: json["name"],
    image: json["image"],
    degree: json["degree"],
    per: json["per"]?.toDouble(),
    totalTime: json["total_time"],
    timeExam: json["time_exam"],
    city: json["city"] == null ? null : City.fromJson(json["city"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "image": image,
    "degree": degree,
    "per": per,
    "total_time": totalTime,
    "time_exam": timeExam,
    "city": city?.toJson(),
  };
}

class City {
  int? id;
  String? nameAr;
  String? nameEn;
  DateTime? createdAt;
  DateTime? updatedAt;

  City({
    this.id,
    this.nameAr,
    this.nameEn,
    this.createdAt,
    this.updatedAt,
  });

  factory City.fromJson(Map<String, dynamic> json) => City(
    id: json["id"],
    nameAr: json["name_ar"],
    nameEn: json["name_en"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name_ar": nameAr,
    "name_en": nameEn,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}
