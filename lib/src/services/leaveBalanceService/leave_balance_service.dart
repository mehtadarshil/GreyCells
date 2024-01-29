import 'dart:convert';

import 'package:greycell_app/src/config/apiauth_config.dart';
import 'package:greycell_app/src/manager/data_manager.dart';
import 'package:greycell_app/src/models/leaveBalanceModel/leave_balance_model.dart';
import 'package:greycell_app/src/models/response/failure.dart';
import 'package:greycell_app/src/models/response/response.dart';
import 'package:greycell_app/src/models/response/success.dart';
import 'package:http/http.dart' as http;
import 'package:greycell_app/src/commons/widgets/query_params.dart';

mixin LeaveBalanceService on DataManager {
  Map<String, String> get getHeader => {"Content-Type": "application/json"};

  Future<ResponseMania?> getLeaveBalance({String? asOnDate}) async {
    LeaveBalance? _leaveDetail;
    isLoading = true;
    notifyListeners();

    Failure _failure;
    Success? success;
    try {
      String tokenUrl =
          "${school?.schoolFirstServerAddress}${RestAPIs.TOKEN_URL}";
      final response = await dataFilter.getToken(
        serverUrl: tokenUrl,
        apiCode: ApiAuth.STAFF_LEAVE_BALANCE_API_CODE,
      );
      if (response != null) {
        final URLQueryParams queryParams = URLQueryParams();
        queryParams.append("callback", ApiAuth.STAFF_LEAVE_BALANCE_CALLBACKS);
        queryParams.append("apiCode", ApiAuth.STAFF_LEAVE_BALANCE_API_CODE);
        queryParams.append("asOnDate", asOnDate);
        queryParams.append("loginUserId", user!.getUserId);
        queryParams.append("accessToken", response['accessToken'].toString());

        final String att_url =
            "${school?.schoolFirstServerAddress}${RestAPIs.STAFF_LEAVE_BALANCE_URL}?$queryParams";
        print("Leave Balance URL: $att_url");
        http.Response _response =
            await http.get(Uri.parse(att_url), headers: getHeader);

        if (_response.statusCode == 200) {
          final jsonResponse = await dataFilter.toJsonResponse(
              callback: ApiAuth.STAFF_LEAVE_BALANCE_CALLBACKS,
              response: _response.body);
          final content = json.decode(jsonResponse);
          print(content);
          if (content is String) {
            // If Login Success content type will json(MAP)
            // If It is String then Somehow Response Is Empty => callBacks(" ")
            _leaveDetail = null;
            return Failure(
                responseStatus: ResponseManiaStatus.FAILED,
                responseMessage: responseFailedMessage);
          } else {
            _leaveDetail = LeaveBalance.fromJson(content);
            success = Success(success: _leaveDetail);
          }
          // final Map<String, dynamic> content = json.decode(jsonResponse);
          // print(content);
          // if (content.containsKey('isSuccess') &&
          //     content['getLeaveStatusVector'] != null) {
          //   final content = json.decode(jsonResponse);
          //   _leaveDetail = LeaveDetail.fromJson(content);
          //   success = Success(success: _leaveDetail);
          // } else {
          //   // No Data
          //   print("No TimeTable");
          //   return Failure(
          //       responseStatus: ResponseManiaStatus.FAILED,
          //       responseMessage: responseFailedMessage);
          // }
        }
      }
    } catch (e) {
      print("Error Caught In Leave Balance: ${e.toString()}");
      return Failure(
          responseStatus: ResponseManiaStatus.ERROR,
          responseMessage: responseFailedMessage);
    }
    isLoading = false;
    notifyListeners();
    return success;
  }

  Future<LeaveBalance?> getLeaveBalance1({String? asOnDate}) async {
    LeaveBalance? _examReport;
    try {
      String tokenUrl =
          "${school?.schoolFirstServerAddress}${RestAPIs.TOKEN_URL}";
      final response = await dataFilter.getToken(
        serverUrl: tokenUrl,
        apiCode: ApiAuth.STAFF_LEAVE_BALANCE_API_CODE,
      );
      if (response != null) {
        final URLQueryParams queryParams = URLQueryParams();
        queryParams.append("callback", ApiAuth.STAFF_LEAVE_BALANCE_CALLBACKS);
        queryParams.append("apiCode", ApiAuth.STAFF_LEAVE_BALANCE_API_CODE);
        queryParams.append("asOnDate", asOnDate);
        queryParams.append("loginUserId", user!.getUserId);
        queryParams.append("accessToken", response['accessToken'].toString());

        final String att_url =
            "${school?.schoolFirstServerAddress}${RestAPIs.STAFF_LEAVE_BALANCE_URL}?$queryParams";
        print("Leave Balance URL: $att_url");
        http.Response _response =
            await http.get(Uri.parse(att_url), headers: getHeader);
        if (_response.statusCode == 200) {
          final jsonResponse = await dataFilter.toJsonResponse(
              callback: ApiAuth.STAFF_LEAVE_BALANCE_CALLBACKS,
              response: _response.body);
          final content = json.decode(jsonResponse);
          print(content);
          if (content is String) {
            // If Login Success content type will json(MAP)
            // If It is String then Somehow Response Is Empty => callBacks(" ")
            _examReport = null;
          } else {
            _examReport = LeaveBalance.fromJson(content);
          }
        }
      }
    } catch (e) {
      print(e);
      print("error");
    }
    return _examReport;
  }
}
