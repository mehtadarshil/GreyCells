import 'dart:convert';
import 'dart:developer';

import 'package:greycell_app/src/commons/widgets/query_params.dart';
import 'package:greycell_app/src/config/apiauth_config.dart';
import 'package:greycell_app/src/manager/data_manager.dart';
import 'package:greycell_app/src/models/payment/due_detail.dart';
import 'package:greycell_app/src/models/payment/payable_fee.dart';
import 'package:greycell_app/src/models/payment/payment_message.dart';
import 'package:greycell_app/src/models/payment/receipt_list_model.dart';
import 'package:greycell_app/src/models/payment/receipt_model.dart';
import 'package:greycell_app/src/models/response/failure.dart';
import 'package:greycell_app/src/models/response/response.dart';
import 'package:greycell_app/src/models/response/success.dart';
import 'package:greycell_app/src/models/student/student_model.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

mixin AccountService on DataManager {
  Map<String, String> get getHeader => {"Content-Type": "application/json"};

  Future<ResponseMania?> getAccountDueDetail() async {
    DueDetail _dueDetail;
    Failure _failure;
    Success? _success;
    selectedGateway = null;
    try {
      String tokenUrl =
          "${school?.schoolFirstServerAddress}${RestAPIs.TOKEN_URL}";
      final response = await dataFilter.getToken(
        serverUrl: tokenUrl,
        apiCode: ApiAuth.ACCOUNT_DUE_API_CODE,
      );
      if (response != null) {
        final URLQueryParams queryParams = URLQueryParams();
        queryParams.append("callback", ApiAuth.ACCOUNT_DUE_CALLBACKS);
        queryParams.append("apiCode", ApiAuth.ACCOUNT_DUE_API_CODE);
//        queryParams.append("loginUserId", "JS/02277");
//        queryParams.append("txtStudRegNo", "JS/02277");

        queryParams.append("loginUserId", user!.getUserId);
        queryParams.append("txtStudRegNo", user!.getUserId);
        queryParams.append("hdnPayAmtFrom", '');
        queryParams.append("accessToken", response['accessToken'].toString());

        final String dueUrl =
            "${school?.schoolFirstServerAddress}${RestAPIs.ACCOUNT_DUE_URL}?$queryParams";
        http.Response _response =
            await http.get(Uri.parse(dueUrl), headers: getHeader);
        print(_response.request?.url);
        print("payment data APIStudPayDueDtl ${_response.body}");

        if (_response.statusCode == 200) {
          final jsonResponse = await dataFilter.toJsonResponse(
              callback: ApiAuth.ACCOUNT_DUE_CALLBACKS,
              response: _response.body);

          final Map<String, dynamic> content = json.decode(jsonResponse);
          print("Accounts Due Detail Content: $content");
          if (content.containsKey('isSuccess') && content['isSuccess']) {
            // Data Exist
            // Clear Exist SelctedFee
            selectedPayableFees.clear();

            _dueDetail = DueDetail.fromJson(content);
            _success = Success(success: _dueDetail);
          } else if (!content['isSuccess']) {
            // No Data
            print("No Data");
            return Failure(
                responseStatus: ResponseManiaStatus.FAILED,
                responseMessage: responseFailedMessage);
            ;
          } else {
            // Error In response
            return Failure(
                responseStatus: ResponseManiaStatus.FAILED,
                responseMessage: responseFailedMessage);
          }
        }
      } else {
        return Failure(
            responseStatus: ResponseManiaStatus.ERROR,
            responseMessage: responseTokenErrorMessage);
      }
    } catch (e) {
      print(e);
      print("How To");
      return Failure(
          responseStatus: ResponseManiaStatus.ERROR,
          responseMessage: internalMessage);
    }
    notifyListeners();
    return _success;
  }

  Future<ReceiptModel?> getReceiptDetails(
      {required Map<String, dynamic> tokens,
      required PaymentSuccessResponse data}) async {
    URLQueryParams urlQueryParams = URLQueryParams();
    urlQueryParams.append("callback", "onlinePayReport");
    urlQueryParams.append("apiCode", ApiAuth.ONLINE_PAY_RPT);
    urlQueryParams.append("loginUserId", user?.getUserId);
    urlQueryParams.append("txtStudRegNo", user?.getUserId);
    urlQueryParams.append("hdnTransactionId", data.orderId);
    urlQueryParams.append("accessToken", tokens["accessToken"]);
    var response =
        await http.get(Uri.parse("${RestAPIs.Receipt_Url}?$urlQueryParams"));
    log(response.body);
    RegExp regExp = RegExp(r'{.*}'); // Regular expression to match JSON object

    var match = regExp.firstMatch(response.body);
    if (match != null) {
      String jsonString = match.group(0) ?? "";

      // Now you have the JSON string, you can parse it using json.decode
      if (jsonString.trim().isNotEmpty) {
        Map<String, dynamic> jsonMap = json.decode(jsonString);
        return ReceiptModel.fromJson(jsonMap);
      }
    }
    return null;
  }

  Future<ReceiptModel?> getReceiptToView(
      {required Map<String, dynamic> tokens,
      required String id,
      String? studendId}) async {
    URLQueryParams urlQueryParams = URLQueryParams();
    urlQueryParams.append("callback", "StudFeeReceipt");
    urlQueryParams.append("loginUserId", user?.getUserId);
    urlQueryParams.append("txtStudRegNo", user?.getUserId);
    urlQueryParams.append("apiCode", "STDNFEE_RECEIPT_REPORT");
    urlQueryParams.append("studentId", studendId);
    urlQueryParams.append("hdnPaymentId", id);
    urlQueryParams.append("accessToken", tokens["accessToken"]);
    log(urlQueryParams.toString());
    var response = await http
        .get(Uri.parse("${RestAPIs.Fee_Receipt_To_View}?$urlQueryParams"));
    log(response.request!.url.toString());
    RegExp regExp = RegExp(r'{.*}'); // Regular expression to match JSON object

    var match = regExp.firstMatch(response.body);
    if (match != null) {
      String jsonString = match.group(0) ?? "";

      // Now you have the JSON string, you can parse it using json.decode
      if (jsonString.trim().isNotEmpty) {
        log(jsonString);
        Map<String, dynamic> jsonMap = json.decode(jsonString);
        return ReceiptModel.fromJson(jsonMap);
      }
    }
    return null;
  }

  Future<ReceiptListModel?> getReceiptList(
      {required Map<String, dynamic> tokens,
      required DateTime fromDate,
      required DateTime toDate}) async {
    URLQueryParams urlQueryParams = URLQueryParams();
    urlQueryParams.append("callback", "studPaymentDtlList");
    urlQueryParams.append("loginUserId", user?.getUserId);
    urlQueryParams.append("txtStudRegNo", user?.getUserId);
    urlQueryParams.append(
        "txtPaymntFromDt", DateFormat("dd-MMM-yyyy").format(fromDate));
    urlQueryParams.append(
        "txtPaymntToDt", DateFormat("dd-MMM-yyyy").format(toDate));
    urlQueryParams.append("accessToken", tokens["accessToken"]);

    var response = await http
        .get(Uri.parse("${RestAPIs.Receipt_List_Url}?$urlQueryParams"));
    RegExp regExp = RegExp(r'{[\s\S]*}');

    // Extract the first match
    var match = regExp.firstMatch(response.body);

    if (match != null) {
      String? jsonPart = match.group(0);

      // Parse the JSON string into a Dart map

      // Now you have the JSON string, you can parse it using json.decode
      if (jsonPart != null && jsonPart.trim().isNotEmpty) {
        Map<String, dynamic> jsonResponse = json.decode(jsonPart);
        return ReceiptListModel.fromJson(jsonResponse);
      }
    }
    return null;
  }

  // Get Transaction Id
  Future<ResponseMania?> getTransactionDetails(
      {Student? student,
      String? amount,
      String? gatewayCode,
      required List<PayableFee> payableFee,
      required DueDetail dueDetail}) async {
    Failure _failure;
    Success? _success;

    // try {
    String tokenUrl =
        "${school?.schoolFirstServerAddress}${RestAPIs.TOKEN_URL}";
    final response = await dataFilter.getToken(
      serverUrl: tokenUrl,
      apiCode: ApiAuth.PAY_MESSAGE_API_CODE,
    );
    print(
        "due list final ${dueDetail.getFeeColVector}   AND ${payableFee.first.id}");
    List<List> finalVectorList = [];
    if (payableFee.isEmpty) {
      finalVectorList = dueDetail.getFeeColVector ?? [];
    } else {
      for (var fee in dueDetail.getFeeColVector!) {
        print(
            " w2222222  ${payableFee.first.toJson()} ${payableFee.any((element) => element.id.toString() == fee[0].toString())}");
        if (payableFee
            .any((element) => element.id.toString() == fee[0].toString())) {
          print(fee.toString() + "rrrr");
          finalVectorList.add(fee);
        }
      }
    }
    print("object $finalVectorList");
    if (response != null) {
      final URLQueryParams queryParams = URLQueryParams();
      queryParams.append("callback", ApiAuth.PAY_MESSAGE_CALLBACKS);
      queryParams.append("apiCode", ApiAuth.PAY_MESSAGE_API_CODE);
      queryParams.append("loginUserId", user!.getUserId);
      queryParams.append("txtStudRegNo", user!.getUserId);
      queryParams.append("txtStudName", student!.fullName);
      queryParams.append(
          "txtPhoneNo", student.getMobileNo ?? student.getGuardianPhone);
      queryParams.append("txtEmail", student.fullEmail);
      if (finalVectorList.length == 1) {
        print("???????????? ${finalVectorList[0][0]}");
        queryParams.append("txtAmountPaid", amount);
        queryParams.append("txtDateOfPayment",
            DateFormat("dd-MMM-yyyy").format(DateTime.now()));
        queryParams.append("cmbFeeSchemeType", finalVectorList[0][0]);
        queryParams.append("txtFeeAmtPaidArr", finalVectorList[0][7]);
        queryParams.append("hdnFeeSchemeDetailIdArr", finalVectorList[0][11]);
        queryParams.append("hdnStudFeeDudtIdArr", finalVectorList[0][10]);
        queryParams.append("hdnFeeDiscountArr", finalVectorList[0][12]);
        queryParams.append("hdnLateFeeArr", finalVectorList[0][13]);
        queryParams.append("hdnMiscFineFee", finalVectorList[0][14]);
        queryParams.append("getPayAmtFrom", dueDetail.getPayAmtFrom);
      } else {
        print("????????????& ${finalVectorList[0][0]}");
        queryParams.append("txtAmountPaid", amount);
        queryParams.append("txtDateOfPayment",
            DateFormat("dd-MMM-yyyy").format(DateTime.now()));
        queryParams.append(
            "cmbFeeSchemeType",
            finalVectorList.fold<List>([], (previousValue, element) {
              previousValue.add(element[0]);
              return previousValue;
            }));
        queryParams.append(
            "txtFeeAmtPaidArr",
            finalVectorList.fold<List>([], (previousValue, element) {
              previousValue.add(element[7]);
              return previousValue;
            }));
        queryParams.append(
            "hdnFeeSchemeDetailIdArr",
            finalVectorList.fold<List>([], (previousValue, element) {
              previousValue.add(element[11]);
              return previousValue;
            }));
        queryParams.append(
            "hdnStudFeeDudtIdArr",
            finalVectorList.fold<List>([], (previousValue, element) {
              previousValue.add(element[10]);
              return previousValue;
            }));
        queryParams.append(
            "hdnFeeDiscountArr",
            finalVectorList.fold<List>([], (previousValue, element) {
              previousValue.add(element[12]);
              return previousValue;
            }));
        queryParams.append(
            "hdnLateFeeArr",
            finalVectorList.fold<List>([], (previousValue, element) {
              previousValue.add(element[13]);
              return previousValue;
            }));
        queryParams.append(
            "hdnMiscFineFee",
            finalVectorList.fold<List>([], (previousValue, element) {
              previousValue.add(element[14]);
              return previousValue;
            }));
        queryParams.append("getPayAmtFrom", dueDetail.getPayAmtFrom);
      }
      // queryParams.append("txtAmountPaid", dueDetail.getFeeColVector![0][5]);

      // final DateTime _date = DateTime.now();
      // final _format = DateFormat('dd-MMM-yyyy').format(_date);
      // print("_format Date: $_format");
      // queryParams.append("txtDateOfPayment", dueDetail.getFeeColVector![0][6]);

      queryParams.append("rdoNetCreditDebit", 'NB');

      // queryParams.append("cmbFeeSchemeType", '0');
      // queryParams.append("txtFeeAmtPaidArr", '0');
      // queryParams.append("hdnFeeSchemeDetailIdArr", '0');
      // queryParams.append("hdnStudFeeDudtIdArr", '0');
      // queryParams.append("hdnFeeDiscountArr", '0');
      // queryParams.append("hdnLateFeeArr", '0');
      // queryParams.append("hdnMiscFineFee", '0');
      // queryParams.append("getPayAmtFrom", 'Fee');

      queryParams.append("rdoPaymentOptionCode", gatewayCode);

      queryParams.append("accessToken", response['accessToken'].toString());

      final String dueUrl =
          "${school?.schoolFirstServerAddress}${RestAPIs.PAY_MESSAGE_URL}?$queryParams";
      print(dueUrl);
      http.Response _response =
          await http.get(Uri.parse(dueUrl), headers: getHeader);
      print("gateway data ${_response.body}");

      if (_response.statusCode == 200) {
        final jsonResponse = await dataFilter.toJsonResponse(
            callback: ApiAuth.PAY_MESSAGE_CALLBACKS, response: _response.body);
        print("jsonResponse: $jsonResponse");
        log("payment api response $jsonResponse");
        final Map<String, dynamic> content = json.decode(jsonResponse);
        if (content.containsKey('isSuccess') && content['isSuccess']) {
          // Data Exist
          print("conetnt :: $content");
          _success = Success<PaymentMessage>(
              success: PaymentMessage.fromJson(content));
        } else if (!content['isSuccess']) {
          // No Data

          print("No Data");
          return Failure(
              responseStatus: ResponseManiaStatus.FAILED,
              responseMessage: responseFailedMessage);
        } else {
          // Error In response
          return Failure(
              responseStatus: ResponseManiaStatus.FAILED,
              responseMessage: responseFailedMessage);
        }
      }
    } else {
      return Failure(
          responseStatus: ResponseManiaStatus.ERROR,
          responseMessage: responseTokenErrorMessage);
    }
    // } catch (e) {
    //   print("Error Caught In Generating Transactions: ${e.toString()}");

    //   return Failure(
    //       responseStatus: ResponseManiaStatus.ERROR,
    //       responseMessage: internalMessage);
    // }
    notifyListeners();
    return _success;
  }

  // Get PayU Hash
  Future<String?> getHash(Map<String, dynamic> dataSet) async {
    String? _hashValue = null;
    isLoading = true;
    notifyListeners();

    try {
      final _body = json.encode(dataSet);
      print("Hash DataSet: $dataSet");
      final String hashURL = "http://192.168.43.48:3000/generate_hash";
      http.Response _response =
          await http.post(Uri.parse(hashURL), headers: getHeader, body: _body);
      final Map<String, dynamic>? content = json.decode(_response.body);
      print("Hash Content: $content");
      if (_response.statusCode == 200 && content!['status'] == 'success') {
        _hashValue = content['hash'];
      } else {
        // Error In response
        _hashValue = "";
      }
    } catch (e) {
      print("Error Caught In Service: ${e.toString()}");
      _hashValue = null;
    }
    isLoading = false;
    notifyListeners();
    return _hashValue;
  }
}
