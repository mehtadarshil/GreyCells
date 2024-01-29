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
        .apply(fontWeightDelta: 1, color: Colors.white);
    final inActiveS = Theme.of(context).textTheme.headlineMedium!.apply(
          color: Colors.white70,
          fontWeightDelta: 1,
        );

    return Container(
//      color: Colors.yellow,
      decoration: BoxDecoration(
//          color: Color(0xffF9FBE7),
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(minValue * 4),
              topLeft: Radius.circular(minValue * 4))),
//      margin: EdgeInsets.symmetric(vertical: minValue),
      height: 50.0,
      child: ScopedModelDescendant(builder: (context, _, MainModel model) {
        if ((model.examList ?? []).length == 0)
          return Text(
            "Loading...",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white70),
          );
        return ListView.builder(
            padding: EdgeInsets.only(left: minValue),
            scrollDirection: Axis.horizontal,
            itemCount: model.examList?.length,
            itemBuilder: (context, index) {
              Exam _exam = model.examList![index];
              int currentExamIndex = model.currentExamIndex;
              return InkWell(
                onTap: () => onChanged(index),
                child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      border: Border(
                          bottom: BorderSide(
                              color: currentExamIndex == index
                                  ? Colors.grey[100]!
                                  : Theme.of(context).primaryColor,
                              width: 3)),
                    ),
//                        : Colors.transparent,
                    child: Padding(
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
