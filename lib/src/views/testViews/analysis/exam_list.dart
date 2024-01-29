import 'package:flutter/material.dart';
import 'package:greycell_app/src/manager/main_model.dart';
import 'package:greycell_app/src/models/analysis/termwise_exam.dart';
import 'package:scoped_model/scoped_model.dart';

class MyExamList extends StatelessWidget {
  double minValue = 8.0;
  final Function onChanged;

  MyExamList({required this.onChanged});

  Widget _buildList(BuildContext context) {
    final activeS = Theme.of(context)
        .textTheme
        .headlineMedium!
        .apply(color: Colors.white, fontWeightDelta: 1);
    final inActiveS = Theme.of(context)
        .textTheme
        .headlineMedium!
        .apply(fontWeightDelta: 1, color: Colors.blueGrey[600]);

    return Container(
//      color: Colors.yellow,
      decoration: BoxDecoration(
//          color: Color(0xffF9FBE7),
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(minValue * 4),
              topLeft: Radius.circular(minValue * 4))),
      margin: EdgeInsets.symmetric(vertical: minValue),
      height: 50.0,
      child: ScopedModelDescendant(builder: (context, _, MainModel model) {
        return ListView.builder(
            padding: EdgeInsets.only(left: minValue),
            scrollDirection: Axis.horizontal,
            itemCount: (model.examList ?? []).length,
            itemBuilder: (context, index) {
              Exam? _exam;
              if (model.examList != null) {
                _exam = model.examList![index];
              } else {
                return SizedBox();
              }
              int currentExamIndex = model.currentExamIndex;
              return InkWell(
                onTap: () => onChanged(index),
                child: Chip(
                    backgroundColor: currentExamIndex == index
                        ? Theme.of(context).primaryColor
                        : Colors.grey[100],
//                        : Colors.transparent,
                    label: Padding(
                      padding: EdgeInsets.all(minValue),
                      child: Text(
                        "${_exam.examName}",
                        style: currentExamIndex == index ? activeS : inActiveS,
                      ),
                    )),
              );
              ;
            });
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildList(context);
  }
}
