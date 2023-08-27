class ApplyMakeExam {
  String question;
  String? answer;

  ApplyMakeExam({
    required this.question,
    this.answer,
  });
  Map<String, dynamic> toJson(int index) {
    return {
      'details[$index][question]': question,
      if (answer != null) 'details[$index][answer]': answer,
    };
  }
}

////response of apply exam

class ResponseOfMakeExam {
  ResponseOfMakeExamData? data;
  String message;
  int code;

  ResponseOfMakeExam({
    required this.data,
    required this.message,
    required this.code,
  });

  factory ResponseOfMakeExam.fromJson(Map<String, dynamic> json) =>
      ResponseOfMakeExam(
        data: json["data"] == null
            ? null
            : ResponseOfMakeExamData.fromJson(json["data"]),
        message: json["message"],
        code: json["code"],
      );

  Map<String, dynamic> toJson() => {
        "data": data!.toJson(),
        "message": message,
        "code": code,
      };
}

class ResponseOfMakeExamData {
  dynamic per;
  String motivationalWord;
  String studentDegree;
  int numOfCorrectQuestions;
  int numOfMistakeQuestions;
  int numOfLeaveQuestions;
  ResponseOfMakeExamDataExamQuestions examQuestions;

  ResponseOfMakeExamData({
    required this.per,
    required this.motivationalWord,
    required this.studentDegree,
    required this.numOfCorrectQuestions,
    required this.numOfMistakeQuestions,
    required this.numOfLeaveQuestions,
    required this.examQuestions,
  });

  factory ResponseOfMakeExamData.fromJson(Map<String, dynamic> json) =>
      ResponseOfMakeExamData(
        per: json["per"],
        motivationalWord: json["motivational_word"],
        studentDegree: json["student_degree"],
        numOfCorrectQuestions: json["num_of_correct_questions"],
        numOfMistakeQuestions: json["num_of_mistake_questions"],
        numOfLeaveQuestions: json["num_of_leave_questions"],
        examQuestions: ResponseOfMakeExamDataExamQuestions.fromJson(
            json["exam_questions"]),
      );

  Map<String, dynamic> toJson() => {
        "per": per,
        "motivational_word": motivationalWord,
        "student_degree": studentDegree,
        "num_of_correct_questions": numOfCorrectQuestions,
        "num_of_mistake_questions": numOfMistakeQuestions,
        "num_of_leave_questions": numOfLeaveQuestions,
        "exam_questions": examQuestions.toJson(),
      };
}

class ResponseOfMakeExamDataExamQuestions {
  int id;
  dynamic name;
  List<ResponseOfMakeExamDataQuestion> questions;

  ResponseOfMakeExamDataExamQuestions({
    required this.id,
    required this.name,
    required this.questions,
  });

  factory ResponseOfMakeExamDataExamQuestions.fromJson(
          Map<String, dynamic> json) =>
      ResponseOfMakeExamDataExamQuestions(
        id: json["id"],
        name: json["name"],
        questions: List<ResponseOfMakeExamDataQuestion>.from(json["questions"]
            .map((x) => ResponseOfMakeExamDataQuestion.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "questions": List<dynamic>.from(questions.map((x) => x.toJson())),
      };
}

class ResponseOfMakeExamDataQuestion {
  int id;
  String question;
  bool questionStatus;
  int answerUser;
  String answerUserType;
  String questionType;
  String fileType;
  int degree;
  String note;
  List<ResponseOfMakeExamDataAnswer> answers;
  DateTime createdAt;
  DateTime updatedAt;

  ResponseOfMakeExamDataQuestion({
    required this.id,
    required this.question,
    required this.answerUser,
    required this.questionStatus,
    required this.answerUserType,
    required this.questionType,
    required this.fileType,
    required this.degree,
    required this.note,
    required this.answers,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ResponseOfMakeExamDataQuestion.fromJson(Map<String, dynamic> json) =>
      ResponseOfMakeExamDataQuestion(
        id: json["id"],
        questionStatus: false,
        question: json["question"],
        answerUser: json["answer_user"],
        answerUserType: json["answer_user_type"],
        questionType: json["question_type"],
        fileType: json["file_type"],
        degree: json["degree"],
        note: json["note"],
        answers: List<ResponseOfMakeExamDataAnswer>.from(json["answers"]
            .map((x) => ResponseOfMakeExamDataAnswer.fromJson(x))),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "question": question,
        "answer_user": answerUser,
        "answer_user_type": answerUserType,
        "question_type": questionType,
        "file_type": fileType,
        "degree": degree,
        "note": note,
        "answers": List<dynamic>.from(answers.map((x) => x.toJson())),
        "created_at":
            "${createdAt.year.toString().padLeft(4, '0')}-${createdAt.month.toString().padLeft(2, '0')}-${createdAt.day.toString().padLeft(2, '0')}",
        "updated_at":
            "${updatedAt.year.toString().padLeft(4, '0')}-${updatedAt.month.toString().padLeft(2, '0')}-${updatedAt.day.toString().padLeft(2, '0')}",
      };
}

class ResponseOfMakeExamDataAnswer {
  int id;
  String answer;
  String answerNumber;
  String answerStatus;
  DateTime createdAt;
  DateTime updatedAt;

  ResponseOfMakeExamDataAnswer({
    required this.id,
    required this.answer,
    required this.answerNumber,
    required this.answerStatus,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ResponseOfMakeExamDataAnswer.fromJson(Map<String, dynamic> json) =>
      ResponseOfMakeExamDataAnswer(
        id: json["id"],
        answer: json["answer"],
        answerNumber: json["answer_number"],
        answerStatus: json["answer_status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "answer": answer,
        "answer_number": answerNumber,
        "answer_status": answerStatus,
        "created_at":
            "${createdAt.year.toString().padLeft(4, '0')}-${createdAt.month.toString().padLeft(2, '0')}-${createdAt.day.toString().padLeft(2, '0')}",
        "updated_at":
            "${updatedAt.year.toString().padLeft(4, '0')}-${updatedAt.month.toString().padLeft(2, '0')}-${updatedAt.day.toString().padLeft(2, '0')}",
      };
}
