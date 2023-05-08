import 'package:new_mazoon/core/models/paper_exam_data_model.dart';

import 'TimeModel.dart';

class PaperExamModel{
  Data? data;
  String? message;
  int? code;
  String? dateExam;
  String? address;
  String? sectionName;

  PaperExamModel(
      {this.data,
        this.message,
        this.code,
        this.dateExam,
        this.address,
        this.sectionName});

  PaperExamModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    message = json['message'];
    code = json['code'];
    dateExam = json['date_exam'];
    address = json['address'];
    sectionName = json['section_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = this.message;
    data['code'] = this.code;
    data['date_exam'] = this.dateExam;
    data['address'] = this.address;
    data['section_name'] = this.sectionName;
    return data;
  }
}

class Data {
  PaperExam? exam;

  Data({this.exam});

  Data.fromJson(Map<String, dynamic> json) {
    exam = json['exam'] != null ? new PaperExam.fromJson(json['exam']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.exam != null) {
      data['exam'] = this.exam!.toJson();
    }
    return data;
  }
}



