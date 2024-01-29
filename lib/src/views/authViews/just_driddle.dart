import 'package:flutter/material.dart';
import 'package:greycell_app/src/config/core_config.dart';
import 'package:greycell_app/src/manager/main_model.dart';
import 'package:greycell_app/src/models/student/student_model.dart';
import 'package:greycell_app/src/models/user/staff_model.dart';
import 'package:greycell_app/src/views/homeViews/home_views.dart';

class MyAfterLoginCalled extends StatefulWidget {
  final MainModel model;

  MyAfterLoginCalled({required this.model});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new LoginPageState();
  }
}

class LoginPageState extends State<MyAfterLoginCalled>
    with SingleTickerProviderStateMixin {
  // Animation Controller
  late AnimationController _iconanimationController;
  late Animation<double> _iconAnimation;

  void _onCreate() async {
    if (widget.model.user!.getUserType == Core.STUDENT_USER) {
      Student? _student = await widget.model.getStudentProfile();
      if (_student != null) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => MyHomeViews(
                      model: widget.model,
                    )),
            (Route<dynamic> route) => false);
      }
    } else if (widget.model.user!.getUserType == Core.STAFF_USER) {
      Staff? _staff = await widget.model.getStaffProfile();

      if (_staff != null) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => MyHomeViews(
                      model: widget.model,
                    )),
            (Route<dynamic> route) => false);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _onCreate();
    _iconanimationController = new AnimationController(
        vsync: this, duration: new Duration(milliseconds: 500));
    _iconAnimation = new CurvedAnimation(
        parent: _iconanimationController, curve: Curves.bounceOut);
    _iconAnimation.addListener(() => this.setState(() {}));
    _iconanimationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColorDark,
      body: Stack(
        // Full Screen Body
        fit: StackFit.expand,
        children: <Widget>[
//          Image(
//            image: AssetImage("assets/images/todole.png"),
//            fit: BoxFit.cover,
//            color: Colors.black87, // Black Opacity
//            colorBlendMode: BlendMode.darken,
//          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              CircleAvatar(
                backgroundColor: Colors.white,
                radius: _iconAnimation.value * 50,
                backgroundImage: NetworkImage(widget.model.school!.schoolLogo!),
//                child: Icon(
//                  Icons.school,
//                  color: Theme.of(context).primaryColor,
//                  size: _iconAnimation.value * 65,
//                ),
              ),
              SizedBox(
                height: 25,
              ),
              Text("Welcome to",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: _iconAnimation.value * 25,
                      color: Colors.white)),
              Flexible(
                child: Text(
                  "${widget.model.school!.schoolName}",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: _iconAnimation.value * 35, color: Colors.white),
                ),
              ),
//              SizedBox(
//                width: 80.0,
//                child: LinearProgressIndicator(),
//              ),

//               FlutterLogo(
//                size: _iconAnimation.value * 100,
//              ),
            ],
          )
        ],
      ),
    );
  }

  _onLoginButton() {
    String text = "Login";
    setState(() {});
  }
}
