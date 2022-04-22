// To parse required this JSON data, do
//
//     final transaction = transactionFromJson(jsonString);

import 'dart:convert';

List<Transaction> transactionFromJson(String str) => List<Transaction>.from(
    json.decode(str).map((x) => Transaction.fromJson(x)));

String transactionToJson(List<Transaction> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Transaction {
  Transaction({
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

  factory Transaction.fromJson(Map<String, dynamic> json) => Transaction(
        id: json["id"],
        userId: json["user_id"],
        type: json["type"],
        jmlUang: json["jml_uang"],
        note: json["note"] ?? "",
        createdAt: json["created_at"] ?? "",
        updatedAt: json["updated_at"] ?? "",
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
