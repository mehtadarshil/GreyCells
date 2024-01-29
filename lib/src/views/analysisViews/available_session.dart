import 'package:flutter/material.dart';
import 'package:greycell_app/src/manager/main_model.dart';
import 'package:greycell_app/src/models/analysis/available_term.dart';
import 'package:scoped_model/scoped_model.dart';

class MyAvailableSession extends StatelessWidget {
  final List<AvailableSession>? sessionList;

//  final int classIndex;
  final double minValue = 8.0;
  final Function onChanged;

  MyAvailableSession({required this.sessionList, required this.onChanged});

  Widget _availSession(BuildContext context) {
    final activeS = Theme.of(context)
        .textTheme
        .headlineMedium!
        .apply(color: Theme.of(context).primaryColorDark, fontWeightDelta: 1);
    final inActiveS = Theme.of(context)
        .textTheme
        .headlineMedium!
        .apply(color: Colors.black54, fontWeightDelta: 1);

    return Container(
      margin: EdgeInsets.only(top: minValue),
      height: 56.0,
      decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(minValue * 2),
              topRight: Radius.circular(minValue * 2))),
      alignment: Alignment.center,
      child: ScopedModelDescendant(
        builder: (context, _, MainModel model) {
          if (sessionList == null || sessionList!.length == 0)
            return Container();
          int classIndex = model.currentSessionIndex;
          print("Current Session Index: $classIndex");
          return ListView.builder(
              itemCount: sessionList!.length,
//          padding: EdgeInsets.only(left: minValue),
              scrollDirection: Axis.horizontal,
              reverse: true,
              itemBuilder: (context, index) {
                AvailableSession _session = sessionList![index];
                return InkWell(
                  onTap: () => onChanged(index),
                  child: Container(
                    width: MediaQuery.of(context).size.width / 2,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: classIndex == index
                          ? Colors.grey[200]
                          : Colors.transparent,
                      shape: BoxShape.rectangle,
//                      borderRadius:
//                          BorderRadius.all(Radius.circular(minValue * 2))
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.class_,
                          color: classIndex == index
                              ? Theme.of(context).primaryColorDark
                              : Colors.blueGrey[800],
                          size: 20,
                        ),
                        SizedBox(
                          width: minValue,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "${_session.sessionName}",
                              style: classIndex == index ? activeS : inActiveS,
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              "Class",
                              style: TextStyle(
                                  color: classIndex == index
                                      ? Theme.of(context).primaryColorDark
                                      : Colors.black54),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              });
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _availSession(context);
  }
}
