// To parse this JSON data, do
//
//     final notificationsModel = notificationsModelFromJson(jsonString);

import 'dart:convert';

NotificationsModel notificationsModelFromJson(String str) =>
    NotificationsModel.fromJson(json.decode(str));

String notificationsModelToJson(NotificationsModel data) =>
    json.encode(data.toJson());

class NotificationsModel {
  NotificationsModel({
    this.data,
  });

  List<NotificationModel>? data;

  factory NotificationsModel.fromJson(Map<String, dynamic> json) =>
      NotificationsModel(
        data: List<NotificationModel>.from(
            json["data"].map((x) => NotificationModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class NotificationModel {
  NotificationModel({
    this.id,
    this.title,
    this.body,
    this.type,
    this.seen,
    this.serviceId,
    this.image,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? title;
  String? body;
  String? type;
  String? seen;
  int? serviceId;
  String? image;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      NotificationModel(
        id: json["id"],
        title: json["title"] != null ? json["title"] : '',
        body: json["body"] != null ? json["body"] : '',
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        image: json["image"] != null ? json["image"] : '',
        seen:json["seen"] ,
        serviceId: json["service_id"],
        type:  json["type"] != null ? json["type"] : '',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "body": body,
    "created_at": "${createdAt!.year.toString().padLeft(4, '0')}-${createdAt!.month.toString().padLeft(2, '0')}-${createdAt!.day.toString().padLeft(2, '0')}",
    "updated_at": "${updatedAt!.year.toString().padLeft(4, '0')}-${updatedAt!.month.toString().padLeft(2, '0')}-${updatedAt!.day.toString().padLeft(2, '0')}",
        // "created_at": createdAt,
        // "updated_at": updatedAt,
        "service_id":serviceId,
       "type":type,
       "seen":seen,
       "image":image
      };
}
