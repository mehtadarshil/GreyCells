import 'dart:convert';

import 'package:greycell_app/src/config/apiauth_config.dart';
import 'package:greycell_app/src/config/core_config.dart';
import 'package:greycell_app/src/manager/data_manager.dart';
import 'package:greycell_app/src/models/coreModel/package_info.dart';
import 'package:greycell_app/src/models/student/student_model.dart';
import 'package:greycell_app/src/models/user/staff_model.dart';
import 'package:greycell_app/src/models/user/user.dart';
import 'package:http/http.dart' as http;
import 'package:package_info/package_info.dart';
import 'package:greycell_app/src/commons/widgets/query_params.dart';
import 'package:shared_preferences/shared_preferences.dart';

mixin AuthService on DataManager {
  Map<String, String> get getHeader => {"Content-Type": "application/json"};

  Future<ResponseStatus> onLogin(
      {required String userId, required String password}) async {
    ResponseStatus status = ResponseStatus.INITIAL;
    try {
      isLoading = true;
      notifyListeners();
      String tokenUrl =
          "${school?.schoolFirstServerAddress}${RestAPIs.TOKEN_URL}";

      final response = await dataFilter.getToken(
        serverUrl: tokenUrl,
        apiCode: ApiAuth.LOGIN_API_CODE,
      );
      if (response != null) {
        final URLQueryParams queryParams = URLQueryParams();
        queryParams.append("callback", ApiAuth.LOGIN_CALLBACKS);
        queryParams.append("apiCode", ApiAuth.LOGIN_API_CODE);
        queryParams.append("userId", userId);
        queryParams.append("password", password);
        queryParams.append("AccReqrd", "A");
        queryParams.append("accessToken", response['accessToken'].toString());

        final String loginUrl =
            "${school?.schoolFirstServerAddress}${RestAPIs.LOGIN_URL}?$queryParams";
        print("Login Url: $loginUrl");
        http.Response _response =
            await http.get(Uri.parse(loginUrl), headers: getHeader);
        print(_response.body);
        if (_response.statusCode == 200) {
          print(_response.body);
          final jsonResponse = await dataFilter.toJsonResponse(
              callback: ApiAuth.LOGIN_CALLBACKS, response: _response.body);
          final Map<String, dynamic> content = json.decode(jsonResponse);
          print("User Data: $content");
          if (!content.containsKey('isSuccess')) {
            status = ResponseStatus.FAILURE;
          } else {
            if (content['isSuccess'] && content['isLoggedIn']) {
              user = User.fromJson(content);
              saveDataOnApp(content);
              status = ResponseStatus.SUCCESS;
            } else {
              status = ResponseStatus.FAILURE;
            }
          }
        } else {
          status = ResponseStatus.ERROR;
        }
      }
    } catch (e) {
      print(e);
      status = ResponseStatus.ERROR;
    }
    isLoading = false;
    notifyListeners();
    return status;
  }

  void saveDataOnApp(Map<String, dynamic> response) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    isLoggedIn = true;
    prefs.setString("userId", response['getUserId']);
    prefs.setString("userWingId", response['getUserWingId']);
    prefs.setString("getUserType", response['getUserType']);
    prefs.setBool("isLoggedIn", isLoggedIn!);

    print("Save Successfully !!!!");
  }

  void autoAuthenticateUser() async {
//    await schoolService.autoSchoolValidate();
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final bool? isUserLoggedIn = prefs.getBool("isLoggedIn");
      final String? userId = prefs.getString("userId");

      print(isUserLoggedIn);
      if (isUserLoggedIn != null && userId != null) {
        final String? userWingId = prefs.getString("userWingId");
        final String? getUserType = prefs.getString("getUserType");
        final bool? _isLoggedin = prefs.getBool("isLoggedIn");

        if (getUserType == Core.STUDENT_USER) {
          // Student Info
          final String? studentFirstName =
              await prefs.getString("studentFirstName");
          final String? studentMiddleName =
              await prefs.getString("studentMiddleName");
          final String? studentLastName =
              await prefs.getString("studentLastName");
          final String? studentEmail = await prefs.getString("studentEmail");
          final String? studentEmailDomain =
              await prefs.getString("studentEmailDomain");
          final String? studentImageUrl =
              await prefs.getString("studentImageUrl");

          final String? studentAddress =
              await prefs.getString("studentAddress");
          final String? studentGuardianAddress =
              await prefs.getString("studentGuardianAddress");
          final String? studentMobileNo =
              await prefs.getString("studentMobileNo");
          final String? studentGuardianMobileNo =
              await prefs.getString("studentGuardianMobileNo");

          student = Student(
              getUserId: userId,
              getFirstName: studentFirstName,
              getMiddleName: studentMiddleName,
              getLastName: studentLastName,
              getEmail: studentEmail,
              getPersonalEmailDomainId: studentEmailDomain,
              getWebPhotoPath: studentImageUrl,
              getAddress: studentAddress,
              getGuardianAddress: studentGuardianAddress,
              getMobileNo: studentMobileNo,
              getGuardianMobile: studentGuardianMobileNo);
        } else if (getUserType == Core.STAFF_USER) {
          await _updateStaff();
        }

        final Map<String, dynamic> json = {
          "getUserId": userId,
          "getUserWingId": userWingId,
          "getUserType": getUserType
        };
        user = User.fromJson(json);
        isLoggedIn = _isLoggedin;
      } else {
        print("User is Not Logged In Currently");
      }
    } catch (e) {
      print(e);
      user = null;
    }
    notifyListeners();
  }

  _updateStaff() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final String? getState = await prefs.getString("getState");
    final String? getCountry = await prefs.getString("getCountry");
    final String? getAadharNo = await prefs.getString("getAadharNo");
    final String? getSpouseName = await prefs.getString("getSpouseName");
    final String? getDesignationType =
        await prefs.getString("getDesignationType");
    final String? getDesignation = await prefs.getString("getDesignation");
    final String? getDOBTillDateInDays =
        await prefs.getString("getDOBTillDateInDays");

    final String? getDateOfBirth = await prefs.getString("getDateOfBirth");
    final String? getAddressLine3 = await prefs.getString("getAddressLine3");
    final String? getEmail = await prefs.getString("getEmail");
    final String? getGender = await prefs.getString("getGender");
    final String? getFatherName = await prefs.getString("getFatherName");
    final String? getStaffCode = await prefs.getString(
      "getStaffCode",
    );
    final String? getPin = await prefs.getString("getPin");
    final String? getCity = await prefs.getString("getCity");
    final String? getBloodGroup = await prefs.getString("getBloodGroup");
    final String? getAddressLine1 = await prefs.getString("getAddressLine1");
    final String? getAddressLine2 = await prefs.getString("getAddressLine2");
    final String? getUserId = await prefs.getString("getUserId");
    final String? getStaffName = await prefs.getString("getStaffName");
    final String? getDepartment = await prefs.getString("getDepartment");
    final String? getPanNo = await prefs.getString("getPanNo");
    final String? getMobileNo = await prefs.getString("getMobileNo");
    final String? getSalutation = await prefs.getString("getSalutation");
    final String? getWebPhotoPath = await prefs.getString("getWebPhotoPath");
    final String? getMaritalStatus = await prefs.getString("getMaritalStatus");

    staff = Staff(
      getPin: getPin,
      getStaffCode: getStaffCode,
      getFatherName: getFatherName,
      getGender: getGender,
      getEmail: getEmail,
      getAddressLine3: getAddressLine3,
      getMaritalStatus: getMaritalStatus,
      getDateOfBirth: getDateOfBirth,
      getDOBTillDateInDays: getDOBTillDateInDays,
      getWebPhotoPath: getWebPhotoPath,
      getSalutation: getSalutation,
      getDesignation: getDesignation,
      getDesignationType: getDesignationType,
      getMobileNo: getMobileNo,
      getPanNo: getPanNo,
      getCountry: getCountry,
      getDepartment: getDepartment,
      getState: getState,
      getSpouseName: getSpouseName,
      getStaffName: getStaffName,
      getAadharNo: getAadharNo,
      getUserId: getUserId,
      getAddressLine2: getAddressLine2,
      getAddressLine1: getAddressLine1,
      getBloodGroup: getBloodGroup,
      getCity: getCity,
    );
    print("getStaffName: $getStaffName");
    return null;
  }

  Future<void> handleVersion() async {
    final PackageInfo info = await PackageInfo.fromPlatform();
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      final _version = info.version;
      final _buildNumber = info.buildNumber;
      final _packageName = info.packageName;
      gCPackageInfo = GCPackageInfo(
          appName: info.appName,
          buildNumber: _buildNumber,
          packageName: _packageName,
          version: _version);
      final String? getVersion = prefs.getString("version");
      final String? getPackageName = prefs.getString("packageName");
      final String? getBuildNumber = prefs.getString("buildNumber");

      if ((getVersion == null || getVersion != _version)) {
        prefs.clear();
        _reset();
        prefs.setString("version", _version);
        prefs.setString("packageName", _packageName);
        prefs.setString("buildNumber", _buildNumber);
        print("Version Mismatch");
      }
    } catch (e) {
      print("Error Caught In Version Checking: ${e.toString()}");
      prefs.clear();
      _reset();
    }
    notifyListeners();
  }

  void _reset() {
    user = null;
    student = null;
    currentExamIndex = 0;
    currentSessionIndex = 0;
    examList = [];
    subjectMarkList = [];
    availableSessionList = [];
    isLoggedIn = false;
  }

  void logoutUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("userWingId");
    prefs.remove("userId");
    prefs.setBool("isLoggedIn", false);
    _reset();
    notifyListeners();
  }
}
