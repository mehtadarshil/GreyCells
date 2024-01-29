// To parse this JSON data, do
//
//     final timeTableModel = timeTableModelFromJson(jsonString);

import 'dart:convert';

TimeTableModel timeTableModelFromJson(String str) =>
    TimeTableModel.fromJson(json.decode(str));

String timeTableModelToJson(TimeTableModel data) => json.encode(data.toJson());

class TimeTableModel {
  final String? message;
  final bool? isSuccess;
  final List<List<String>>? getStdnBatchDetailVector;
  final List<List<String>>? getStdnSubjectDetailVector;

  TimeTableModel({
    this.message,
    this.isSuccess,
    this.getStdnBatchDetailVector,
    this.getStdnSubjectDetailVector,
  });

  factory TimeTableModel.fromJson(Map<String, dynamic> json) => TimeTableModel(
        message: json["message"],
        isSuccess: json["isSuccess"],
        getStdnBatchDetailVector: json["getStdnBatchDetailVector"] == null
            ? []
            : List<List<String>>.from(json["getStdnBatchDetailVector"]!
                .map((x) => List<String>.from(x.map((x) => x)))),
        getStdnSubjectDetailVector: json["getStdnSubjectDetailVector"] == null
            ? []
            : List<List<String>>.from(json["getStdnSubjectDetailVector"]!
                .map((x) => List<String>.from(x.map((x) => x)))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "isSuccess": isSuccess,
        "getStdnBatchDetailVector": getStdnBatchDetailVector == null
            ? []
            : List<dynamic>.from(getStdnBatchDetailVector!
                .map((x) => List<dynamic>.from(x.map((x) => x)))),
        "getStdnSubjectDetailVector": getStdnSubjectDetailVector == null
            ? []
            : List<dynamic>.from(getStdnSubjectDetailVector!
                .map((x) => List<dynamic>.from(x.map((x) => x)))),
      };
}
