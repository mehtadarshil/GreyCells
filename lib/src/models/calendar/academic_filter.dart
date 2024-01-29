import 'package:greycell_app/src/models/calendar/academic_events.dart';

class EventFilter {
  Map<DateTime?, List<AcademicEvent>>? eventFilter;
  List<AcademicEvent>? originalData;

  EventFilter({this.eventFilter, this.originalData});
}
