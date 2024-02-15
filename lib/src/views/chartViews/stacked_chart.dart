import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:greycell_app/src/models/attendance/term.dart';

class StackedBarChart extends StatelessWidget {
  final List<Term>? terms;

  StackedBarChart(this.terms);

  @override
  Widget build(BuildContext context) {
    return charts.BarChart(
      _createSampleData(),
      animate: true,
      barGroupingType: charts.BarGroupingType.grouped,
      behaviors: [
//        new charts.ChartTitle('Top title text',
//            subTitle: 'Top sub-title text',
//            behaviorPosition: charts.BehaviorPosition.end,
//            titleOutsideJustification:
//                charts.OutsideJustification.middleDrawArea,
//            innerPadding: 18),

        new charts.LinePointHighlighter(
            symbolRenderer: charts.CircleSymbolRenderer(isSolid: true)),
        new charts.SeriesLegend(
            desiredMaxColumns: 2,
            entryTextStyle: charts.TextStyleSpec(
              fontWeight: "bold",
              fontSize: 12,
            ),
            position: charts.BehaviorPosition.top,
            outsideJustification: charts.OutsideJustification.start,
            horizontalFirst: true),
      ],
      barRendererDecorator: charts.BarLabelDecorator(
          labelPosition: charts.BarLabelPosition.right,
          outsideLabelStyleSpec:
              charts.TextStyleSpec(fontSize: 15, fontWeight: "bold")),
    );
  }

  /// Create series list with multiple series
  List<charts.Series<TermDetails, String>> _createSampleData() {
    print(terms);
    final List<TermDetails> _attended = [];
    final List<TermDetails> _totalClass = [];
    final List<TermDetails> termList = terms![0].termDetails!;
    print(termList.length);

    /// Retrieving First Record For Chart
    termList.forEach((term) {
      _attended.add(term);
      _totalClass.add(TermDetails(
          monthName: term.monthName,
          totalClass:
              (int.parse(term.totalClass!) - int.parse(term.attendedClass!))
                  .toString()));
    });

    return [
      new charts.Series<TermDetails, String>(
        id: 'Absent',
        domainFn: (TermDetails data, _) => data.monthName!.substring(0, 3),
        measureFn: (TermDetails data, _) => int.parse(data.totalClass!),
        labelAccessorFn: (datum, index) => datum.totalClass ?? "",
        outsideLabelStyleAccessorFn: (datum, index) =>
            charts.TextStyleSpec(fontSize: 11),
//        colorFn: (TermDetails detail, _) =>
//            charts.ColorUtil.fromDartColor(Colors.redAccent[100]),
        data: _totalClass,
      ),
      new charts.Series<TermDetails, String>(
        id: 'Attended',
        domainFn: (TermDetails data, _) => data.monthName!.substring(0, 3),
        measureFn: (TermDetails data, _) => int.parse(data.attendedClass!),
        data: _attended,
        labelAccessorFn: (datum, index) => datum.attendedClass ?? "",
        outsideLabelStyleAccessorFn: (datum, index) =>
            charts.TextStyleSpec(fontSize: 11),
//        colorFn: (TermDetails detail, _) =>
//            charts.ColorUtil.fromDartColor(Colors.indigo),
      ),
    ];
  }
}
