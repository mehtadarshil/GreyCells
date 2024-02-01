import 'dart:convert';
import 'dart:developer';

import 'package:greycell_app/src/config/apiauth_config.dart';
import 'package:greycell_app/src/manager/data_manager.dart';
import 'package:greycell_app/src/models/student/student_model.dart';
import 'package:http/http.dart' as http;
import 'package:greycell_app/src/commons/widgets/query_params.dart';
import 'package:shared_preferences/shared_preferences.dart';

mixin StudentService on DataManager {
  Map<String, String> get getHeader => {"Content-Type": "application/json"};

  Future<Student?> getStudentProfile() async {
    Student? _student;
    try {
      String tokenUrl =
          "${school?.schoolFirstServerAddress}${RestAPIs.TOKEN_URL}";
      final response = await dataFilter.getToken(
        serverUrl: tokenUrl,
        apiCode: ApiAuth.STUDENT_INFO_API_CODE,
      );
      if (response != null) {
        final URLQueryParams queryParams = URLQueryParams();
        queryParams.append("callback", ApiAuth.STUDENT_INFO_CALLBACKS);
        queryParams.append("apiCode", ApiAuth.STUDENT_INFO_API_CODE);
        queryParams.append("loginUserId", user!.getUserId);
        queryParams.append("accessToken", response['accessToken'].toString());

        final String profile_url =
            "${school?.schoolFirstServerAddress}${RestAPIs.PROFILE_URL}?$queryParams";
        print("URL: ${profile_url}");
        http.Response _response =
            await http.get(Uri.parse(profile_url), headers: getHeader);
//        print(_response.body);
        if (_response.statusCode == 200) {
          final jsonResponse = await dataFilter.toJsonResponse(
              callback: ApiAuth.STUDENT_INFO_CALLBACKS,
              response: _response.body);
          final content = json.decode(jsonResponse);
          if (content is String) {
            /// Response is Empty => callBacks("")
            _student = null;
          } else {
            _student = Student.fromJson(content);
            student = _student;
            _saveToDevice(_student);
            notifyListeners();
          }
        }
      }
    } catch (e) {
      print(e);
    }
    return _student;
  }
}

void _saveToDevice(Student _student) async {
  log(_student.toJson().toString(), name: "student_data");
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString("studentFirstName", "${_student.getFirstName}");
  prefs.setString("studentMiddleName", "${_student.getMiddleName ?? ''}");
  prefs.setString("studentLastName", "${_student.getLastName ?? ''}");
  prefs.setString("studentEmail", "${_student.getEmail}");
  prefs.setString("studentEmailDomain", "${_student.getEmailDomainId}");
  prefs.setString("studentImageUrl", _student.getWebPhotoPath!);
  prefs.setString("studentUserId", _student.getUserId!);
  prefs.setString("studentId", _student.getStudentId ?? "");
  prefs.setString("studentAddress", _student.getAddress!);
  prefs.setString("studentGuardianAddress", _student.getGuardianAddress!);
  prefs.setString("studentMobileNo", _student.getMobileNo!);
  prefs.setString("studentGuardianMobileNo", _student.getGuardianMobile!);
}
