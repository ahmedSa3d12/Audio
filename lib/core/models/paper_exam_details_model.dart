import 'package:new_mazoon/core/models/paper_exam_data_model.dart';

class PaperExamDetialsModel {
  PaperExam? data;
  String? message;
  int? code;

  PaperExamDetialsModel({
    this.data,
    this.message,
    this.code,
  });

  PaperExamDetialsModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new PaperExam.fromJson(json['data']) : null;
    message = json['message'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = this.message;
    data['code'] = this.code;

    return data;
  }
}
