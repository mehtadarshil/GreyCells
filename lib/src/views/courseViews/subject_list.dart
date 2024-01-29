import 'package:flutter/material.dart';
import 'package:greycell_app/src/models/courseModel/course_model.dart';

class MySubjectList extends StatelessWidget {
  final List<List<String>>? subjectList;

  MySubjectList({required this.subjectList});

  double minValue = 8.0;

  @override
  Widget build(BuildContext context) {
    return Container(
//        height: 250.0,
//      color: Colors.red,
        padding:
            EdgeInsets.symmetric(vertical: minValue, horizontal: minValue * 2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "My TimeTable",
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium!
                  .apply(fontWeightDelta: 1, color: Colors.blueGrey[800])
                  .copyWith(fontSize: 24),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              "Total: ${(subjectList ?? []).length}",
              style: Theme.of(context).textTheme.bodySmall!.apply(
                    fontWeightDelta: 1,
                  ),
            ),
            SizedBox(
              height: minValue,
            ),
            ClipRRect(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(minValue * 2),
                  topLeft: Radius.circular(minValue * 2)),
              child: GridView.count(
                crossAxisCount: 2,
                physics: ClampingScrollPhysics(),
                shrinkWrap: true,
                children: (subjectList ?? []).map((rawsubject) {
                  StudentSubject subject = StudentSubject.fromJson(rawsubject);
                  return Card(
                    elevation: 0.0,
                    margin: EdgeInsets.all(8),
                    child: InkWell(
                      onTap: () => null,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "${subject.subjectName}",
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall!
                                .apply(fontWeightDelta: 1)
                                .copyWith(fontSize: 16),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: minValue * 1.8,
                          ),
                          Text(
                            "${subject.subjectCode}",
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ));
  }
}
