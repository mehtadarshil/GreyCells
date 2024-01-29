import 'package:flutter/material.dart';
import 'package:greycell_app/src/models/calendar/academic_events.dart';

class MyEventCard extends StatelessWidget {
  final AcademicEvent event;

  MyEventCard({required this.event});

  double minValue = 8.0;
  double _cardHeight = 80.0;

  bool get isToday =>
      (event.dateTime!.month.toString() +
          event.dateTime!.day.toString() +
          event.dateTime!.year.toString()) ==
      (DateTime.now().month.toString() +
          DateTime.now().day.toString() +
          DateTime.now().year.toString());

  Widget _buildLeading(BuildContext context) {
    final dayS = Theme.of(context)
        .textTheme
        .headlineMedium!
        .apply(fontWeightDelta: 1, color: Colors.white);
    final monthS = Theme.of(context)
        .textTheme
        .bodyMedium!
        .apply(fontWeightDelta: 1, color: Colors.white);

    return Container(
      height: double.maxFinite,
      width: _cardHeight,
      decoration: BoxDecoration(
//          color: isToday ? Theme.of(context).accentColor : Colors.lightBlue,
          shape: BoxShape.rectangle,
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.center,
              colors: isToday
                  ? [Colors.pinkAccent, Colors.pink[400]!]
                  : [Colors.lightBlueAccent, Colors.lightBlue[400]!])),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            "${event.dayDate!.split(' ')[1].toUpperCase()}",
            style: monthS,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: minValue,
              ),
              Text("${event.monthDate!.substring(0, 4)}-", style: dayS),
              Text(
                "${event.dayDate!.split(' ')[0].toUpperCase()}",
                style: dayS,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    final titleS = Theme.of(context).textTheme.titleSmall;
    final chipS = Theme.of(context).textTheme.bodySmall;
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: minValue,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Flexible(
            child: Text(
              "${event.eventName}",
              style: titleS,
              maxLines: 4,
              overflow: TextOverflow.clip,
            ),
          ),
//          Chip(
//            label: Text(
//              "${(event.monthDate).substring(0, 4)}",
//            ),
//            padding: EdgeInsets.all(2),
//            labelStyle: chipS.apply(color: Colors.white),
//            backgroundColor: Colors.lightBlue,
//            shape: RoundedRectangleBorder(),
//          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          EdgeInsets.symmetric(vertical: minValue - 5, horizontal: minValue),
      child: SizedBox(
        height: _cardHeight,
        child: Card(
          elevation: 0.0,
          child: Row(
            children: <Widget>[
              _buildLeading(context),
              Expanded(child: _buildContent(context)),
            ],
          ),
        ),
      ),
    );
  }

  Color getColorMonth(String month) {
    print(month);
    Color _color;

    switch (month) {
      case "JAN":
        _color = Colors.cyan;
        break;
      case "FEB":
        _color = Colors.deepPurple;
        break;
      case "MAR":
        _color = Colors.lightGreen;
        print(_color);
        break;
      case "APR":
        _color = Colors.limeAccent;
        break;
      case "MAY":
        _color = Colors.yellow;
        break;
      case "JUN":
        _color = Colors.orange;
        break;
      case "JUL":
        _color = Colors.greenAccent;
        break;
      case "AUG":
        _color = Colors.tealAccent;
        break;
      case "SEP":
        _color = Colors.blueGrey;
        break;
      case "OCT":
        _color = Colors.blue;
        break;
      case "NOV":
        _color = Colors.redAccent;
        break;
      case "DEC":
        _color = Colors.pinkAccent;
        break;
      default:
        _color = Colors.lightBlueAccent;
    }
    return _color;
  }
}
