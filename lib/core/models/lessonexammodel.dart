class LessonExamModel {
  List<LessonExamData> data;
  String message;
  int code;

  LessonExamModel({
    required this.data,
    required this.message,
    required this.code,
  });

  factory LessonExamModel.fromJson(Map<String, dynamic> json) =>
      LessonExamModel(
        data: List<LessonExamData>.from(
            json["data"].map((x) => LessonExamData.fromJson(x))),
        message: json["message"],
        code: json["code"],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "message": message,
        "code": code,
      };
}

class LessonExamData {
  int id;
  String name;
  String type;
  String backgroundColor;
  String examsFavorite;
  dynamic pdfExamUpload;
  dynamic answerPdfFile;
  dynamic answerVideoFile;
  int numOfQuestion;
  int totalTime;
  int examPdfSize;
  int answerPdfSize;
  int answerVideoSize;

  LessonExamData({
    required this.id,
    required this.name,
    required this.type,
    required this.backgroundColor,
    required this.examsFavorite,
    this.pdfExamUpload,
    this.answerPdfFile,
    this.answerVideoFile,
    required this.numOfQuestion,
    required this.totalTime,
    required this.examPdfSize,
    required this.answerPdfSize,
    required this.answerVideoSize,
  });

  factory LessonExamData.fromJson(Map<String, dynamic> json) => LessonExamData(
        id: json["id"],
        name: json["name"],
        type: json["type"],
        backgroundColor: json["background_color"],
        examsFavorite: json["exams_favorite"],
        pdfExamUpload: json["pdf_exam_upload"],
        answerPdfFile: json["answer_pdf_file"],
        answerVideoFile: json["answer_video_file"],
        numOfQuestion: json["num_of_question"],
        totalTime: json["total_time"],
        examPdfSize: json["exam_pdf_size"],
        answerPdfSize: json["answer_pdf_size"],
        answerVideoSize: json["answer_video_size"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "type": type,
        "background_color": backgroundColor,
        "exams_favorite": examsFavorite,
        "pdf_exam_upload": pdfExamUpload,
        "answer_pdf_file": answerPdfFile,
        "answer_video_file": answerVideoFile,
        "num_of_question": numOfQuestion,
        "total_time": totalTime,
        "exam_pdf_size": examPdfSize,
        "answer_pdf_size": answerPdfSize,
        "answer_video_size": answerVideoSize,
      };
}
