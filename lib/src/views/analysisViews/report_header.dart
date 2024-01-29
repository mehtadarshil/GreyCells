import 'package:flutter/material.dart';
import 'package:greycell_app/src/manager/main_model.dart';
import 'package:greycell_app/src/models/analysis/termwise_exam.dart';
import 'package:scoped_model/scoped_model.dart';

class MyReportHeader extends StatelessWidget {
  final minValue = 8.0;

  @override
  Widget build(BuildContext context) {
    final headerTextS = Theme.of(context)
        .textTheme
        .bodyMedium!
        .apply(fontWeightDelta: 1, color: Colors.blueGrey[700]);
    final dataTextS =
        Theme.of(context).textTheme.bodySmall!.apply(fontWeightDelta: 1);

    return ScopedModelDescendant(
      builder: (context, _, MainModel model) {
        if ((model.examList ?? []).length == 0)
          return Text(
            "Loading...",
            style: TextStyle(color: Colors.white70),
          );
        final Exam _exmDetails = model.examList![model.currentExamIndex];
        return Container(
          margin: EdgeInsets.symmetric(horizontal: minValue),
          height: 180.0,
          padding: EdgeInsets.symmetric(
              horizontal: minValue, vertical: minValue * 2),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(minValue * 2))),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            "Roll number: ",
                            style: headerTextS,
                          ),
                        ),
                        Flexible(
                          child: Text(
                            "${model.user!.getUserId}",
                            style: dataTextS,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            "Candidate's name: ",
                            style: headerTextS,
                          ),
                        ),
                        Flexible(
                          child: Text(
                            "${model.student!.fullName != null ? model.student!.fullName : (model.student!.getFirstName! + ' ' + model.student!.getMiddleName! + ' ' + model.student!.getLastName!).toUpperCase()}",
                            style: dataTextS,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            "Exam category: ",
                            style: headerTextS,
                          ),
                        ),
                        Flexible(
                          child: Text(
                            "${_exmDetails.candidateType!.toUpperCase()}",
                            style: dataTextS,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            "Exam type: ",
                            style: headerTextS,
                          ),
                        ),
                        Flexible(
                          child: Text(
                            "${_exmDetails.examType!.toUpperCase()}",
                            style: dataTextS,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            "Exam name: ",
                            style: headerTextS,
                          ),
                        ),
                        Flexible(
                          child: Text(
                            "${_exmDetails.examName!.toUpperCase()}",
                            style: dataTextS,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            "Academic session: ",
                            style: headerTextS,
                          ),
                        ),
                        Flexible(
                          child: Text(
                            "${_exmDetails.sessionName}",
                            style: dataTextS,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                height: 110.0,
                width: 110.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(minValue)),
                  image: DecorationImage(
                    image: NetworkImage(model.student!.getWebPhotoPath!),
                  ),
                ),
                child: Container(),
              )
            ],
          ),
        );
      },
    );
  }
}
