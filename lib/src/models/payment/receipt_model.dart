// To parse this JSON data, do
//
//     final receiptModel = receiptModelFromJson(jsonString);

import 'dart:convert';

ReceiptModel receiptModelFromJson(String str) =>
    ReceiptModel.fromJson(json.decode(str));

String receiptModelToJson(ReceiptModel data) => json.encode(data.toJson());

class ReceiptModel {
  final String? message;
  final bool? isSuccess;
  final String? getUseroid;
  final String? getTransactionId;
  final String? getReportFilePath;

  ReceiptModel({
    this.message,
    this.isSuccess,
    this.getUseroid,
    this.getTransactionId,
    this.getReportFilePath,
  });

  factory ReceiptModel.fromJson(Map<String, dynamic> json) => ReceiptModel(
        message: json["message"],
        isSuccess: json["isSuccess"],
        getUseroid: json["getUseroid"],
        getTransactionId: json["getTransactionId"],
        getReportFilePath: json["getReportFilePath"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "isSuccess": isSuccess,
        "getUseroid": getUseroid,
        "getTransactionId": getTransactionId,
        "getReportFilePath": getReportFilePath,
      };
}
