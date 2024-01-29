import 'dart:convert';

import 'package:greycell_app/src/config/apiauth_config.dart';
import 'package:greycell_app/src/manager/data_manager.dart';
import 'package:greycell_app/src/models/school/school_contact.dart';
import 'package:http/http.dart' as http;
import 'package:greycell_app/src/commons/widgets/query_params.dart';

mixin GeneralService on DataManager {
  Map<String, String> get getHeader => {"Content-Type": "application/json"};

  Future<SchoolContact?> getContactDetails(
      {String? fromDate, String? toDate}) async {
    SchoolContact? _schoolContact;
    try {
      String tokenUrl =
          "${school?.schoolFirstServerAddress}${RestAPIs.TOKEN_URL}";
      final response = await dataFilter.getToken(
        serverUrl: tokenUrl,
        apiCode: ApiAuth.CONTACT_API_CODE,
      );
      if (response != null) {
        final URLQueryParams queryParams = URLQueryParams();
        queryParams.append("callback", ApiAuth.CONTACT_CALLBACKS);
        queryParams.append("apiCode", ApiAuth.CONTACT_API_CODE);
        queryParams.append("loginUserId", user!.getUserId);
        queryParams.append("accessToken", response['accessToken'].toString());

        final String contactUrl =
            "${school?.schoolFirstServerAddress}${RestAPIs.CONTACT_URL}?$queryParams";
        print(contactUrl);
        http.Response _response =
            await http.get(Uri.parse(contactUrl), headers: getHeader);

        if (_response.statusCode == 200) {
          final jsonResponse = await dataFilter.toJsonResponse(
              callback: ApiAuth.CONTACT_CALLBACKS, response: _response.body);

          final Map<String, dynamic> content = json.decode(jsonResponse);
          if (content.containsKey('isSuccess') && content['isSuccess']) {
            // Data Exist
            _schoolContact = SchoolContact.fromJson(content);
            print(content);
          } else if (!content['isSuccess']) {
            // No Data
            print("No Data");
            return _schoolContact;
          } else {
            // Error In response
            return null;
          }
        }
      } else {
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
    notifyListeners();
    return _schoolContact;
  }
}
