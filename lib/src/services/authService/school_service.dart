import 'dart:convert';

import 'package:greycell_app/src/config/apiauth_config.dart';
import 'package:greycell_app/src/manager/data_manager.dart';
import 'package:greycell_app/src/models/school/school.dart';
import 'package:http/http.dart' as http;
import 'package:greycell_app/src/commons/widgets/query_params.dart';
import 'package:shared_preferences/shared_preferences.dart';

mixin SchoolService on DataManager {
  // Get headers Map
  Map<String, String> get getHeader => {"Content-Type": "application/json"};

  Future<ResponseStatus> schoolValidate({String? schoolCode}) async {
    ResponseStatus status = ResponseStatus.INITIAL;
    try {
      isLoading = true;
      notifyListeners();
      final response = await dataFilter.getToken(
          apiCode: ApiAuth.SCHOOL_VERIFY_API_CODE,
          serverUrl: RestAPIs.GREYCELL_TOKEN_URL);

      if (response != null) {
        final URLQueryParams queryParams = URLQueryParams();
        queryParams.append("callback", ApiAuth.SCHOOL_VERIFY_CALLBACKS);
        queryParams.append("apiCode", ApiAuth.SCHOOL_VERIFY_API_CODE);
        queryParams.append("clientCode", schoolCode);
        queryParams.append("accessToken", response['accessToken'].toString());

        final String url =
            "${RestAPIs.GREYCELL_SCHOOL_VALIDATE_URL}?$queryParams";
        http.Response _response =
            await http.get(Uri.parse(url), headers: getHeader);
        if (_response.statusCode == 200) {
          final jsonResponse = await dataFilter.toJsonResponse(
              callback: ApiAuth.SCHOOL_VERIFY_CALLBACKS,
              response: _response.body);
          final content = json.decode(jsonResponse);
          if (content['isSuccess'] && content['getClientListVec'] != null) {
            await saveSchoolData(content['getClientListVec'][0]);
            status = ResponseStatus.SUCCESS;
          } else {
            status = ResponseStatus.FAILURE;
          }
        } else {
          status = ResponseStatus.ERROR;
        }
      } else {
        status = ResponseStatus.ERROR;
      }
    } catch (e) {
      print(e);
      status = ResponseStatus.ERROR;
    }
    isLoading = false;
    notifyListeners();
    return status;
  }

  Future<void> saveSchoolData(List schoolInfo) async {
    school = await School(
        schoolRank: schoolInfo[0].toString(),
        schoolName: schoolInfo[1].toString(),
        schoolFullName: schoolInfo[2].toString(),
        schoolCode: schoolInfo[3].toString(),
        schoolFirstServerAddress: schoolInfo[4].toString(),
        schoolSecondServerAddress: schoolInfo[5].toString(),
        schoolLogo: schoolInfo[4] + "/images/logos/Logo.jpg",
        schoolStatus: schoolInfo[6].toString());
    print(school?.schoolFirstServerAddress);
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("schoolRank", schoolInfo[0]);
    prefs.setString("schoolName", schoolInfo[1]);
    prefs.setString("schoolFullName", schoolInfo[2]);
    prefs.setString("schoolCode", schoolInfo[3]);
    prefs.setString("schoolFirstServerAddress", schoolInfo[4]);
    prefs.setString("schoolSecondServerAddress", schoolInfo[5]);
    prefs.setString("schoolLogo", schoolInfo[4] + "/images/logos/Logo.jpg");
    prefs.setString("schoolStatus", schoolInfo[6]);

    print("Successfully Saved ${prefs.get('schoolFirstServerAddress')}");
    notifyListeners();
  }

  void autoSchoolValidate() async {
    print("Auto autoSchoolValidate Called");
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? schoolStatus = prefs.get("schoolStatus") as String?;
    print("School Status: $schoolStatus");
    final String? schoolServer =
        prefs.get("schoolFirstServerAddress") as String?;
    if (schoolStatus != null && schoolServer != null) {
      final String schoolRank = prefs.getString("schoolRank")!;
      final String schoolName = prefs.getString("schoolName")!;
      final String schoolFullName = prefs.getString("schoolFullName")!;
      final String schoolCode = prefs.getString("schoolCode")!;
      final String schoolFirstServerAddress =
          prefs.getString("schoolFirstServerAddress")!;
      final String schoolSecondServerAddress =
          prefs.getString("schoolSecondServerAddress")!;
      final String schoolStatus = prefs.getString("schoolStatus")!;
      final String? schoolLogo = prefs.getString("schoolLogo");

      print(schoolRank +
          schoolName +
          schoolFullName +
          schoolCode +
          schoolSecondServerAddress +
          schoolFirstServerAddress +
          schoolStatus);

      school = await School(
          schoolLogo: schoolLogo,
          schoolStatus: schoolStatus,
          schoolSecondServerAddress: schoolSecondServerAddress,
          schoolFirstServerAddress: schoolFirstServerAddress,
          schoolCode: schoolCode,
          schoolFullName: schoolFullName,
          schoolName: schoolName,
          schoolRank: schoolRank);
      print(
          "School Server Data From Auto Validate : ${school?.schoolFirstServerAddress}");
      notifyListeners();
      print("Auto autoSchoolValidate Ended ");
    }
  }
}
