// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:greycell_app/src/commons/actions/dialog_handler.dart';
import 'package:greycell_app/src/commons/widgets/error_data.dart';
import 'package:greycell_app/src/commons/widgets/user_info.dart';
import 'package:greycell_app/src/config/data.dart';
import 'package:greycell_app/src/manager/main_model.dart';
import 'package:greycell_app/src/models/noticeModel/notice_model.dart';
import 'package:greycell_app/src/models/student/student_model.dart';
import 'package:greycell_app/src/views/observer/future_observer.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:url_launcher/url_launcher.dart';

class MyNoticeViews extends StatefulWidget {
  final MainModel model;

  MyNoticeViews({required this.model});

  @override
  _MyNoticeViewsState createState() => _MyNoticeViewsState();
}

class _MyNoticeViewsState extends State<MyNoticeViews> {
  double minValue = 8.0;

  String? _fromDate = '';
  String _toDate = '';

  DateTime? _startDate;
  DateTime? _endDate;
  DateTime? _currentDate;

  Future<List<Notice>?>? _futureNoticeList;

  int _defaultDuration = 30;

  int _currentIndex = -1;

  Student? _student;
  Future<Student?>? _studentFuture;
  String getDate(DateTime dateTime) =>
      dateTime.day.toString() +
      '-' +
      CustomDateTime.monthList[dateTime.month - 1]['short']
          .toString()
          .toUpperCase() +
      '-' +
      dateTime.year.toString();

  void _onCreate() async {
    _toDate = getDate(_endDate!);
    if (_fromDate == '') {
      _studentFuture = widget.model.getStudentProfile();
      _student = await _studentFuture;
      if (_student!.getSemStartDate == null) {
        setState(() {
          _fromDate = getDate(_startDate!);
        });
      } else {
        setState(() {
          _fromDate = _student!.getSemStartDate;
        });
      }
    }
    print("I am here.........");
    print(_fromDate);
    print(_toDate);
    _futureNoticeList =
        widget.model.getNotices(fromDate: _fromDate, toDate: _toDate);
  }

  @override
  initState() {
    super.initState();
    print("RunTime Type: ${_currentDate.runtimeType}");
    _currentDate = DateTime.now();
    _startDate = _currentDate!.subtract(Duration(days: _defaultDuration));
    _endDate = _currentDate;
    print("RunTime Type: ${_currentDate.runtimeType}");
    _onCreate();
  }

  void _onTap(int index) {
    setState(() {
      _currentIndex = _currentIndex == index ? -1 : index;
    });
  }

