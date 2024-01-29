/// Horizontal bar chart with bar label renderer example and hidden domain axis.
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:greycell_app/src/manager/main_model.dart';
import 'package:greycell_app/src/models/analysis/subject_mark.dart';

class HorizontalBarLabelChart extends StatelessWidget {
  double minValue = 8.0;

  final MainModel model;

  HorizontalBarLabelChart({required this.model});

  @override
  Widget build(BuildContext context) {
    if (model.subjectMarkList == null) return Container();
    return Card(
      elevation: 0.20,
      margin: EdgeInsets.all(minValue),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(minValue * 2))),
      child: charts.BarChart(
        _createSampleData(model),
        animate: true,
        vertical: false,
        barRendererDecorator: new charts.BarLabelDecorator<String>(),
        primaryMeasureAxis: charts.NumericAxisSpec(
          showAxisLine: false,
        ),
        secondaryMeasureAxis: charts.NumericAxisSpec(showAxisLine: false),
        domainAxis: new charts.OrdinalAxisSpec(
          renderSpec: new charts.NoneRenderSpec(),
          showAxisLine: false,
        ),
      ),
    );
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<SubjectMark, String>> _createSampleData(
      MainModel model) {
    return [
      new charts.Series<SubjectMark, String>(
          id: 'Mark',
          domainFn: (SubjectMark mark, _) => mark.subjectName.toString(),
          measureFn: (SubjectMark mark, _) =>
              (mark.securedMark! / mark.totalMark!) * 100,
          data: model.subjectMarkList!,
          // Set a label accessor to control the text of the bar label.
          displayName: "Marks",
          labelAccessorFn: (SubjectMark mark, _) =>
              '${mark.subjectName}: (${mark.securedMark}/${mark.totalMark})')
    ];
  }
}
