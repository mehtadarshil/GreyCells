import 'dart:convert';

import 'package:greycell_app/src/config/apiauth_config.dart';
import 'package:greycell_app/src/manager/data_manager.dart';
import 'package:greycell_app/src/models/examReportModel/exam_report_model.dart';
import 'package:http/http.dart' as http;
import 'package:greycell_app/src/commons/widgets/query_params.dart';

mixin ExamService on DataManager {
  Map<String, String> get getHeader => {"Content-Type": "application/json"};

  Future<ExamReport?> getAvailTermVector() async {
    ExamReport? _examReport;
    try {
      String tokenUrl =
          "${school?.schoolFirstServerAddress}${RestAPIs.TOKEN_URL}";
      final response = await dataFilter.getToken(
        serverUrl: tokenUrl,
        apiCode: ApiAuth.AVAILABLE_EXAMRPT_TERM_API_CODE,
      );
      if (response != null) {
        final URLQueryParams queryParams = URLQueryParams();
        queryParams.append(
            "callback", ApiAuth.AVAILABLE_EXAMRPT_TERM_CALLBACKS);
        queryParams.append("apiCode", ApiAuth.AVAILABLE_EXAMRPT_TERM_API_CODE);
        queryParams.append("loginUserId", user!.getUserId);
        queryParams.append("accessToken", response['accessToken'].toString());

        final String att_url =
            "${school?.schoolFirstServerAddress}${RestAPIs.AVAILABLE_EXAMRPT_TERM_URL}?$queryParams";
        print("Exam Report URL: $att_url");
        http.Response _response =
            await http.get(Uri.parse(att_url), headers: getHeader);
        if (_response.statusCode == 200) {
          final jsonResponse = await dataFilter.toJsonResponse(
              callback: ApiAuth.AVAILABLE_EXAMRPT_TERM_CALLBACKS,
              response: _response.body);
          final content = json.decode(jsonResponse);
          print(content);
          if (content is String) {
            // If Login Success content type will json(MAP)
            // If It is String then Somehow Response Is Empty => callBacks(" ")
            _examReport = null;
          } else {
            _examReport = ExamReport.fromJson(content);
          }
        }
      }
    } catch (e) {
      print(e);
      print("error");
    }
    return _examReport;
  }

  Future<ExamReportsList?> myExamReportsList(
      {String? batAcademicSessionId}) async {
    ExamReportsList? _examReport;
    try {
      String tokenUrl =
          "${school?.schoolFirstServerAddress}${RestAPIs.TOKEN_URL}";
      final response = await dataFilter.getToken(
        serverUrl: tokenUrl,
        apiCode: ApiAuth.MY_EXAMREPORTLIST_API_CODE,
      );
      if (response != null) {
        final URLQueryParams queryParams = URLQueryParams();
        queryParams.append("callback", ApiAuth.MY_EXAMREPORTLIST_CALLBACKS);
        queryParams.append("apiCode", ApiAuth.MY_EXAMREPORTLIST_API_CODE);
        queryParams.append("loginUserId", user!.getUserId);
        queryParams.append("userWingId", user!.getUserWingId);
        queryParams.append("batAcademicSessionId", batAcademicSessionId);
        queryParams.append("accessToken", response['accessToken'].toString());

        final String att_url =
            "${school?.schoolFirstServerAddress}${RestAPIs.MY_EXAMREPORTLIST_URL}?$queryParams";
        print("Exam Report URL: $att_url");
        print("Exam Report URL: 111111111111");
        http.Response _response =
            await http.get(Uri.parse(att_url), headers: getHeader);
        if (_response.statusCode == 200) {
          final jsonResponse = await dataFilter.toJsonResponse(
              callback: ApiAuth.MY_EXAMREPORTLIST_CALLBACKS,
              response: _response.body);
          final content = json.decode(jsonResponse);
          print(content);
          if (content is String) {
            // If Login Success content type will json(MAP)
            // If It is String then Somehow Response Is Empty => callBacks(" ")
            _examReport = null;
          } else {
            _examReport = ExamReportsList.fromJson(content);
          }
        }
      }
    } catch (e) {
      print(e);
      print("error");
    }
    return _examReport;
  }

  Future<ReportCard?> myReportCardDtl(
      {cmbcourse,
      cmbBatch,
      cmbBatchName,
      cmbDiscipline,
      cmbBchAcdmcSession,
      cmbBchAcdmcSessionName,
      cmbSection,
      cmbSectionName,
      cmbReportPurpose,
      cmbReportFormat,
      cmbReportFormatName,
      cmbExamTerm,
      cmbExam,
      cmbExamName,
      hdnSelectedStdnArr,
      hdnSelectedStdnRegdNoArr,
      hdnSelectedStdnNameArr,
      cmbDisciplineName}) async {
    ReportCard? _examReport;
    try {
      String tokenUrl =
          "${school?.schoolFirstServerAddress}${RestAPIs.TOKEN_URL}";
      final response = await dataFilter.getToken(
        serverUrl: tokenUrl,
        apiCode: ApiAuth.MY_EXAMREPORT_API_CODE,
      );
      if (response != null) {
        final URLQueryParams queryParams = URLQueryParams();
        queryParams.append("callback", ApiAuth.MY_EXAMREPORT_CALLBACKS);
        queryParams.append("loginUserId", user!.getUserId);
        queryParams.append("cmbcourse", cmbcourse);
        queryParams.append("cmbBatch", cmbBatch);
        queryParams.append("cmbBatchName", cmbBatchName);
        queryParams.append("cmbDiscipline", cmbDiscipline);
        queryParams.append("cmbDisciplineName", cmbDisciplineName);
        queryParams.append("cmbBchAcdmcSession", cmbBchAcdmcSession);
        queryParams.append("cmbBchAcdmcSessionName", cmbBchAcdmcSessionName);
        queryParams.append("cmbSection", cmbSection);
        queryParams.append("cmbSectionName", cmbSectionName);
        queryParams.append("cmbReportPurpose", cmbReportPurpose);
        queryParams.append("cmbReportFormat", cmbReportFormat);
        queryParams.append("cmbReportFormatName", cmbReportFormatName);
        queryParams.append("cmbExamTerm", cmbExamTerm);
        queryParams.append("cmbExam", cmbExam);
        queryParams.append("cmbExamName", cmbExamName);
        queryParams.append("cmbExamCategory", "1");
        queryParams.append("pageId", "EXM-RPT-CCEREPORTS");
        queryParams.append("hdnSelectedStdnArr", hdnSelectedStdnArr);
        queryParams.append(
            "hdnSelectedStdnRegdNoArr", hdnSelectedStdnRegdNoArr);
        queryParams.append("hdnSelectedStdnNameArr", hdnSelectedStdnNameArr);
        queryParams.append("apiCode", ApiAuth.MY_EXAMREPORT_API_CODE);
        queryParams.append("accessToken", response['accessToken'].toString());

        final String att_url =
            "${school?.schoolFirstServerAddress}${RestAPIs.MY_EXAMREPORT_URL}?$queryParams";
        print("Exam Report URL: $att_url");
        http.Response _response =
            await http.get(Uri.parse(att_url), headers: getHeader);
        if (_response.statusCode == 200) {
          final jsonResponse = await dataFilter.toJsonResponse(
              callback: ApiAuth.MY_EXAMREPORT_CALLBACKS,
              response: _response.body);
          final content = json.decode(jsonResponse);
          print(content);
          if (content is String) {
            // If Login Success content type will json(MAP)
            // If It is String then Somehow Response Is Empty => callBacks(" ")
            _examReport = null;
          } else {
            _examReport = ReportCard.fromJson(content);
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
