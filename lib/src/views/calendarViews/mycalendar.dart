import 'package:flutter/material.dart';
import 'package:greycell_app/src/manager/main_model.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:table_calendar/table_calendar.dart';

class MyCalendar extends StatelessWidget {
  void _onDaySelected(DateTime day, List events, MainModel model) async {
    print("OndaySelected Day: $day");
    print("OndaySelected Events: ${events.length}");
    model.onDateChange(day, events);
  }

  void _onDayLongpressed(DateTime day, List? events, lst) {
    print("_onDayLongpressed Day: $day");
    print("_onDayLongpressed Events: $events");
  }

  void _onHeaderTapped(DateTime focusedDay) {
    print("_onHeaderTapped FOcusDay: $focusedDay");
  }

  void _onHeaderLongPressed(DateTime focusedDay) {
    print("_onHeaderLongPressed FOcusDay: $focusedDay");
  }

  void _onUnavailableDayLongPressed(DateTime date) {
    print("_onUnavailableDayLongPressed");
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant(
      builder: (context, _, MainModel model) {
        return Column(
          children: <Widget>[
            SizedBox(height: 65),
            TableCalendar(
              rowHeight: 40.0,
              onDaySelected: (DateTime day, lst) =>
                  _onDaySelected(day, model.calendarEventList[day]!, model),
              onDayLongPressed: (selectedDay, focusedDay) => _onDayLongpressed(
                  selectedDay,
                  model.calendarEventList[selectedDay],
                  focusedDay),
              onHeaderLongPressed: _onHeaderLongPressed,
              onHeaderTapped: _onHeaderTapped,
              onDisabledDayLongPressed: _onUnavailableDayLongPressed,
              onPageChanged: model.onMonthChanged,
              eventLoader: (day) => model.calendarEventList[day] ?? [],
              startingDayOfWeek: StartingDayOfWeek.monday,
              calendarStyle: CalendarStyle(
                outsideTextStyle:
                    TextStyle(color: Colors.white, fontSize: 25.0),
                weekendTextStyle: TextStyle(color: Colors.white70),
                weekNumberTextStyle: TextStyle(color: Colors.white60),
                holidayTextStyle: TextStyle(color: Colors.yellow),
                cellPadding: EdgeInsets.all(4),
                todayTextStyle:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                selectedDecoration: BoxDecoration(color: Colors.pink[400]),
                todayDecoration: BoxDecoration(color: Colors.deepOrange[400]),
                markerDecoration: BoxDecoration(color: Colors.white70),
                markersOffset: PositionedOffset(bottom: 1.0),
                outsideDaysVisible: false,
              ),
              headerVisible: true,
              headerStyle: HeaderStyle(
                titleTextStyle: TextStyle(color: Colors.white),
                titleCentered: true,
                leftChevronIcon: Icon(
                  Icons.arrow_left,
                  color: Colors.white70,
                ),
                rightChevronIcon: Icon(
                  Icons.arrow_right,
                  color: Colors.white70,
                ),
                formatButtonShowsNext: true,
                formatButtonVisible: false,
                formatButtonTextStyle:
                    TextStyle(color: Colors.white, fontSize: 15.0),
                formatButtonDecoration: BoxDecoration(
                  color: Colors.deepOrange[400],
                  borderRadius: BorderRadius.circular(16.0),
                ),
              ),
              firstDay: DateTime.now(),
              focusedDay: DateTime.now(),
              lastDay: DateTime.now(),
            ),
          ],
        );
      },
    );
  }
}
