import 'dart:convert';
import 'dart:developer';

import 'package:greycell_app/src/config/apiauth_config.dart';
import 'package:greycell_app/src/manager/data_manager.dart';
import 'package:greycell_app/src/models/calendar/academic_events.dart';
import 'package:greycell_app/src/models/calendar/academic_filter.dart';
import 'package:http/http.dart' as http;
import 'package:greycell_app/src/commons/widgets/query_params.dart';

mixin CalendarService on DataManager {
  Map<String, String> get getHeader => {"Content-Type": "application/json"};

  Future<EventFilter?> getEvents() async {
    EventFilter? _eventFilter;
    try {
      String tokenUrl =
          "${school?.schoolFirstServerAddress}${RestAPIs.TOKEN_URL}";
      final Map<String, dynamic>? responseToken = await dataFilter.getToken(
        serverUrl: tokenUrl,
        apiCode: ApiAuth.ACADEMIC_CALENDAR_API_CODE,
      );
      if (responseToken != null) {
        final URLQueryParams queryParams = URLQueryParams();
        queryParams.append("callback", ApiAuth.ACADEMIC_CALENDAR_CALLBACKS);
        queryParams.append("apiCode", ApiAuth.ACADEMIC_CALENDAR_API_CODE);
        queryParams.append("loginUserId", user!.getUserId);
        queryParams.append(
            "accessToken", responseToken['accessToken'].toString());

        final String calendar_url =
            "${school?.schoolFirstServerAddress}${RestAPIs.ACADEMIC_CALENDAR_URL}?$queryParams";
        http.Response _response =
            await http.get(Uri.parse(calendar_url), headers: getHeader);
//        print(_response.body);

        if (_response.statusCode == 200) {
          final jsonResponse = await dataFilter.toJsonResponse(
              callback: ApiAuth.ACADEMIC_CALENDAR_CALLBACKS,
              response: _response.body);
          _eventFilter = EventFilter();
          log(jsonResponse);
          final Map<String, dynamic> content = json.decode(jsonResponse);
          if (content.containsKey('isSuccess') && content['isSuccess']) {
            // Data Exist
            List collection = content['getAcademicCalendarDetailVec'];
            final List<AcademicEvent> _acEv = collection
                .map((event) => AcademicEvent.fromJson(event))
                .toList();
            Map<DateTime?, List<AcademicEvent>> _calendarEventList =
                groupedByDate(_acEv);
            _eventFilter = EventFilter(
                eventFilter: _calendarEventList, originalData: _acEv);
            originalEventList = _acEv;

            calendarEventList = _calendarEventList;
          } else if (!content['isSuccess']) {
            // No Data
            print("No Events");
            return _eventFilter;
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
    return _eventFilter;
  }

  Map<DateTime?, List<AcademicEvent>> groupedByDate(
      List<AcademicEvent> originalEventList) {
    Map<DateTime?, List<AcademicEvent>> _calendarEventList =
        Map<DateTime?, List<AcademicEvent>>();

    List<AcademicEvent> _keyEventLis;
    originalEventList.forEach((AcademicEvent event) {
      if (_calendarEventList.containsKey(event.dateTime)) {
        // date Key Exist => Add One Record To Existing Date Key
        // Get Existing List
        final List<AcademicEvent> _academicList =
            _calendarEventList[event.dateTime]!;
        // Adding Current Event To Existing List
        _academicList.add(event);
        // Updating Current Key of Map Object
        _calendarEventList[event.dateTime] = _academicList;
      } else {
        // Date key Not Exist. Add One New date Key Record to Map Object;
        final List<AcademicEvent> _academicList = [];
        _academicList.add(event);
//        _calendarEventList.update(event.dateTime, () => [].add(event));
        _calendarEventList[event.dateTime] = _academicList;
      }
    });
    print(_calendarEventList);
    return _calendarEventList;
  }
}
