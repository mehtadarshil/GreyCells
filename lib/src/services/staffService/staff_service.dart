import 'dart:convert';

import 'package:greycell_app/src/config/apiauth_config.dart';
import 'package:greycell_app/src/manager/data_manager.dart';
import 'package:greycell_app/src/models/user/staff_model.dart';
import 'package:greycell_app/src/models/user/user.dart';
import 'package:http/http.dart' as http;
import 'package:greycell_app/src/commons/widgets/query_params.dart';
import 'package:shared_preferences/shared_preferences.dart';

mixin StaffService on DataManager {
  Map<String, String> get getHeader => {"Content-Type": "application/json"};

  Future<Staff?> getStaffProfile() async {
    Staff? _staff;
    try {
      String tokenUrl =
          "${school?.schoolFirstServerAddress}${RestAPIs.TOKEN_URL}";
      final response = await dataFilter.getToken(
        serverUrl: tokenUrl,
        apiCode: ApiAuth.STAFF_PPROFILE_API_CODE,
      );
      if (response != null) {
        final URLQueryParams queryParams = URLQueryParams();
        queryParams.append("callback", ApiAuth.STAFF_PPROFILE_CALLBACKS);
        queryParams.append("apiCode", ApiAuth.STAFF_PPROFILE_API_CODE);
        queryParams.append("loginUserId", user!.getUserId);
        queryParams.append("accessToken", response['accessToken'].toString());

        final String profile_url =
            "${school?.schoolFirstServerAddress}${RestAPIs.STAFF_PROFILE_URL}?$queryParams";
        http.Response _response =
            await http.get(Uri.parse(profile_url), headers: getHeader);
//        print(_response.body);
        if (_response.statusCode == 200) {
          final jsonResponse = await dataFilter.toJsonResponse(
              callback: ApiAuth.STAFF_PPROFILE_CALLBACKS,
              response: _response.body);
          final content = json.decode(jsonResponse);
          if (content is String) {
            /// Response is Empty => callBacks("")
            _staff = null;
          } else {
            _staff = Staff.fromJson(content);
            staff = _staff;
            _saveToDevice(_staff);
            notifyListeners();
          }
        }
      }
    } catch (e) {
      print(e);
    }
    return _staff;
  }

  Future<MyMenu?> getMyMenu() async {
    MyMenu? _myMenu;
    try {
      String tokenUrl =
          "${school?.schoolFirstServerAddress}${RestAPIs.TOKEN_URL}";
      final response = await dataFilter.getToken(
        serverUrl: tokenUrl,
        apiCode: ApiAuth.MENU_LIST_API_CODE,
      );
      if (response != null) {
        final URLQueryParams queryParams = URLQueryParams();
        queryParams.append("callback", ApiAuth.MENU_LIST_CALLBACKS);
        queryParams.append("apiCode", ApiAuth.MENU_LIST_API_CODE);
        queryParams.append("loginUserId", user!.getUserId);
        queryParams.append("accessToken", response['accessToken'].toString());

        final String att_url =
            "${school?.schoolFirstServerAddress}${RestAPIs.MENU_LIST_URL}?$queryParams";
        print("My Menu URL: $att_url");
        http.Response _response =
            await http.get(Uri.parse(att_url), headers: getHeader);
        if (_response.statusCode == 200) {
          final jsonResponse = await dataFilter.toJsonResponse(
              callback: ApiAuth.MENU_LIST_CALLBACKS, response: _response.body);
          final content = json.decode(jsonResponse);
          print("@@@@@${content}");
          if (content is String) {
            // If Login Success content type will json(MAP)
            // If It is String then Somehow Response Is Empty => callBacks(" ")
            _myMenu = null;
          } else {
            _myMenu = MyMenu.fromJson(content);
          }
        }
      }
    } catch (e) {
      print(e);
      print("error");
    }
    return _myMenu;
  }
}

void _saveToDevice(Staff _staff) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString("getState", "${_staff.getState}");
  prefs.setString("getCountry", "${_staff.getCountry ?? ''}");
  prefs.setString("getAadharNo", "${_staff.getAadharNo ?? ''}");
  prefs.setString("getSpouseName", "${_staff.getSpouseName}");
  prefs.setString("getDesignationType", "${_staff.getDesignationType}");
  prefs.setString("getDesignation", _staff.getDesignation!);
  prefs.setString("getDOBTillDateInDays", _staff.getDOBTillDateInDays!);

  prefs.setString("getDateOfBirth", _staff.getDateOfBirth!);
  prefs.setString("getAddressLine3", _staff.getAddressLine3!);
  prefs.setString("getEmail", _staff.getEmail!);
  prefs.setString("getGender", _staff.getGender!);
  prefs.setString("getFatherName", _staff.getFatherName!);
  prefs.setString("getStaffCode", _staff.getStaffCode!);
  prefs.setString("getPin", _staff.getPin!);
  prefs.setString("getCity", _staff.getCity!);
  prefs.setString("getBloodGroup", _staff.getBloodGroup!);
  prefs.setString("getAddressLine1", _staff.getAddressLine1!);
  prefs.setString("getAddressLine2", _staff.getAddressLine2!);
  prefs.setString("getUserId", _staff.getUserId!);
  prefs.setString("getStaffName", _staff.getStaffName!);
  prefs.setString("getDepartment", _staff.getDepartment!);
  prefs.setString("getPanNo", _staff.getPanNo!);
  prefs.setString("getMobileNo", _staff.getMobileNo!);
  prefs.setString("getSalutation", _staff.getSalutation!);
  prefs.setString("getWebPhotoPath", _staff.getWebPhotoPath!);
  prefs.setString("getMaritalStatus", _staff.getMaritalStatus!);
}
