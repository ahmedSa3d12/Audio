class CountDownModel {
  CountDown data;
  String message;
  int code;

  CountDownModel({
    required this.data,
    required this.message,
    required this.code,
  });

  factory CountDownModel.fromJson(Map<String, dynamic> json) => CountDownModel(
    data: CountDown.fromJson(json["data"]),
    message: json["message"],
    code: json["code"],
  );

  Map<String, dynamic> toJson() => {
    "data": data.toJson(),
    "message": message,
    "code": code,
  };
}

class CountDown {
  String image;
  String title;
  String description;
  String dateExam;
  int months;
  int days;
  int hours;

  CountDown({
    required this.image,
    required this.title,
    required this.description,
    required this.dateExam,
    required this.months,
    required this.days,
    required this.hours,
  });

  factory CountDown.fromJson(Map<String, dynamic> json) => CountDown(
    image: json["image"],
    title: json["title"],
    description: json["description"],
    dateExam: json["date_exam"],
    months: json["months"],
    days: json["days"],
    hours: json["hours"],
  );

  Map<String, dynamic> toJson() => {
    "image": image,
    "title": title,
    "description": description,
    "date_exam":dateExam,
    "months": months,
    "days": days,
    "hours": hours,
  };
}
