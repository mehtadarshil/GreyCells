import 'package:flutter/material.dart';
import 'package:greycell_app/src/commons/widgets/quick_link_buttons.dart';
import 'package:greycell_app/src/config/core_config.dart';
import 'package:greycell_app/src/manager/main_model.dart';
import 'package:greycell_app/src/models/user/user.dart';
import 'package:greycell_app/src/views/analysisViews/analysis_views.dart';
import 'package:greycell_app/src/views/attendanceViews/attendance_entry.dart';
import 'package:greycell_app/src/views/attendanceViews/attendance_views.dart';
import 'package:greycell_app/src/views/calendarViews/calendar_views.dart';
import 'package:greycell_app/src/views/courseViews/course_views.dart';
import 'package:greycell_app/src/views/examReportDownload/exam_report.dart';
import 'package:greycell_app/src/views/leaveViews/staff_leave_views.dart';
import 'package:greycell_app/src/views/noticeViews/notice_views.dart';
import 'package:greycell_app/src/views/timeTableViews/staff_time_table_views.dart';
import 'package:scoped_model/scoped_model.dart';

class MyQuickLinks extends StatefulWidget {
  final MainModel model;
  final bool isDashboard;

  MyQuickLinks({required this.model, this.isDashboard = false});

  @override
  _MyQuickLinkstate createState() => _MyQuickLinkstate();
}

class _MyQuickLinkstate extends State<MyQuickLinks> {
  double minValue = 8.0;

  late MyMenu _myMenu;
  Future<MyMenu>? _myMenuScheme;

  @override
  void initState() {
    super.initState();
    _onCreate();
  }

  void _onCreate() async {
    // _myMenuScheme = widget.model.getMyMenu();
    _myMenu = (await _myMenuScheme)!;
    print("_myMenu.getMenuListVector.length");
    print(_myMenu.getMenuListVector!.length);
    print("_myMenu.getMenuListVector.length");
  }

  void _moveToPage(BuildContext context, Widget child) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => child));
  }

  Widget _buildStudentLinks(BuildContext context, MainModel model) {
    return Table(
//        columnWidths: {1: IntrinsicColumnWidth(flex: 2)},
      children: [
        TableRow(children: [
          MyQuickLinkButton(
            title: "Attendance",
            iconData: Icons.assignment_turned_in,
            onSelect: () => _moveToPage(
                context,
                MyAttendanceViews(
                  model: model,
                )),
          ),
          MyQuickLinkButton(
            title: "Notices",
            iconData: Icons.message,
            onSelect: () => _moveToPage(
                context,
                MyNoticeViews(
                  model: model,
                )),
          ),
          MyQuickLinkButton(
            title: "Timetable",
            iconData: Icons.book,
            onSelect: () => _moveToPage(
                context,
                MyCourseViews(
                  model: model,
                )),
          ),
        ]),
        TableRow(children: [
          MyQuickLinkButton(
            title: "Calendar",
            iconData: Icons.calendar_today,
            onSelect: () => _moveToPage(
                context,
                MyCalendarEvent(
                  model: model,
                )),
          ),
          // MyQuickLinkButton(
          //   title: "Payment",
          //   iconData: Icons.account_balance_wallet,
          //   onSelect: () => _moveToPage(
          //       context,
          //       MyAccountViews(
          //         model: model,
          //       )),
          // ),
          MyQuickLinkButton(
            title: "Exam Reports",
            iconData: Icons.cloud_download,
            onSelect: () => _moveToPage(
                context,
                MyExamReport(
                  model: model,
                )),
          ),
          // MyQuickLinkButton(
          //   title: "Accounts",
          //   iconData: Icons.account_balance_wallet,
          //   onSelect: () => _moveToPage(
          //       context,
          //       MyAccountViews(
          //         model: model,
          //       )),
          // ),
          MyQuickLinkButton(
            title: "Result",
            iconData: Icons.multiline_chart,
            onSelect: () => _moveToPage(
                context,
                MyAnalysisViews(
                  model: model,
                )),
          ),
        ]),
        // TableRow(children: [
        //   MyQuickLinkButton(
        //     title: "Exam Reports",
        //     iconData: Icons.cloud_download,
        //     onSelect: () => _moveToPage(
        //         context,
        //         MyExamReport(
        //           model: model,
        //         )),
        //   ),
        //   MyQuickLinkButton(
        //     title: "",
        //     // iconData: Icons.account_balance_wallet,
        //     // onSelect: () => _moveToPage(
        //     //     context,
        //     //     MyAccountViews(
        //     //       model: model,
        //     //     )),
        //   ),
        //   MyQuickLinkButton(
        //     title: "",
        //     // iconData: Icons.multiline_chart,
        //     // onSelect: () => _moveToPage(
        //     //     context,
        //     //     MyAnalysisViews(
        //     //       model: model,
        //     //     )),
        //   ),
        // ]),
      ],
    );
  }

  Widget _buildStaffLinks(BuildContext context, MainModel model) {
    return Table(
//        columnWidths: {1: IntrinsicColumnWidth(flex: 2)},
      children: [
        TableRow(children: [
          MyQuickLinkButton(
            title: "Leave Balance",
            iconData: Icons.calendar_today,
            onSelect: () => _moveToPage(
                context,
                LeaveBalanceViews(
                  model: model,
                )),
          ),
          MyQuickLinkButton(
            title: "Notices",
            iconData: Icons.message,
            onSelect: () => _moveToPage(
                context,
                MyNoticeViews(
                  model: model,
                )),
          ),
          MyQuickLinkButton(
            title: "Time Table",
            iconData: Icons.timelapse,
            onSelect: () => _moveToPage(
                context,
                TimeTableViews(
                  model: model,
                )),
          ),
        ]),
        TableRow(children: [
          model.staff.getDesignation == 'TEACHER'
              ? MyQuickLinkButton(
                  title: "Attendance Entry",
                  iconData: Icons.assignment_turned_in,
                  onSelect: () => _moveToPage(
                      context,
                      MyAttendanceEntry(
                        model: model,
                      )),
                )
              : Container(),
          Container(),
          Container(),
        ]),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final sStyle = Theme.of(context).textTheme.headlineMedium;

    return ScopedModelDescendant(
      builder: (context, _, MainModel model) {
        return model.user == null
            ? Container()
            : Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
//              color: Colors.grey[100],
                    borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(minValue * 3),
                  topRight: Radius.circular(minValue * 3),
                )),
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(minValue * 3),
                    topRight: Radius.circular(minValue * 3),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: minValue, horizontal: minValue * 2),
                        child: Text(
                          "Quick Links",
                          style: sStyle!.apply(color: Colors.black87),
                        ),
                      ),
                      model.user!.getUserType == Core.STUDENT_USER
                          ? _buildStudentLinks(context, model)
                          : _buildStaffLinks(context, model)
                    ],
                  ),
                ),
              );
      },
    );
  }
}
