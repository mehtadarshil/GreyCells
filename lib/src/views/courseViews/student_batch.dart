import 'package:flutter/material.dart';
import 'package:greycell_app/src/models/courseModel/course_model.dart'
    show StudentBatch;

class MyStudentBatch extends StatelessWidget {
  final List<List<String>> studentBatchList;

  MyStudentBatch({required this.studentBatchList});

  double minValue = 8.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(
          vertical: minValue * 2, horizontal: minValue * 2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: minValue,
          ),
          Text(
            "Batch Info",
            style: Theme.of(context)
                .textTheme
                .headlineMedium!
                .apply(fontWeightDelta: 1, color: Colors.blueGrey[800]),
          ),
          SizedBox(
            height: minValue * 2,
          ),
          ListView.builder(
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              scrollDirection: Axis.vertical,
              itemCount: studentBatchList.length,
              itemBuilder: (context, index) {
                StudentBatch _batch =
                    StudentBatch.fromJson(studentBatchList[index]);
                return Card(
                  margin: EdgeInsets.only(bottom: minValue),
                  color: Colors.grey[50],
                  elevation: 0.0,
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: Row(
                                children: <Widget>[
                                  Text("Course: "),
                                  Text("${_batch.course}")
                                ],
                              ),
                            ),
                            Expanded(
                              child: Row(
                                children: <Widget>[
                                  Text("Discipline: "),
                                  Text("${_batch.discipline}")
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: minValue,
                        ),
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: Row(
                                children: <Widget>[
                                  Text("Batch: "),
                                  Text("${_batch.batch}")
                                ],
                              ),
                            ),
                            Expanded(
                              child: Row(
                                children: <Widget>[
                                  Text("Term: "),
                                  Text("${_batch.term}")
                                ],
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                );
              }),
        ],
      ),
    );
  }
}
