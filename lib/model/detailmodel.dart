// To parse required this JSON data, do
//
//     final detail = detailFromJson(jsonString);

import 'dart:convert';

Detail detailFromJson(String str) => Detail.fromJson(json.decode(str));

String detailToJson(Detail data) => json.encode(data.toJson());

class Detail {
  Detail({
    required this.id,
    required this.userId,
    required this.type,
    required this.jmlUang,
    required this.note,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  int userId;
  String type;
  int jmlUang;
  String note;
  String createdAt;
  String updatedAt;

  factory Detail.fromJson(Map<String, dynamic> json) => Detail(
        id: json["id"],
        userId: json["user_id"],
        type: json["type"],
        jmlUang: json["jml_uang"],
        note: json["note"] ?? "",
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "type": type,
        "jml_uang": jmlUang,
        "note": note,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}
