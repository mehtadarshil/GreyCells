import 'package:flutter/material.dart';
import 'package:greycell_app/src/commons/widgets/quick_links.dart';
import 'package:greycell_app/src/config/core_config.dart';
import 'package:greycell_app/src/manager/main_model.dart';
import 'package:greycell_app/src/views/attendanceViews/attendance_views.dart';
import 'package:scoped_model/scoped_model.dart';

class MyDashboardScreen extends StatelessWidget {
  double minValue = 8.0;

  Widget _buildGraphCard(BuildContext context, MainModel model) {
    final sStyle = Theme.of(context).textTheme.headlineMedium;

    return Card(
      elevation: 0.0,
      margin: EdgeInsets.all(minValue * 2),
      child: model.user!.getUserType == Core.STUDENT_USER
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(vertical: minValue),
                  child: Text(
                    "${model.user!.getUserType == Core.STUDENT_USER ? 'Attendance' : ''}",
                    style: sStyle!.apply(color: Colors.black87),
                  ),
                ),
                model.user!.getUserType == Core.STUDENT_USER
                    ? Container(
                        padding: EdgeInsets.symmetric(horizontal: minValue),
                        height: MediaQuery.of(context).size.height / 3,
                        child: MyAttendanceViews(
                          model: model,
                          isDashboard: true,
                        ),
                      )
                    : Container(),
              ],
            )
          : Container(),
    );
  }

  Widget _buildBody(BuildContext context) {
    return ScopedModelDescendant(
      builder: (context, _, MainModel model) {
        return Container(
//          decoration: BoxDecoration(
//              color: Colors.red,
//              borderRadius: BorderRadius.only(
//                  topRight: Radius.circular(minValue * 83),
//                  topLeft: Radius.circular(minValue * 3))),
          child: ListView(
            children: [
              _buildGraphCard(context, model),
              MyQuickLinks(model: model),
              // ListView.builder(
              //     shrinkWrap: true,
              //     physics: ScrollPhysics(),
              //     itemCount: 5,
              //     itemBuilder: (BuildContext context, int index) {
              //       return ListTile(
              //           leading: const Icon(Icons.list),
              //           trailing: const Text(
              //             "GFG",
              //             style: TextStyle(color: Colors.green, fontSize: 15),
              //           ),
              //           title: Text("List item $index"));
              //     }),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: _buildBody(context),
    );
  }
}
