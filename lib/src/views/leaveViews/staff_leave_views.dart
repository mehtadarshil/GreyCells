
import 'package:flutter/material.dart';
import 'package:greycell_app/src/commons/widgets/error_data.dart';
import 'package:greycell_app/src/commons/widgets/user_info.dart';
import 'package:greycell_app/src/manager/main_model.dart';
import 'package:greycell_app/src/models/leaveBalanceModel/leave_balance_model.dart';
import 'package:greycell_app/src/models/response/failure.dart';
import 'package:greycell_app/src/models/response/response.dart';
import 'package:greycell_app/src/views/observer/future_mania.dart';
import 'package:intl/intl.dart';

class LeaveBalanceViews extends StatefulWidget {
  final MainModel model;

  LeaveBalanceViews({required this.model});

  @override
  _LeaveBalanceViewsState createState() => _LeaveBalanceViewsState();
}

class _LeaveBalanceViewsState extends State<LeaveBalanceViews> {
  LeaveBalance? _leaveBalance;
  Future<ResponseMania?>? _myLeaveBalance;

  LeaveDetail? _leaveDetail;

  double minValue = 8.0;

  bool hasCollapse = true;
  String _currentDate = "";

  void _onCreate() async {
    final DateTime _date = DateTime.now();
    final format = DateFormat("dd-MMM-yyyy").format(_date);
    _currentDate = DateFormat.yMMMMd().format(_date);
    _myLeaveBalance = widget.model.getLeaveBalance(asOnDate: format);
  }

  @override
  void initState() {
    super.initState();
    _onCreate();
  }

  Widget _buildLeaveBalanceBody(LeaveDetail _leaveDetail) {
    print("_leaveDetail_leaveDetail_leaveDetail_leaveDetail_leaveDetail");
    print(_leaveDetail.leaveYear);
    print("_leaveDetail_leaveDetail_leaveDetail_leaveDetail_leaveDetail");
    final hedS = Theme.of(context)
        .textTheme
        .headlineMedium!
        .apply(color: Colors.blueGrey);
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
          Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Leave Name:",
                  style: hedS,
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  _leaveDetail == null ? "" : "${_leaveDetail.leaveName}",
                  style: hedS,
                ),
              ],
            ),
          ],
        ),
        SizedBox(
          height: minValue * 3,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Leave Code:",
                  style: hedS,
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  _leaveDetail == null ? "" : "${_leaveDetail.leaveCode}",
                  style: hedS,
                ),
              ],
            ),
          ],
        ),
        SizedBox(
          height: minValue * 3,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Max Annual Allowed:",
                  style: hedS,
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  _leaveDetail == null
                      ? ""
                      : "${_leaveDetail.maxAnnualAllowed}",
                  style: hedS,
                ),
              ],
            ),
          ],
        ),
        SizedBox(
          height: minValue * 3,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Opening Balance:",
                  style: hedS,
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  _leaveDetail == null ? "" : "${_leaveDetail.openingBalance}",
                  style: hedS,
                ),
              ],
            ),
          ],
        ),
        SizedBox(
          height: minValue * 3,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Balance Leave:",
                  style: hedS,
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  _leaveDetail == null ? "" : "${_leaveDetail.balanceLeave}",
                  style: hedS,
                ),
              ],
            ),
          ],
        ),
        SizedBox(
          height: minValue * 3,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Leave Year:",
                  style: hedS,
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  _leaveDetail == null ? "" : "${_leaveDetail.leaveYear}",
                  style: hedS,
                ),
              ],
            ),
          ],
        ),
        SizedBox(
          height: minValue * 3,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "More Times To Avail:",
                  style: hedS,
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  _leaveDetail == null
                      ? ""
                      : "${_leaveDetail.moreTimesToAvail}",
                  style: hedS,
                ),
              ],
            ),
          ],
        ),
        SizedBox(
          height: minValue * 3,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Leaves To Be Credited:",
                  style: hedS,
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  _leaveDetail == null
                      ? ""
                      : "${_leaveDetail.leavesToBeCredited}",
                  style: hedS,
                ),
              ],
            ),
          ],
        ),
        SizedBox(
          height: minValue * 3,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Leave Adjustment:",
                  style: hedS,
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  _leaveDetail == null ? "" : "${_leaveDetail.leaveAdjustment}",
                  style: hedS,
                ),
              ],
            ),
          ],
        ),
        SizedBox(
          height: minValue * 3,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Leave Availed:",
                  style: hedS,
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  _leaveDetail == null ? "" : "${_leaveDetail.leaveAvailed}",
                  style: hedS,
                ),
              ],
            ),
          ],
        ),
      ]),
    );
  }

  Widget _buildFailed(context, Failure failed) {
    return Center(
        child: MyErrorData(
      errorMsg: failed.responseMessage,
      subtitle: "",
    ));
  }

  Widget _buildCurrentDate() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[Text("${_currentDate}")],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Text("Leave Balance"),
      ),
      body: SafeArea(
          top: false,
          bottom: false,
          child: FutureMania(
            future: _myLeaveBalance,
            onError: _buildFailed,
            onFailed: _buildFailed,
            onSuccess: (context, LeaveBalance _leaveBalance) {
              return SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    MyUserInfo(),
                    _buildCurrentDate(),
                    _buildLeaveBalanceBody(_leaveBalance.leaveDetail![0])
                  ],
                ),
              );
            },
          )),
    );
  }
}
