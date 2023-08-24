
class MakeYourExamModel {
    List<MakeYourExamModelData> data;
    String message;
    int code;

    MakeYourExamModel({
        required this.data,
        required this.message,
        required this.code,
    });

    factory MakeYourExamModel.fromJson(Map<String, dynamic> json) => MakeYourExamModel(
        data: List<MakeYourExamModelData>.from(json["data"].map((x) => MakeYourExamModelData.fromJson(x))),
        message: json["message"],
        code: json["code"],
    );

    Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "message": message,
        "code": code,
    };
}

class MakeYourExamModelData {
    int id;
    String name;
    String image;
    int limitOfQuestions;
    List<Lesson> lessons;

    MakeYourExamModelData({
        required this.id,
        required this.name,
        required this.image,
        required this.limitOfQuestions,
        required this.lessons,
    });

    factory MakeYourExamModelData.fromJson(Map<String, dynamic> json) => MakeYourExamModelData(
        id: json["id"],
        name: json["name"],
        image: json["image"],
        limitOfQuestions: json["limit_of_questions"],
        lessons: List<Lesson>.from(json["lessons"].map((x) => Lesson.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
        "limit_of_questions": limitOfQuestions,
        "lessons": List<dynamic>.from(lessons.map((x) => x.toJson())),
    };
}

class Lesson {
    int id;
    String name;
    int limitOfQuestions;

    Lesson({
        required this.id,
        required this.name,
        required this.limitOfQuestions,
    });

    factory Lesson.fromJson(Map<String, dynamic> json) => Lesson(
        id: json["id"],
        name: json["name"],
        limitOfQuestions: json["limit_of_questions"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "limit_of_questions": limitOfQuestions,
    };
}
