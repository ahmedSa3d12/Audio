class ApplyStudentExam {
  String question;
  String? answer;
  String? audio;
  String? image;
  dynamic timer;
  ApplyStudentExam(
      {required this.question,
      required this.timer,
      this.answer,
      this.audio,
      this.image});
  Map<String, dynamic> toJson(int index) {
    return {
      'details[$index][question]': question,
      'timer': timer,
      if (answer != null) 'details[$index][answer]': answer,
      if (audio != null) 'details[$index][audio]': audio,
      if (image != null) 'details[$index][image]': image,
    };
  }
}

////response of apply exam

class ResponseOfApplyLessonExmam {
  ResponseOfApplyLessonExmamData data;
  String message;
  int code;

  ResponseOfApplyLessonExmam({
    required this.data,
    required this.message,
    required this.code,
  });

  factory ResponseOfApplyLessonExmam.fromJson(Map<String, dynamic> json) =>
      ResponseOfApplyLessonExmam(
        data: json["data"] != null
            ? ResponseOfApplyLessonExmamData.fromJson(json["data"])
            : ResponseOfApplyLessonExmamData(),
        message: json["message"],
        code: json["code"],
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
        "message": message,
        "code": code,
      };
}

class ResponseOfApplyLessonExmamData {
  dynamic degree;
  dynamic ordered;
  dynamic examId;
  dynamic examName;
  dynamic examType;
  dynamic motivationalWord;
  dynamic numOfCorrectQuestions;
  dynamic numOfMistakeQuestions;
  dynamic numOfLeaveQuestions;
  dynamic totalTimeTake;
  dynamic totalTimeExam;
  dynamic tryingNumber;
  dynamic titleResult;
  dynamic descriptionResult;
  dynamic imageResult;

  ResponseOfApplyLessonExmamData({
    this.degree,
    this.ordered,
    this.examId,
    this.examType,
    this.examName,
    this.motivationalWord,
    this.numOfCorrectQuestions,
    this.numOfMistakeQuestions,
    this.numOfLeaveQuestions,
    this.totalTimeTake,
    this.tryingNumber,
    this.titleResult,
    this.totalTimeExam,
    this.descriptionResult,
    this.imageResult,
  });

  factory ResponseOfApplyLessonExmamData.fromJson(Map<String, dynamic> json) =>
      ResponseOfApplyLessonExmamData(
        degree: json["degree"],
        examName: json['exam_name'],
        examType: json['exam_type'],
        examId: json['exam_id'],
        totalTimeExam: json['total_time_exam'],
        ordered: json["ordered"],
        tryingNumber: json['trying_number'],
        motivationalWord: json["motivational_word"],
        numOfCorrectQuestions: json["num_of_correct_questions"],
        numOfMistakeQuestions: json["num_of_mistake_questions"],
        numOfLeaveQuestions: json["num_of_leave_questions"],
        totalTimeTake: json["total_time_take"],
        titleResult: json["title_result"],
        descriptionResult: json["description_result"],
        imageResult: json["image_result"],
      );

  Map<String, dynamic> toJson() => {
        "degree": degree,
        "ordered": ordered,
        "exam_id": examId,
        "exam_type": examType,
        "exam_name": examName,
        "trying_number": tryingNumber,
        "total_time_exam": totalTimeExam,
        "motivational_word": motivationalWord,
        "num_of_correct_questions": numOfCorrectQuestions,
        "num_of_mistake_questions": numOfMistakeQuestions,
        "num_of_leave_questions": numOfLeaveQuestions,
        "total_time_take": totalTimeTake,
        "title_result": titleResult,
        "description_result": descriptionResult,
        "image_result": imageResult,
      };
}
