import 'package:flutter/material.dart';
import 'package:greycell_app/src/commons/widgets/error_data.dart';
import 'package:greycell_app/src/manager/main_model.dart';
import 'package:greycell_app/src/models/calendar/academic_events.dart';
import 'package:greycell_app/src/models/calendar/academic_filter.dart';
import 'package:greycell_app/src/views/calendarViews/calendar_appbar.dart';
import 'package:greycell_app/src/views/calendarViews/event_list.dart';
import 'package:greycell_app/src/views/observer/future_observer.dart';

class MyCalendarEvent extends StatefulWidget {
  final MainModel model;

  MyCalendarEvent({required this.model});

  @override
  _MyCalendarEventState createState() => _MyCalendarEventState();
}

class _MyCalendarEventState extends State<MyCalendarEvent>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

// Initializing CalendarController here =>
  // due to OnScroll It Remains the Same Controller and will not re-Instatiate

  List<AcademicEvent>? _eventList;
  Map<DateTime?, List<AcademicEvent>>? _dateMapEventList;
  ScrollController? _scrollController;

  Future<EventFilter?>? _futureEventFilter;
  EventFilter? _eventFilter;

  void _onCreated() async {
    _futureEventFilter = widget.model.getEvents();

    _eventFilter = await _futureEventFilter;
    if (_eventFilter != null) {
      // Update All Events To Default Case
      widget.model.onResetToDefault();
      _eventList = _eventFilter!.originalData;
      _dateMapEventList = _eventFilter!.eventFilter;

      // Get Current Data To Ui
      widget.model.onMonthChanged(
        DateTime.now(),
      );
    } else {
      print("Error Occured");
    }

//    print(_eventList.first.dateTime);
  }

  void _onScrollListener() {
    print("Scrooled");
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  initState() {
    super.initState();
    _onCreated();
    _scrollController = ScrollController();
//    _scrollController.addListener(_onScrollListener
  }

  Future<void> _onRefreshPull() async {}

  Widget _buildBody() {
    double height = MediaQuery.of(context).size.height;
    TextStyle? b = Theme.of(context).textTheme.bodyMedium;
    TextStyle? sub = Theme.of(context).textTheme.titleMedium;
    Color primary = Theme.of(context).primaryColor;
    return RefreshIndicator(
      onRefresh: _onRefreshPull,
      color: primary,
      child: CustomScrollView(
        slivers: <Widget>[
          MyCalendarAppbar(),
          MyEventList(onFailed: _onCreated),
        ],
      ),
    );
  }

  Widget _waitingSc() {
    return Scaffold(
      appBar: AppBar(
        title: Text("Academic Calendar"),
      ),
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      appBar: AppBar(
//        title: Text("Calendar"),
//      ),
      backgroundColor: Colors.grey[50],
      body: FutureObserver<EventFilter?>(
        future: _futureEventFilter,
        onWaiting: (context) {
          return _waitingSc();
        },
        onError: (context, errormsg) => MyErrorData(
//          onReload: _onRefreshPull,
          errorMsg: errormsg,
        ),
        onSuccess: (context, EventFilter filter) {
          return _buildBody();
        },
      ),
    );
  }
}
