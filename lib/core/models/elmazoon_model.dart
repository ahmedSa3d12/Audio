class ELmazoonModel {
  ELmazoonModelData data;
  String message;
  int code;

  ELmazoonModel({
    required this.data,
    required this.message,
    required this.code,
  });

  factory ELmazoonModel.fromJson(Map<String, dynamic> json) => ELmazoonModel(
        data: ELmazoonModelData.fromJson(json["data"]),
        message: json["message"],
        code: json["code"],
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
        "message": message,
        "code": code,
      };
}

class ELmazoonModelData {
  String teacherName;
  String image;
  String department;
  List<ELmazoonModelDataExperience> qualifications;
  List<ELmazoonModelDataExperience> experiences;
  List<ELmazoonModelDataExperience> skills;
  String facebookLink;
  String youtubeLink;
  String instagramLink;

  ELmazoonModelData({
    required this.teacherName,
    required this.image,
    required this.department,
    required this.qualifications,
    required this.experiences,
    required this.skills,
    required this.facebookLink,
    required this.youtubeLink,
    required this.instagramLink,
  });

  factory ELmazoonModelData.fromJson(Map<String, dynamic> json) =>
      ELmazoonModelData(
        teacherName: json["teacher_name"],
        image: json["image"],
        department: json["department"],
        qualifications: List<ELmazoonModelDataExperience>.from(
            json["qualifications"]
                .map((x) => ELmazoonModelDataExperience.fromJson(x))),
        experiences: List<ELmazoonModelDataExperience>.from(json["experiences"]
            .map((x) => ELmazoonModelDataExperience.fromJson(x))),
        skills: List<ELmazoonModelDataExperience>.from(
            json["skills"].map((x) => ELmazoonModelDataExperience.fromJson(x))),
        facebookLink: json["facebook_link"],
        youtubeLink: json["youtube_link"],
        instagramLink: json["instagram_link"],
      );

  Map<String, dynamic> toJson() => {
        "teacher_name": teacherName,
        "image": image,
        "department": department,
        "qualifications":
            List<dynamic>.from(qualifications.map((x) => x.toJson())),
        "experiences": List<dynamic>.from(experiences.map((x) => x.toJson())),
        "skills": List<dynamic>.from(skills.map((x) => x.toJson())),
        "facebook_link": facebookLink,
        "youtube_link": youtubeLink,
        "instagram_link": instagramLink,
      };
}

class ELmazoonModelDataExperience {
  int id;
  String title;
  String description;
  String year;

  ELmazoonModelDataExperience({
    required this.id,
    required this.title,
    required this.description,
    required this.year,
  });

  factory ELmazoonModelDataExperience.fromJson(Map<String, dynamic> json) =>
      ELmazoonModelDataExperience(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        year: json["year"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "year": year,
      };
}
