import 'dart:convert';
import 'dart:developer';

import 'package:greycell_app/src/config/apiauth_config.dart';
import 'package:greycell_app/src/manager/data_manager.dart';
import 'package:greycell_app/src/models/noticeModel/notice_model.dart';
import 'package:http/http.dart' as http;
import 'package:greycell_app/src/commons/widgets/query_params.dart';

mixin NoticeService on DataManager {
  Map<String, String> get getHeader => {"Content-Type": "application/json"};

  Future<List<Notice>?> getNotices({String? fromDate, String? toDate}) async {
    List<Notice>? _noticeList;
    isLoading = true;
    notifyListeners();
    try {
      String tokenUrl =
          "${school?.schoolFirstServerAddress}${RestAPIs.TOKEN_URL}";
      final response = await dataFilter.getToken(
        serverUrl: tokenUrl,
        apiCode: ApiAuth.NOTICE_API_CODE,
      );
      if (response != null) {
        final URLQueryParams queryParams = URLQueryParams();
        queryParams.append("callback", ApiAuth.NOTICE_CALLBACKS);
        queryParams.append("apiCode", ApiAuth.NOTICE_API_CODE);
        queryParams.append("txtNotFromDate", fromDate);
        queryParams.append("txtNotToDate", toDate);
        queryParams.append("userWingId", user!.getUserWingId);
        queryParams.append("loginUserId", user!.getUserId);
        queryParams.append("accessToken", response['accessToken'].toString());

        final String noticeUrl =
            "${school?.schoolFirstServerAddress}${RestAPIs.NOTICE_URL}?$queryParams";
        print("URL: ${noticeUrl}");
        http.Response _response =
            await http.get(Uri.parse(noticeUrl), headers: getHeader);

        if (_response.statusCode == 200) {
          final jsonResponse = await dataFilter.toJsonResponse(
              callback: ApiAuth.NOTICE_CALLBACKS, response: _response.body);
          _noticeList = <Notice>[];

          final Map<String, dynamic> content = json.decode(jsonResponse);
          if (content.containsKey('isSuccess') && content['isSuccess']) {
            // Data Exist
            List collection = content['getNoticeVector'];
            _noticeList = collection
                .map((noticeJson) => Notice.fromJson(noticeJson))
                .toList();
            for (var element in _noticeList) {
              log(element.message.toString());
            }
          } else if (!content['isSuccess']) {
            // No Data
            print("No Notice");
          }
        }
      }
    } catch (e) {
      print(e);
    }
    isLoading = false;
    notifyListeners();
    return _noticeList;
  }
}
