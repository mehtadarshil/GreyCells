import 'package:flutter/material.dart';
import 'package:greycell_app/src/config/core_config.dart';
import 'package:greycell_app/src/manager/main_model.dart';
import 'package:greycell_app/src/models/user/user.dart';
import 'package:greycell_app/src/views/accountViews/account_views.dart';
import 'package:greycell_app/src/views/analysisViews/analysis_views.dart';
import 'package:greycell_app/src/views/attendanceViews/attendance_entry.dart';
import 'package:greycell_app/src/views/attendanceViews/attendance_views.dart';
import 'package:greycell_app/src/views/calendarViews/calendar_views.dart';
import 'package:greycell_app/src/views/courseViews/course_views.dart';
import 'package:greycell_app/src/views/dashboardViews/dahboard_views.dart';
import 'package:greycell_app/src/views/examReportDownload/exam_report.dart';
import 'package:greycell_app/src/views/leaveViews/staff_leave_views.dart';
import 'package:greycell_app/src/views/noticeViews/notice_views.dart';
import 'package:greycell_app/src/views/timeTableViews/staff_time_table_views.dart';
import 'package:greycell_app/src/views/userViews/staffViews/staff_profile_views.dart';
import 'package:greycell_app/src/views/userViews/studentViews/profile_views.dart';
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

  MyMenu? _myMenu;
  Future<MyMenu?>? _myMenuScheme;

  late UserMenu _userMenu;
  IconData? icon;

  List<Choice> choices = const <Choice>[];

  List<UserMenu>? _menus;

  @override
  void initState() {
    _myMenuScheme = widget.model.getMyMenu();
    super.initState();
    _onCreate();
  }

  void _onCreate() async {
    // _myMenuScheme = widget.model.getMyMenu();
    _myMenu = await _myMenuScheme;
    setState(() {
      _menus = _myMenu!.getMenuListVector;
    });
  }

  void _moveToPage(BuildContext context, Widget child) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => child));
  }

  Widget _buildStudentLinks(BuildContext context, MainModel model) {
    return _menus != null
        ? ListView.builder(
            shrinkWrap: true,
            physics: ScrollPhysics(),
            itemCount: _menus!.length,
            itemBuilder: (BuildContext context, int index) {
              var page;
              _userMenu = _menus![index];
              switch (_userMenu.mobileappMenuCode) {
                case "ATTENDANCE":
                  {
                    icon = Icons.assignment_turned_in;
                    page = MyAttendanceEntry(
                      model: model,
                    );
                  }
                  break;
                case "FACTIMETBL":
                  {
                    icon = Icons.timelapse;
                    page = TimeTableViews(
                      model: model,
                    );
                  }
                  break;
                case "LEAVEVIEW":
                  {
                    icon = Icons.calendar_today;
                    page = LeaveBalanceViews(
                      model: model,
                    );
                  }
                  break;
                case "STFPROFILE":
                  {
                    icon = Icons.portrait;
                    page = StaffProfileViews(
                      model: model,
                    );
                  }
                  break;
                case "VIEWNOTICE":
                  {
                    icon = Icons.message;
                    page = MyNoticeViews(
                      model: model,
                    );
                  }
                  break;
                case "ONLINEPAYMENT":
                  {
                    icon = Icons.account_balance_wallet;
                    page = MyAccountViews(
                      model: model,
                    );
                  }
                  break;
                case "MYPRO":
                  {
                    icon = Icons.portrait;
                    page = MyProfileViews(
                      model: model,
                    );
                  }
                  break;
                case "MYTIMETABLE":
                  {
                    icon = Icons.book;
                    page = MyCourseViews(
                      model: model,
                    );
                  }
                  break;
                case "ATTSUMMERY":
                  {
                    icon = Icons.assignment_turned_in;
                    page = MyAttendanceViews(
                      model: model,
                    );
                  }
                  break;
                case "VIEWCAL":
                  {
                    icon = Icons.calendar_today;
                    page = MyCalendarEvent(
                      model: model,
                    );
                  }
                  break;
                case "MARKDTL":
                  {
                    icon = Icons.multiline_chart;
                    page = MyAnalysisViews(
                      model: model,
                    );
                  }
                  break;
                case "RPTCARDS":
                  {
                    icon = Icons.cloud_download;
                    page = MyExamReport(
                      model: model,
                    );
                  }
                  break;
                default:
                  {
                    icon = Icons.list;
                    page = MyDashboardScreen();
                  }
                  break;
              }
              return ListTile(
                // leading: const Icon(Icons.list),
                leading: new Icon(icon),
                trailing: const Text(
                  "View",
                  style: TextStyle(color: Colors.green, fontSize: 15),
                ),
                title: Text("${_userMenu.mobileappMenuName}"),
                onTap: () => _moveToPage(context, page),
              );
              // return MyQuickLinkButton(
              //   title: "${_userMenu.mobileappMenuName}",
              //   iconData: icon,
              //   onSelect: () => _moveToPage(
              //       context,
              //       LeaveBalanceViews(
              //         model: model,
              //       )),
              // );
            })
        : SizedBox();
  }

  Widget _buildStaffLinks(BuildContext context, MainModel model) {
    return _menus != null
        ? ListView.builder(
            shrinkWrap: true,
            physics: ScrollPhysics(),
            itemCount: _menus!.length,
            itemBuilder: (BuildContext context, int index) {
              var page;
              _userMenu = _menus![index];
              switch (_userMenu.mobileappMenuCode) {
                case "VIEWCAL":
                  {
                    icon = Icons.list;
                    page = MyCalendarEvent(
                      model: model,
                    );
                  }
                  break;
                case "ATTENDANCE":
                  {
                    icon = Icons.assignment_turned_in;
                    page = MyAttendanceEntry(
                      model: model,
                    );
                  }
                  break;
                case "FACTIMETBL":
                  {
                    icon = Icons.timelapse;
                    page = TimeTableViews(
                      model: model,
                    );
                  }
                  break;
                case "LEAVEVIEW":
                  {
                    icon = Icons.calendar_today;
                    page = LeaveBalanceViews(
                      model: model,
                    );
                  }
                  break;
                case "STFPROFILE":
                  {
                    icon = Icons.portrait;
                    page = StaffProfileViews(
                      model: model,
                    );
                  }
                  break;
                case "MYTIMETABLE":
                  {
                    icon = Icons.timelapse;
                    page = TimeTableViews(
                      model: model,
                    );
                  }
                  break;
                case "VIEWNOTICE":
                  {
                    icon = Icons.message;
                    page = MyNoticeViews(
                      model: model,
                    );
                  }
                  break;
                case "ONLINEPAYMENT":
                  {
                    icon = Icons.account_balance_wallet;
                    page = MyAccountViews(
                      model: model,
                    );
                  }
                  break;
                case "MYPRO":
                  {
                    icon = Icons.portrait;
                    page = MyProfileViews(
                      model: model,
                    );
                  }
                  break;
                case "ATTSUMMERY":
                  {
                    icon = Icons.assignment_turned_in;
                    page = MyAttendanceViews(
                      model: model,
                    );
                  }
                  break;
                default:
                  {
                    icon = Icons.list;
                    page = MyDashboardScreen();
                  }
                  break;
              }
              return ListTile(
                // leading: const Icon(Icons.list),
                leading: new Icon(icon),
                trailing: const Text(
                  "View",
                  style: TextStyle(color: Colors.green, fontSize: 15),
                ),
                title: Text("${_userMenu.mobileappMenuName}"),
                onTap: () => _moveToPage(context, page),
              );
              // return MyQuickLinkButton(
              //   title: "${_userMenu.mobileappMenuName}",
              //   iconData: icon,
              //   onSelect: () => _moveToPage(
              //       context,
              //       LeaveBalanceViews(
              //         model: model,
              //       )),
              // );
            })
        : SizedBox();
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

class Choice {
  const Choice({this.title, this.icon});
  final String? title;
  final IconData? icon;
}