  void openDatePicker(String type) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: _currentDate!,
        firstDate: DateTime(2000, 8),
        lastDate: DateTime(2101));
    if (picked != null) {
      setState(() {
        if (type == 'FROM') {
          _startDate = picked;
          _fromDate = getDate(_startDate!);
        } else {
          _endDate = picked;
          // _toDate = getDate(_endDate);
        }
      });
    }
    if (_startDate != null && _endDate != null) {
      DialogHandler.showMyLoader(context: context);
      _onCreate();
      Navigator.of(context).pop();
      setState(() {});
    }
  }

  // Widget openMessage(Notice notice) {
  //   return Container(
  //       child: Card(
  //         margin: EdgeInsets.symmetric(horizontal: minValue),
  //         elevation: 0.0,
  //         child: Container(
  //           padding: EdgeInsets.all(minValue),
  //           child: Html(
  //             data: notice.message ?? '',
  //             style: {
  //               'b': Style(
  //                 fontWeight: FontWeight.bold,
  //               ),
  //               'p': Style(letterSpacing: 0.5, fontSize: FontSize(15))
  //             },
  //           ),
  //         ),
  //       ),
  //   );
  // }

  Widget openMessage(Notice notice) {
    return ElevatedButton(
        onPressed: _launchURL,
        child: Container(
          child: Card(
            margin: EdgeInsets.symmetric(horizontal: minValue),
            elevation: 0.0,
            child: Container(
              padding: EdgeInsets.all(minValue),
              child: Html(
                onLinkTap: (url, context, data, element) async {
                  if (await canLaunch(url!)) {
                    await launch(
                      url,
                    );
                  } else {
                    throw 'Could not launch $url';
                  }
                },
                data: notice.message ?? '',
                style: {
                  'b': Style(
                    fontWeight: FontWeight.bold,
                  ),
                  'p': Style(letterSpacing: 0.5, fontSize: FontSize(15))
                },
              ),
            ),
          ),
        ));
  }

  // Widget openMessage(Notice notice) {
  //   return Container(
  //       child: MaterialApp(
  //         home: Material(
  //           child: RaisedButton(
  //             onPressed: _launchURL,
  //             child: Text('Show Flutter homepage'),
  //           ),
  //         ),
  //       )
  //   );
  //
  // }

  _launchURL() async {
    // print(notice);
    // print('i am here');
    // const url =
    //     'https://doonschool.org/DOONWebClient/images/RichTextImage/rtixopTVf153501922.pdf';
    // if (await launch(url)) {
    //   await launch(url);
    // } else {
    //   throw 'Could not launch $url';
    // }
  }

  Widget _buildNoticeList(List<Notice> dataSet) {
    return Container(
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: minValue * 2, vertical: minValue * 2),
                child: Text("No of Notices: ${dataSet.length}"),
              )
            ],
          ),
          Expanded(
            child: ListView.separated(
                itemBuilder: (context, index) {
                  Notice _notice = dataSet[index];
                  return Container(
                    margin: _currentIndex == index
                        ? EdgeInsets.all(minValue)
                        : null,
                    decoration: _currentIndex == index
                        ? BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(minValue * 2)))
                        : null,
                    child: Column(
                      children: <Widget>[
                        ListTile(
                          onTap: () => _onTap(index),
                          leading: CircleAvatar(
                            child: Icon(
                              Icons.message,
                              size: 20.0,
                            ),
                          ),
                          title: Text("${_notice.title}"),
                          subtitle: Text("${_notice.id}"),
                          trailing: Container(
                            child: Text(
                              "${_notice.date}",
                              style: Theme.of(context)
                                  .textTheme
                                  .caption!
                                  .apply(fontWeightDelta: 1),
                            ),
                            decoration: BoxDecoration(
                                color: Colors.lightBlue[100],
                                borderRadius: BorderRadius.all(
                                    Radius.circular(minValue * 2))),
                            padding: EdgeInsets.all(minValue),
                          ),
                          isThreeLine: true,
                        ),
                        _currentIndex == index
                            ? openMessage(_notice)
                            : Container()
                      ],
                    ),
                  );
                },
                separatorBuilder: (context, index) => Divider(),
                itemCount: dataSet.length),
          ),
        ],
      ),
    );
  }

  Widget _buildNoticeBody() {
    return FutureObserver<List<Notice>?>(
        future: _futureNoticeList,
        onWaiting: (context) {
          return Container();
        },
        onError: (context, String msg) => MyErrorData(
              errorMsg: msg,
              onReload: _onCreate,
            ),
        onSuccess: (context, List<Notice> data) {
          if (data == null)
            return Container(
              child: Text("Error"),
            );
          if (data.length == 0)
            return Container(
              child: MyErrorData(
                onReload: _onCreate,
                subtitle:
                    "There are no notices found from $_fromDate to $_toDate ",
              ),
            );
          return _buildNoticeList(data);
        });
  }

  Widget _buildFromTo() {
    final hedS = Theme.of(context)
        .textTheme
        .headlineMedium!
        .apply(color: Colors.blueGrey);
    return Container(
      padding: EdgeInsets.all(minValue * 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "From",
                style: hedS,
              ),
              ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.all(Radius.circular(minValue))),
                    backgroundColor: Colors.grey[200],
                    elevation: 0.0,
                  ),
                  onPressed: () => openDatePicker('FROM'),
                  icon: Icon(
                    Icons.calendar_today,
                    size: 20,
                  ),
                  label: Container(
                    margin: EdgeInsets.all(minValue * 1.2),
                    child: Text("$_fromDate"),
                  ))
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "To",
                style: hedS,
              ),
              ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.all(Radius.circular(minValue))),
                    backgroundColor: Colors.grey[200],
                    elevation: 0.0,
                  ),
                  onPressed: () => openDatePicker('TO'),
                  icon: Icon(
                    Icons.calendar_today,
                    size: 20,
                  ),
                  label: Container(
                      margin: EdgeInsets.all(minValue * 1.2),
                      child: Text("$_toDate"))),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notices"),
      ),
      body: Column(
        children: <Widget>[
          MyUserInfo(),
          _buildFromTo(),
          ScopedModelDescendant(builder: (context, _, MainModel model) {
            print("IsLoading: ${model.isLoading}");
            return model.isLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Expanded(child: _buildNoticeBody());
          }),
        ],
      ),
    );
  }
}
