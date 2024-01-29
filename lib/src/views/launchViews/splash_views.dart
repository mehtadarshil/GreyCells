import 'package:flutter/material.dart';
import 'package:greycell_app/src/commons/logo/MyLogo.dart';
import 'package:greycell_app/src/manager/main_model.dart';
import 'package:greycell_app/src/views/authViews/just_driddle.dart';
import 'package:greycell_app/src/views/authViews/login_views.dart';
import 'package:greycell_app/src/views/homeViews/home_views.dart';
import 'package:greycell_app/src/views/schoolViews/school_validate_views.dart';

class MySplashViews extends StatefulWidget {
  final MainModel mainModel;

  MySplashViews({required this.mainModel});

  @override
  _MySplashViewsState createState() => _MySplashViewsState();
}

class _MySplashViewsState extends State<MySplashViews> {
  void doNotDecide() async {
    await Future.delayed(Duration(seconds: 1));
    Widget _child = Container();
    if (widget.mainModel.school == null) {
      _child = MySchoolValidate();
    } else if (widget.mainModel.user == null) {
      _child = MyLoginScreen();
    } else if (widget.mainModel.student == null) {
      _child = MyAfterLoginCalled(
        model: widget.mainModel,
      );
    } else if (widget.mainModel.user != null) {
      _child = MyHomeViews(
        model: widget.mainModel,
      );
    }
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (BuildContext context) => _child),
        (Route<dynamic> route) => false);
  }

  @override
  void initState() {
    super.initState();
    doNotDecide();
//    _iconanimationController = new AnimationController(
//        vsync: this, duration: new Duration(milliseconds: 500));
//    _iconAnimation = new CurvedAnimation(
//        parent: _iconanimationController, curve: Curves.bounceInOut);
//    _iconAnimation.addListener(() => this.setState(() {}));
//    _iconanimationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColorDark,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Center(child: SizedBox(height: 90, width: 270, child: MyLogo())),
      ),
    );
  }
}
