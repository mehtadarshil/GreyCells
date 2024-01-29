import 'dart:convert';
import 'dart:developer';

import 'package:greycell_app/src/config/apiauth_config.dart';
import 'package:greycell_app/src/manager/data_manager.dart';
import 'package:greycell_app/src/models/courseModel/course_model.dart';
import 'package:greycell_app/src/models/courseModel/time_table_model.dart';
import 'package:greycell_app/src/models/response/failure.dart';
import 'package:greycell_app/src/models/response/response.dart';
import 'package:greycell_app/src/models/response/success.dart';
import 'package:http/http.dart' as http;
import 'package:greycell_app/src/commons/widgets/query_params.dart';
import 'package:intl/intl.dart';

mixin CourseService on DataManager {
  Map<String, String> get getHeader => {"Content-Type": "application/json"};

  Future<ResponseMania> getCourseDetails({required DateTime date}) async {
    Course _courseDetail;
    Failure _failure;
    Success _success;
    try {
      String tokenUrl =
          "${school?.schoolFirstServerAddress}${RestAPIs.TOKEN_URL}";
      final response = await dataFilter.getToken(
        serverUrl: tokenUrl,
        apiCode: ApiAuth.STDN_TIMETABLE_DTLS /*  ApiAuth.COURSE_API_CODE */,
      );
      if (response != null) {
        final URLQueryParams queryParams = URLQueryParams();
        queryParams.append(
            "callback", "stdnTimeTableDtlCall" /* ApiAuth.COURSE_CALLBACKS */);
        queryParams.append(
            "apiCode", "STDN_TIMETABLE_DTLS" /* ApiAuth.COURSE_API_CODE */);
        queryParams.append("loginUserId", user!.getUserId);
        queryParams.append(
            "txtTimeTableDate", DateFormat("dd-MMM-yyyy").format(date));
        queryParams.append("accessToken", response['accessToken'].toString());

        final String dueUrl =
            "${school?.schoolFirstServerAddress}${RestAPIs.APIStudTimeTableDtl}?$queryParams";
        // final String dueUrl =
        //     "${school?.schoolFirstServerAddress}${RestAPIs.COURSE_URL}?$queryParams";
        print(dueUrl);
        http.Response _response =
            await http.get(Uri.parse(dueUrl), headers: getHeader);

        if (_response.statusCode == 200) {
          log(_response.body);
          RegExp regExp = RegExp(r'{[\s\S]*}');

          // Extract the first match
          var match = regExp.firstMatch(_response.body);

          // final jsonResponse = await dataFilter.toJsonResponse(
          //     callback: ApiAuth.COURSE_CALLBACKS, response: _response.body);

          // final Map<String, dynamic> content = json.decode(jsonResponse);
          // print(content);
          TimeTableModel tableModel =
              TimeTableModel.fromJson(json.decode(match!.group(0)!));
          if (tableModel.isSuccess ?? false) {
            // Data Exist
            _success = Success(success: tableModel);
          } else if (!tableModel.isSuccess!) {
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
        } else {
          print('Status Code: ${_response.statusCode}');
          return Failure(
              responseStatus: ResponseManiaStatus.ERROR,
              responseMessage: 'Not Found');
        }
      } else {
        return Failure(
            responseStatus: ResponseManiaStatus.ERROR,
            responseMessage: responseTokenErrorMessage);
      }
    } catch (e) {
      print('Errro In Catch: $e');
      return Failure(
          responseStatus: ResponseManiaStatus.ERROR,
          responseMessage: internalMessage);
    }
    notifyListeners();
    return _success;
  }
}
