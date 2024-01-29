// To parse this JSON data, do
//
//     final paymentMessage = paymentMessageFromJson(jsonString);

import 'dart:convert';

PaymentMessage paymentMessageFromJson(String str) =>
    PaymentMessage.fromJson(json.decode(str));

String paymentMessageToJson(PaymentMessage data) => json.encode(data.toJson());

class PaymentMessage {
  final String? message;
  final bool? isSuccess;
  final String? getOnlineTransactionNo;
  final String? getAcademicSessId;
  final GetMessageString? getMessageString;

  PaymentMessage({
    this.message,
    this.isSuccess,
    this.getOnlineTransactionNo,
    this.getAcademicSessId,
    this.getMessageString,
  });

  factory PaymentMessage.fromJson(Map<String, dynamic> json) => PaymentMessage(
        message: json["message"],
        isSuccess: json["isSuccess"],
        getOnlineTransactionNo: json["getOnlineTransactionNo"],
        getAcademicSessId: json["getAcademicSessId"],
        getMessageString: json["getMessageString"] == null
            ? null
            : GetMessageString.fromJson(json["getMessageString"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "isSuccess": isSuccess,
        "getOnlineTransactionNo": getOnlineTransactionNo,
        "getAcademicSessId": getAcademicSessId,
        "getMessageString": getMessageString?.toJson(),
      };
}

class GetMessageString {
  final String? key;
  final String? currency;
  final String? amount;
  final String? orderId;
  final String? callbackUrl;

  GetMessageString({
    this.key,
    this.currency,
    this.amount,
    this.orderId,
    this.callbackUrl,
  });

  factory GetMessageString.fromJson(Map<String, dynamic> json) =>
      GetMessageString(
        key: json["key"],
        currency: json["currency"],
        amount: json["amount"],
        orderId: json["order_id"],
        callbackUrl: json["callback_url"],
      );

  Map<String, dynamic> toJson() => {
        "key": key,
        "currency": currency,
        "amount": amount,
        "order_id": orderId,
        "callback_url": callbackUrl,
      };
}



// // To parse this JSON data, do
// //
// //     final paymentMessage = paymentMessageFromJson(jsonString);

// import 'dart:convert';

// PaymentMessage paymentMessageFromJson(String str) =>
//     PaymentMessage.fromJson(json.decode(str));

// String paymentMessageToJson(PaymentMessage data) => json.encode(data.toJson());

// class PaymentMessage {
//   final String? message;
//   final bool? isSuccess;
//   final GetResponse? getResponse;

//   PaymentMessage({
//     this.message,
//     this.isSuccess,
//     this.getResponse,
//   });

//   factory PaymentMessage.fromJson(Map<String, dynamic> json) => PaymentMessage(
//         message: json["message"],
//         isSuccess: json["isSuccess"],
//         getResponse: json["getResponse"] == null
//             ? null
//             : GetResponse.fromJson(json["getResponse"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "message": message,
//         "isSuccess": isSuccess,
//         "getResponse": getResponse?.toJson(),
//       };
// }

// class GetResponse {
//   final String? url;
//   final String? method;
//   final Params? params;

//   GetResponse({
//     this.url,
//     this.method,
//     this.params,
//   });

//   factory GetResponse.fromJson(Map<String, dynamic> json) => GetResponse(
//         url: json["url"],
//         method: json["method"],
//         params: json["params"] == null ? null : Params.fromJson(json["params"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "url": url,
//         "method": method,
//         "params": params?.toJson(),
//       };
// }

// class Params {
//   final String? accessCode;
//   final String? encRequest;

//   Params({
//     this.accessCode,
//     this.encRequest,
//   });

//   factory Params.fromJson(Map<String, dynamic> json) => Params(
//         accessCode: json["access_code"],
//         encRequest: json["encRequest"],
//       );

//   Map<String, dynamic> toJson() => {
//         "access_code": accessCode,
//         "encRequest": encRequest,
//       };
// }
