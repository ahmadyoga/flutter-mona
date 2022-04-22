// To parse required this JSON data, do
//
//     final dash = dashFromJson(jsonString);

import 'dart:convert';

Dash dashFromJson(String str) => Dash.fromJson(json.decode(str));

String dashToJson(Dash data) => json.encode(data.toJson());

class Dash {
  Dash({
    required this.balance,
    required this.transaksi,
  });

  int balance;
  List<Transaksi> transaksi;

  factory Dash.fromJson(Map<String, dynamic> json) => Dash(
        balance: json["balance"] ?? 0,
        transaksi: List<Transaksi>.from(
            json["transaksi"].map((x) => Transaksi.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "balance": balance,
        "transaksi": List<dynamic>.from(transaksi.map((x) => x.toJson())),
      };
}

class Transaksi {
  Transaksi({
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

  factory Transaksi.fromJson(Map<String, dynamic> json) => Transaksi(
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
