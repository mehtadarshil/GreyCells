// To parse this JSON data, do
//
//     final receiptListModel = receiptListModelFromJson(jsonString);

import 'dart:convert';

ReceiptListModel receiptListModelFromJson(String str) =>
    ReceiptListModel.fromJson(json.decode(str));

String receiptListModelToJson(ReceiptListModel data) =>
    json.encode(data.toJson());

class ReceiptListModel {
  final String? message;
  final bool? isSuccess;
  final List<List<String>>? getRctVector;

  ReceiptListModel({
    this.message,
    this.isSuccess,
    this.getRctVector,
  });

  factory ReceiptListModel.fromJson(Map<String, dynamic> json) =>
      ReceiptListModel(
        message: json["message"],
        isSuccess: json["isSuccess"],
        getRctVector: json["getRctVector"] == null
            ? []
            : List<List<String>>.from(json["getRctVector"]!
                .map((x) => List<String>.from(x.map((x) => x)))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "isSuccess": isSuccess,
        "getRctVector": getRctVector == null
            ? []
            : List<dynamic>.from(
                getRctVector!.map((x) => List<dynamic>.from(x.map((x) => x)))),
      };
}
