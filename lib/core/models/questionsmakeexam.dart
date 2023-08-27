class QuestionsOfMakeExamModel {
  QuestionsOfMakeExamModelData? data;
  String message;
  int code;

  QuestionsOfMakeExamModel({
    this.data,
    required this.message,
    required this.code,
  });

  factory QuestionsOfMakeExamModel.fromJson(Map<String, dynamic> json) =>
      QuestionsOfMakeExamModel(
        data: json["data"] == null
            ? null
            : QuestionsOfMakeExamModelData.fromJson(json["data"]),
        message: json["message"],
        code: json["code"],
      );

  Map<String, dynamic> toJson() => {
        "data": data!.toJson(),
        "message": message,
        "code": code,
      };
}

class QuestionsOfMakeExamModelData {
  int id;
  String questionsType;
  int totalTime;
  int examDegree;
  int numOfQuestions;
  List<Question> questions;
  DateTime createdAt;
  DateTime updatedAt;

  QuestionsOfMakeExamModelData({
    required this.id,
    required this.questionsType,
    required this.totalTime,
    required this.examDegree,
    required this.numOfQuestions,
    required this.questions,
    required this.createdAt,
    required this.updatedAt,
  });

  factory QuestionsOfMakeExamModelData.fromJson(Map<String, dynamic> json) =>
      QuestionsOfMakeExamModelData(
        id: json["id"],
        questionsType: json["questions_type"],
        totalTime: json["total_time"],
        examDegree: json["exam_degree"],
        numOfQuestions: json["num_of_questions"],
        questions: List<Question>.from(
            json["questions"].map((x) => Question.fromJson(x))),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "questions_type": questionsType,
        "total_time": totalTime,
        "exam_degree": examDegree,
        "num_of_questions": numOfQuestions,
        "questions": List<dynamic>.from(questions.map((x) => x.toJson())),
        "created_at":
            "${createdAt.year.toString().padLeft(4, '0')}-${createdAt.month.toString().padLeft(2, '0')}-${createdAt.day.toString().padLeft(2, '0')}",
        "updated_at":
            "${updatedAt.year.toString().padLeft(4, '0')}-${updatedAt.month.toString().padLeft(2, '0')}-${updatedAt.day.toString().padLeft(2, '0')}",
      };
}

class Question {
  int id;
  String question;
  String questionType;
  String fileType;
  int degree;
  bool isSolving;

  String note;
  List<Answer> answers;
  DateTime createdAt;
  DateTime updatedAt;

  Question({
    required this.id,
    required this.question,
    required this.questionType,
    required this.fileType,
    required this.degree,
    required this.note,
    required this.isSolving,
    required this.answers,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Question.fromJson(Map<String, dynamic> json) => Question(
        id: json["id"],
        isSolving: false,
        question: json["question"],
        questionType: json["question_type"],
        fileType: json["file_type"],
        degree: json["degree"],
        note: json["note"],
        answers:
            List<Answer>.from(json["answers"].map((x) => Answer.fromJson(x))),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "question": question,
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

class Answer {
  int id;
  String answer;
  String answerNumber;
  String answerStatus;
  DateTime createdAt;
  String selectedValue;

  DateTime updatedAt;

  Answer({
    required this.id,
    required this.answer,
    required this.answerNumber,
    required this.answerStatus,
    this.selectedValue = '',
    required this.createdAt,
    required this.updatedAt,
  });

  factory Answer.fromJson(Map<String, dynamic> json) => Answer(
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
