import 'dart:convert';

import 'package:greycell_app/src/config/apiauth_config.dart';
import 'package:greycell_app/src/manager/data_manager.dart';
import 'package:greycell_app/src/models/attendance/attendance_model.dart';
import 'package:http/http.dart' as http;
import 'package:greycell_app/src/commons/widgets/query_params.dart';

mixin AttendanceService on DataManager {
  Map<String, String> get getHeader => {"Content-Type": "application/json"};

  Future<Attendance?> getStudentAttendance() async {
    Attendance? _attendance;
    try {
      String tokenUrl =
          "${school?.schoolFirstServerAddress}${RestAPIs.TOKEN_URL}";
      final response = await dataFilter.getToken(
        serverUrl: tokenUrl,
        apiCode: ApiAuth.ATTENDANCE_API_CODE,
      );
      if (response != null) {
        final URLQueryParams queryParams = URLQueryParams();
        queryParams.append("callback", ApiAuth.ATTENDANCE_CALLBACKS);
        queryParams.append("apiCode", ApiAuth.ATTENDANCE_API_CODE);
        queryParams.append("loginUserId", user!.getUserId);
        queryParams.append("accessToken", response['accessToken'].toString());

        final String att_url =
            "${school?.schoolFirstServerAddress}${RestAPIs.ATTENDANCE_URL}?$queryParams";
        print("Attendance URL: $att_url");
        http.Response _response =
            await http.get(Uri.parse(att_url), headers: getHeader);
        if (_response.statusCode == 200) {
          final jsonResponse = await dataFilter.toJsonResponse(
              callback: ApiAuth.ATTENDANCE_CALLBACKS, response: _response.body);
          final content = json.decode(jsonResponse);
          print(content);
          if (content is String) {
            // If Login Success content type will json(MAP)
            // If It is String then Somehow Response Is Empty => callBacks(" ")
            _attendance = null;
          } else {
            _attendance = Attendance.fromJson(content);
          }
        }
      }
    } catch (e) {
      print(e);
      print("error");
    }
    return _attendance;
  }

  Future<AttendanceEntry?> getSchoolSchemeAttendance(
      {String? dateOfAtdnc}) async {
    AttendanceEntry? _attendance;
    try {
      String tokenUrl =
          "${school?.schoolFirstServerAddress}${RestAPIs.TOKEN_URL}";
      final response = await dataFilter.getToken(
        serverUrl: tokenUrl,
        apiCode: ApiAuth.ATTENDANCE_ENTRY_API_CODE,
      );
      if (response != null) {
        final URLQueryParams queryParams = URLQueryParams();
        queryParams.append("dateOfAtdnc", dateOfAtdnc);
        queryParams.append(
            "callback", ApiAuth.ATTENDANCE_ENTRY_SCHOOL_SCHEME_CALLBACKS);
        queryParams.append("apiCode", ApiAuth.ATTENDANCE_ENTRY_API_CODE);
        queryParams.append("loginUserId", user!.getUserId);
        queryParams.append("accessToken", response['accessToken'].toString());

        final String att_url =
            "${school?.schoolFirstServerAddress}${RestAPIs.ATTENDANCE_ENTRY_SCHOOL_SCHEME_URL}?$queryParams";
        print("Attendance URL: $att_url");
        http.Response _response =
            await http.get(Uri.parse(att_url), headers: getHeader);
        if (_response.statusCode == 200) {
          final jsonResponse = await dataFilter.toJsonResponse(
              callback: ApiAuth.ATTENDANCE_ENTRY_SCHOOL_SCHEME_CALLBACKS,
              response: _response.body);
          final content = json.decode(jsonResponse);
          print(content);
          if (content is String) {
            // If Login Success content type will json(MAP)
            // If It is String then Somehow Response Is Empty => callBacks(" ")
            _attendance = null;
          } else {
            _attendance = AttendanceEntry.fromJson(content);
          }
        }
      }
    } catch (e) {
      print(e);
      print("error");
    }
    return _attendance;
  }

  Future<SchoolPeriod?> getSchoolAttendance(
      {String? dateOfAtdnc, String? cmbPeriodScheme}) async {
    SchoolPeriod? _attendance;
    try {
      String tokenUrl =
          "${school?.schoolFirstServerAddress}${RestAPIs.TOKEN_URL}";
      final response = await dataFilter.getToken(
        serverUrl: tokenUrl,
        apiCode: ApiAuth.ATTENDANCE_ENTRY_API_CODE,
      );
      if (response != null) {
        final URLQueryParams queryParams = URLQueryParams();
        queryParams.append("dateOfAtdnc", dateOfAtdnc);
        queryParams.append(
            "callback", ApiAuth.ATTENDANCE_ENTRY_SCHOOL_CALLBACKS);
        queryParams.append("apiCode", ApiAuth.ATTENDANCE_ENTRY_API_CODE);
        queryParams.append("loginUserId", user!.getUserId);
        queryParams.append("accessToken", response['accessToken'].toString());
        queryParams.append("cmbClassNature", "S");
        queryParams.append("cmbPeriodScheme", cmbPeriodScheme);

        final String att_url =
            "${school?.schoolFirstServerAddress}${RestAPIs.ATTENDANCE_ENTRY_SCHOOL_URL}?$queryParams";
        print("Attendance URL: $att_url");
        http.Response _response =
            await http.get(Uri.parse(att_url), headers: getHeader);
        if (_response.statusCode == 200) {
          final jsonResponse = await dataFilter.toJsonResponse(
              callback: ApiAuth.ATTENDANCE_ENTRY_SCHOOL_CALLBACKS,
              response: _response.body);
          final content = json.decode(jsonResponse);
          print(content);
          if (content is String) {
            // If Login Success content type will json(MAP)
            // If It is String then Somehow Response Is Empty => callBacks(" ")
            _attendance = null;
          } else {
            _attendance = SchoolPeriod.fromJson(content);
          }
        }
      }
    } catch (e) {
      print(e);
      print("error");
    }
    return _attendance;
  }

  Future<GetAttndCriteria?> getAttendanceCriteria(
      {String? dateOfAtdnc,
      String? cmbPeriodScheme,
      String? cmbTimetableId}) async {
    GetAttndCriteria? _attendance;
    try {
      String tokenUrl =
          "${school?.schoolFirstServerAddress}${RestAPIs.TOKEN_URL}";
      final response = await dataFilter.getToken(
        serverUrl: tokenUrl,
        apiCode: ApiAuth.ATTENDANCE_ENTRY_API_CODE,
      );
      if (response != null) {
        final URLQueryParams queryParams = URLQueryParams();
        queryParams.append("dateOfAtdnc", dateOfAtdnc);
        queryParams.append(
            "callback", ApiAuth.ATTENDANCE_ENTRY_CRITERIA_CALLBACKS);
        queryParams.append("apiCode", ApiAuth.ATTENDANCE_ENTRY_API_CODE);
        queryParams.append("loginUserId", user!.getUserId);
        queryParams.append("accessToken", response['accessToken'].toString());
        queryParams.append("cmbClassNature", "S");
        queryParams.append("cmbPeriodScheme", cmbPeriodScheme);
        queryParams.append("cmbTimetableId", cmbTimetableId);

        final String att_url =
            "${school?.schoolFirstServerAddress}${RestAPIs.ATTENDANCE_ENTRY_CRITERIA_URL}?$queryParams";
        print("Attendance URL: $att_url");
        http.Response _response =
            await http.get(Uri.parse(att_url), headers: getHeader);
        if (_response.statusCode == 200) {
          final jsonResponse = await dataFilter.toJsonResponse(
              callback: ApiAuth.ATTENDANCE_ENTRY_CRITERIA_CALLBACKS,
              response: _response.body);
          final content = json.decode(jsonResponse);
          print(content);
          if (content is String) {
            // If Login Success content type will json(MAP)
            // If It is String then Somehow Response Is Empty => callBacks(" ")
            _attendance = null;
          } else {
            _attendance = GetAttndCriteria.fromJson(content);
          }
        }
      }
    } catch (e) {
      print(e);
      print("error");
    }
    return _attendance;
  }

  Future<StudentListDtl?> getAttendanceStudentList(
      {String? cmbCriteria,
      String? dateOfAtdnc,
      String? period,
      String? orderBy}) async {
    StudentListDtl? _attendance;
    try {
      String tokenUrl =
          "${school?.schoolFirstServerAddress}${RestAPIs.TOKEN_URL}";
      final response = await dataFilter.getToken(
        serverUrl: tokenUrl,
        apiCode: ApiAuth.ATTENDANCE_ENTRY_API_CODE,
      );
      if (response != null) {
        final URLQueryParams queryParams = URLQueryParams();
        queryParams.append("dateOfAtdnc", dateOfAtdnc);
        queryParams.append(
            "callback", ApiAuth.ATTENDANCE_ENTRY_STUDLIST_CALLBACKS);
        queryParams.append("apiCode", ApiAuth.ATTENDANCE_ENTRY_API_CODE);
        // queryParams.append("loginUserId", user.getUserId);
        queryParams.append("accessToken", response['accessToken'].toString());
        queryParams.append("cmbClassNature", "S");
        queryParams.append("cmbCriteria", cmbCriteria);
        queryParams.append("period", period);
        queryParams.append("pageId", "CM-ATN-ATTENDANCE");
        queryParams.append("orderBy", orderBy);

        final String att_url =
            "${school?.schoolFirstServerAddress}${RestAPIs.ATTENDANCE_ENTRY_STUDLIST_URL}?$queryParams";
        print("Attendance URL: $att_url");
        http.Response _response =
            await http.get(Uri.parse(att_url), headers: getHeader);
        if (_response.statusCode == 200) {
          final jsonResponse = await dataFilter.toJsonResponse(
              callback: ApiAuth.ATTENDANCE_ENTRY_STUDLIST_CALLBACKS,
              response: _response.body);
          final content = json.decode(jsonResponse);
          print(content);
          if (content is String) {
            // If Login Success content type will json(MAP)
            // If It is String then Somehow Response Is Empty => callBacks(" ")
            _attendance = null;
          } else {
            _attendance = StudentListDtl.fromJson(content);
          }
        }
      }
    } catch (e) {
      print(e);
      print("error");
    }
    return _attendance;
  }

  Future<AttendStatus?> getAttendanceStatus(
      {String? cmbCriteria,
      String? dateOfAtdnc,
      String? period,
      String? orderBy}) async {
    AttendStatus? _attendance;
    try {
      String tokenUrl =
          "${school?.schoolFirstServerAddress}${RestAPIs.TOKEN_URL}";
      final response = await dataFilter.getToken(
        serverUrl: tokenUrl,
        apiCode: ApiAuth.ATTENDANCE_ENTRY_API_CODE,
      );
      if (response != null) {
        final URLQueryParams queryParams = URLQueryParams();
        queryParams.append("dateOfAtdnc", dateOfAtdnc);
        queryParams.append(
            "callback", ApiAuth.ATTENDANCE_ENTRY_STATUS_CALLBACKS);
        queryParams.append("apiCode", ApiAuth.ATTENDANCE_ENTRY_API_CODE);
        queryParams.append("loginUserId", user!.getUserId);
        queryParams.append("accessToken", response['accessToken'].toString());

        final String att_url =
            "${school?.schoolFirstServerAddress}${RestAPIs.ATTENDANCE_ENTRY_STATUS_URL}?$queryParams";
        print("Attendance URL: $att_url");
        http.Response _response =
            await http.get(Uri.parse(att_url), headers: getHeader);
        if (_response.statusCode == 200) {
          final jsonResponse = await dataFilter.toJsonResponse(
              callback: ApiAuth.ATTENDANCE_ENTRY_STATUS_CALLBACKS,
              response: _response.body);
          final content = json.decode(jsonResponse);
          print(content);
          if (content is String) {
            // If Login Success content type will json(MAP)
            // If It is String then Somehow Response Is Empty => callBacks(" ")
            _attendance = null;
          } else {
            _attendance = AttendStatus.fromJson(content);
          }
        }
      }
    } catch (e) {
      print(e);
      print("error");
    }
    return _attendance;
  }

  Future<AttendanceSave?> attendSave(
      {String? cmbCriteria,
      String? dateOfAtdnc,
      String? period,
      String? cmbSection,
      String? subject,
      String? stdTTGrpId,
      String? facility,
      String? hdnClassId,
      List<StudVector>? studVectorList}) async {
    AttendanceSave? _attendance;
    try {
      String tokenUrl =
          "${school?.schoolFirstServerAddress}${RestAPIs.TOKEN_URL}";
      final response = await dataFilter.getToken(
        serverUrl: tokenUrl,
        apiCode: ApiAuth.ATTENDANCE_ENTRY_API_CODE,
      );
      if (response != null) {
        final URLQueryParams queryParams = URLQueryParams();
        queryParams.append("callback", ApiAuth.ATTENDANCE_ENTRY_SAVE_CALLBACKS);
        queryParams.append("loginUserId", user!.getUserId);
        queryParams.append("cmbClassNature", "S");
        queryParams.append("dateOfAtdnc", dateOfAtdnc);
        queryParams.append("hdnClassId", hdnClassId);
        queryParams.append("period", period);
        queryParams.append("cmbSection", cmbSection);
        queryParams.append("subject", subject);
        queryParams.append("stdTTGrpId", stdTTGrpId);
        queryParams.append("facility", facility);
        queryParams.append("cmbCriteria", cmbCriteria);
        queryParams.append("pageId", "CM-ATN-ATTENDANCE");
        queryParams.append("apiCode", ApiAuth.ATTENDANCE_ENTRY_API_CODE);
        queryParams.append("accessToken", response['accessToken'].toString());
        String qp = "";
        for (int i = 0; i < studVectorList!.length; i++) {
          qp = qp +
              "&hdnStudEnrolIdArr=${studVectorList[i].studEnrolId}&chkAtndcStatusArr=${studVectorList[i].attendanceTypeId}";
          // queryParams.append(
          //     "hdnStudEnrolIdArr", studVectorList[i].studEnrolId);
          // queryParams.append(
          //     "chkAtndcStatusArr${i}", studVectorList[i].attendanceTypeId);
        }
        final String att_url =
            "${school?.schoolFirstServerAddress}${RestAPIs.ATTENDANCE_ENTRY_SAVE_URL}?$queryParams$qp";
        print("Attendance URL: $att_url");
        http.Response _response =
            await http.get(Uri.parse(att_url), headers: getHeader);
        if (_response.statusCode == 200) {
          final jsonResponse = await dataFilter.toJsonResponse(
              callback: ApiAuth.ATTENDANCE_ENTRY_SAVE_CALLBACKS,
              response: _response.body);
          final content = json.decode(jsonResponse);
          print(content);
          if (content is String) {
            // If Login Success content type will json(MAP)
            // If It is String then Somehow Response Is Empty => callBacks(" ")
            _attendance = null;
          } else {
            _attendance = AttendanceSave.fromJson(content);
          }
        }
      }
    } catch (e) {
      print(e);
      print("error");
    }
    return _attendance;
  }
}
