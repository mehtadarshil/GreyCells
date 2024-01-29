import 'dart:convert';

import 'package:greycell_app/src/commons/widgets/query_params.dart';
import 'package:greycell_app/src/config/apiauth_config.dart';
import 'package:greycell_app/src/manager/data_manager.dart';
import 'package:greycell_app/src/models/analysis/available_term.dart';
import 'package:greycell_app/src/models/analysis/subject_mark.dart';
import 'package:greycell_app/src/models/analysis/termwise_exam.dart';
import 'package:http/http.dart' as http;

mixin AnalysisService on DataManager {
  Map<String, String> get getHeader => {"Content-Type": "application/json"};

  Future<List<dynamic>> getAvailSession() async {
    List<AvailableSession>? _sessionList;
    List<Exam>? _exmList;
    List<SubjectMark>? _subMarkList;
    List<dynamic> dataSet;
    try {
      String tokenUrl =
          "${school?.schoolFirstServerAddress}${RestAPIs.TOKEN_URL}";
      final tokenResponse = await dataFilter.getToken(
        serverUrl: tokenUrl,
        apiCode: ApiAuth.AVAILABLE_SESSION_API_CODE,
      );
      if (tokenResponse != null) {
        final URLQueryParams queryParams = URLQueryParams();
        queryParams.append("callback", ApiAuth.AVAILABLE_SESSION_CALLBACKS);
        queryParams.append("apiCode", ApiAuth.AVAILABLE_SESSION_API_CODE);
        queryParams.append("userWingId", user!.getUserWingId);
        queryParams.append("loginUserId", user!.getUserId);
        queryParams.append(
            "accessToken", tokenResponse['accessToken'].toString());

        final String sessionUrl =
            "${school?.schoolFirstServerAddress}${RestAPIs.SESSION_URL}?$queryParams";
        http.Response _response =
            await http.get(Uri.parse(sessionUrl), headers: getHeader);
        if (_response.statusCode == 200) {
          _sessionList = <AvailableSession>[];
          final jsonResponse = await dataFilter.toJsonResponse(
              callback: ApiAuth.AVAILABLE_SESSION_CALLBACKS,
              response: _response.body);
          final Map<String, dynamic> content = json.decode(jsonResponse);
          print(content);
          if (content.containsKey('isSuccess')) {
            if (content['isSuccess']) {
              final List collection = content['getAvailTermVector'];
              print(collection);
              _sessionList = collection
                  .map((json) => AvailableSession.fromJson(json))
                  .toList();
              final int _currentSessionIndex = _sessionList.length - 1;
//                  _sessionList.length - 1; // Last Item Will Active
              availableSessionList = _sessionList;
              currentSessionIndex = _currentSessionIndex;
              notifyListeners();

              String? _firstId = _sessionList[_currentSessionIndex].sessionId;
              _exmList = await getExamList(sessionId: _firstId);

              if (_exmList != null) {
                // Get First Value;
                currentExamIndex = 0;

                String? sessionExamId = _exmList[0].sessionExamId;
                String? examId = _exmList[0].examId;
                String? examName = _exmList[0].examName;

                // Get Mark List
                _subMarkList = await getSubjectMarks(sessionExamId, examId,
                    examName: examName);
                if (_subMarkList != null) {}
              }
            }
          }
        }
      }
    } catch (e) {
      print(e);
      print("error");
      return [_sessionList, _exmList, _subMarkList];
    }
    return [_sessionList, _exmList, _subMarkList];
  }

  Future<List<Exam>?> getExamList({String? sessionId}) async {
    List<Exam>? _examList;
    print("SessionId: $sessionId");

    try {
      String tokenUrl =
          "${school?.schoolFirstServerAddress}${RestAPIs.TOKEN_URL}";
      final tokenResponse = await dataFilter.getToken(
        serverUrl: tokenUrl,
        apiCode: ApiAuth.EXAM_API_CODE,
      );
      print(tokenUrl);
      if (tokenResponse != null) {
        final URLQueryParams queryParams = URLQueryParams();
        queryParams.append("callback", ApiAuth.EXAM_CALLBACKS);
        queryParams.append("apiCode", ApiAuth.EXAM_API_CODE);
        queryParams.append("userWingId", user!.getUserWingId);
        queryParams.append("loginUserId", user!.getUserId);
        queryParams.append("academicSessionId", sessionId);
        queryParams.append("withClassTest", 'N');
        queryParams.append(
            "accessToken", tokenResponse['accessToken'].toString());

        final String sessionUrl =
            "${school?.schoolFirstServerAddress}${RestAPIs.EXAM_URL}?$queryParams";
        http.Response _response =
            await http.get(Uri.parse(sessionUrl), headers: getHeader);
        if (_response.statusCode == 200) {
          _examList = <Exam>[];
          final jsonResponse = await dataFilter.toJsonResponse(
              callback: ApiAuth.EXAM_CALLBACKS, response: _response.body);
          final Map<String, dynamic> content = json.decode(jsonResponse);
          print("List Of Exams: $content");
          if (content.containsKey('isSuccess')) {
            if (content['isSuccess']) {
              final List collection = content['getExamListVector'];
              print(collection);
              _examList =
                  collection.map((json) => Exam.fromJson(json)).toList();
              examList = _examList;
            }
          }
        }
      } else {
        return null;
      }
    } catch (e) {
      print(e);
      print("error");
      return null;
    }
    return _examList;
  }

  Future<List<SubjectMark>?> getSubjectMarks(
      String? sessionExamId, String? examId,
      {String? examName = ''}) async {
    List<SubjectMark>? _markList;

    try {
      isLoading = true;
      notifyListeners();
      String tokenUrl =
          "${school?.schoolFirstServerAddress}${RestAPIs.TOKEN_URL}";
      final tokenResponse = await dataFilter.getToken(
        serverUrl: tokenUrl,
        apiCode: ApiAuth.MARK_API_CODE,
      );
      print(tokenUrl);
      if (tokenResponse != null) {
        final URLQueryParams queryParams = URLQueryParams();
        queryParams.append("callback", ApiAuth.MARK_CALLBACKS);
        queryParams.append("apiCode", ApiAuth.MARK_API_CODE);
        queryParams.append("userWingId", user!.getUserWingId);
        queryParams.append("loginUserId", user!.getUserId);
        queryParams.append("academicSesnExamId", sessionExamId);
        queryParams.append("examId", examId);
        queryParams.append("examinationName", examName);
        queryParams.append(
            "accessToken", tokenResponse['accessToken'].toString());

        final String markUrl =
            "${school?.schoolFirstServerAddress}${RestAPIs.MARK_URL}?$queryParams";
        http.Response _response =
            await http.get(Uri.parse(markUrl), headers: getHeader);
        print("Subject URL: $markUrl");
        if (_response.statusCode == 200) {
          _markList = <SubjectMark>[];
          final jsonResponse = await dataFilter.toJsonResponse(
              callback: ApiAuth.MARK_CALLBACKS, response: _response.body);
          final Map<String, dynamic> content = json.decode(jsonResponse);
          print(content);
          if (content.containsKey('isSuccess')) {
            if (content['isSuccess'] &&
                content.containsKey("getSubjectMarkVector")) {
              final List collection = content['getSubjectMarkVector'];
              print(collection);
              _markList =
                  collection.map((json) => SubjectMark.fromJson(json)).toList();
              subjectMarkList = _markList;
            } else {
              _markList = null;
            }
          }
        }
      } else {
        _markList = null;
      }
    } catch (e) {
      print(e);
      print("error");
      _markList = null;
    }
    isLoading = false;
    subjectMarkList = _markList;
    notifyListeners();
    return _markList;
  }
}
