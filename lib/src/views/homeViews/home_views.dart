import 'package:flutter/material.dart';
import 'package:greycell_app/src/commons/actions/my_drawer.dart';
import 'package:greycell_app/src/commons/themes/textstyle.dart';
import 'package:greycell_app/src/config/core_config.dart';
import 'package:greycell_app/src/config/system_config.dart';
import 'package:greycell_app/src/manager/main_model.dart';
import 'package:greycell_app/src/views/dashboardViews/dahboard_views.dart';
import 'package:greycell_app/src/views/paymentViews/payment_body.dart';
import 'package:scoped_model/scoped_model.dart';

class MyHomeViews extends StatefulWidget {
  final MainModel? model;
  final int index;

  const MyHomeViews({Key? key, this.model, this.index = 0}) : super(key: key);

  @override
  _MyHomeViewsState createState() => _MyHomeViewsState();
}

class _MyHomeViewsState extends State<MyHomeViews> {
  int _currentIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SystemConfig.makeStatusBarVisible();
    _currentIndex = widget.index;
  }

  List<Widget> getPaymentAction() {
    return _currentIndex == 0
        ? <Widget>[Container()]
        : <Widget>[
            ScopedModelDescendant(
              builder: (_, __, MainModel mainModel) {
                return Stack(
                  alignment: Alignment.topRight,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.payment),
                      onPressed: () => null,
                      color: Colors.white,
                      tooltip: "Payment Head Counter",
//              iconSize: 25.0,
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 2),
                      padding: EdgeInsets.all(3),
                      decoration: BoxDecoration(
                          color: Colors.red, shape: BoxShape.circle),
                      child: Text(
                        "${mainModel.selectedPayableFees.length}",
                        style: CustomTextStyle(context)
                            .caption!
                            .apply(fontWeightDelta: 1, color: Colors.white),
                      ),
                    )
                  ],
                );
              },
            ),
            SizedBox(
              width: minValue * 1.5,
            )
          ];
  }

  double minValue = 8.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${_currentIndex == 0 ? 'Dashboard' : 'Payment'}"),
      ),
      backgroundColor: Theme.of(context).primaryColor,
      drawer: MyDrawer(),
      body: widget.model!.user == null
          ? Container()
          : Container(
              child: [
                MyDashboardScreen(),
                widget.model!.user!.getUserType == Core.STUDENT_USER
                    ? PaymentBodyView(
                        model: widget.model,
                      )
                    : Container()
              ].elementAt(_currentIndex),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(minValue * 3),
                      topLeft: Radius.circular(minValue * 3))),
            ),
      // bottomNavigationBar: MyBottomNavigation(
      //   onTap: (int index) {
      //     setState(() {
      //       _currentIndex = index;
      //     });
      //   },
      //   index: _currentIndex,
      // ),
    );
  }
}
