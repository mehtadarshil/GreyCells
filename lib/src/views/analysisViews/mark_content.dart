import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:greycell_app/src/commons/widgets/not_found.dart';
import 'package:greycell_app/src/manager/main_model.dart';
import 'package:greycell_app/src/models/analysis/subject_mark.dart';
import 'package:greycell_app/src/views/analysisViews/mark_card.dart';
import 'package:greycell_app/src/views/chartViews/horizontal_chart.dart';
import 'package:scoped_model/scoped_model.dart';

class MyTermExams extends StatelessWidget {
  double minValue = 8.0;
  final Function? onRetry;

  MyTermExams({this.onRetry});

  void _onSortSub(int columnIndex, bool ascending) {
    print("ColumnIndex: $columnIndex");
    print("ascending: $ascending");
  }

  Widget _buildResultType(BuildContext context) {
    final sStyle = Theme.of(context).textTheme.titleMedium;

    return ScopedModelDescendant(
      builder: (context, _, MainModel model) {
        return model.subjectMarkList == null
            ? model.isLoading
                ? SpinKitThreeBounce(
                    color: Theme.of(context).colorScheme.secondary,
                    size: 30.0,
                  )
                : MyNotFound(
                    title: "No Marks Available",
                    onRetry: onRetry,
                  )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  model.isLoading
                      ? SpinKitThreeBounce(
                          color: Theme.of(context).colorScheme.secondary,
                          size: 30.0,
                        )
                      : Container(),
                  Container(
                      height: 450.0,
                      color: Colors.grey[100],
                      padding: EdgeInsets.only(bottom: minValue),
                      child: HorizontalBarLabelChart(
                        model: model,
                      )),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: minValue, horizontal: minValue * 2),
                    child: Text(
                      "Results",
                      style: sStyle!.apply(
                          color: Colors.blueGrey[800], fontWeightDelta: 1),
                    ),
                  ),
                  ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      itemCount: model.subjectMarkList!.length,
                      itemBuilder: (context, index) {
                        final SubjectMark _mark = model.subjectMarkList![index];
                        return MyMarkCard(
                          mark: _mark,
                        );
                      }),
                ],
              );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
//      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        color: Colors.grey[100],
//          borderRadius: BorderRadius.only(
//              topRight: Radius.circular(minValue * 4),
//              topLeft: Radius.circular(minValue * 4))
      ),
      child: _buildResultType(context),
    );
  }
}
