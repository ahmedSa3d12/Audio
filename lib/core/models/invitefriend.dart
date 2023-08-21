class InviteFriendModel {
  InviteFriendModelData data;
  String message;
  int code;

  InviteFriendModel({
    required this.data,
    required this.message,
    required this.code,
  });

  factory InviteFriendModel.fromJson(Map<String, dynamic> json) =>
      InviteFriendModel(
        data: InviteFriendModelData.fromJson(json["data"]),
        message: json["message"],
        code: json["code"],
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
        "message": message,
        "code": code,
      };
}

class InviteFriendModelData {
  List<String> share;

  InviteFriendModelData({
    required this.share,
  });

  factory InviteFriendModelData.fromJson(Map<String, dynamic> json) =>
      InviteFriendModelData(
        share: List<String>.from(json["share"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "share": List<dynamic>.from(share.map((x) => x)),
      };
}
