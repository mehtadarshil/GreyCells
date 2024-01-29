import 'dart:convert';

import 'package:greycell_app/src/config/apiauth_config.dart';
import 'package:greycell_app/src/manager/data_manager.dart';
import 'package:greycell_app/src/models/response/failure.dart';
import 'package:greycell_app/src/models/response/response.dart';
import 'package:greycell_app/src/models/response/success.dart';
import 'package:greycell_app/src/models/timeTable/TimeTable.dart';
import 'package:http/http.dart' as http;
import 'package:greycell_app/src/commons/widgets/query_params.dart';

mixin TimeTableService on DataManager {
  Map<String, String> get getHeader => {"Content-Type": "application/json"};

  Future<ResponseMania?> getTimeTable({String? asOnDate}) async {
    List<TimeTable> _timeTables;
    isLoading = true;
    notifyListeners();

    Failure _failure;
    Success? success;
    try {
      String tokenUrl =
          "${school?.schoolFirstServerAddress}${RestAPIs.TOKEN_URL}";
      final response = await dataFilter.getToken(
        serverUrl: tokenUrl,
        apiCode: ApiAuth.STAFF_TIMETABLE_API_CODE,
      );
      if (response != null) {
        final URLQueryParams queryParams = URLQueryParams();
        queryParams.append("callback", ApiAuth.STAFF_TIMETABLE_CALLBACKS);
        queryParams.append("apiCode", ApiAuth.STAFF_TIMETABLE_API_CODE);
        queryParams.append("asOnDate", asOnDate);
        queryParams.append("loginUserId", user!.getUserId);
//        queryParams.append("loginUserId", "Admin@2");
        queryParams.append("accessToken", response['accessToken'].toString());

        final String timeTableUrl =
            "${school?.schoolFirstServerAddress}${RestAPIs.STAFF_TIMETABLE_URL}?$queryParams";
        print("I Am Hear.......");
        print(timeTableUrl);
        print("I Am Hear.......");
        http.Response _response =
            await http.get(Uri.parse(timeTableUrl), headers: getHeader);

        if (_response.statusCode == 200) {
          final jsonResponse = await dataFilter.toJsonResponse(
              callback: ApiAuth.STAFF_TIMETABLE_CALLBACKS,
              response: _response.body);
          _timeTables = <TimeTable>[];

          final Map<String, dynamic> content = json.decode(jsonResponse);
          print(content);
          if (content.containsKey('isSuccess') &&
              content['getPeriodVector'] != null) {
            // Data Exist
            List collection = content['getPeriodVector'];
            _timeTables = collection
                .map((vector) => TimeTable.fromVector(vector))
                .toList();
            success = Success(success: _timeTables);
          } else {
            // No Data
            print("No TimeTable");
            return Failure(
                responseStatus: ResponseManiaStatus.FAILED,
                responseMessage: responseFailedMessage);
          }
        }
      }
    } catch (e) {
      print("Error Caught In TimeTable: ${e.toString()}");
      return Failure(
          responseStatus: ResponseManiaStatus.ERROR,
          responseMessage: responseFailedMessage);
    }
    isLoading = false;
    notifyListeners();
    return success;
  }
}
