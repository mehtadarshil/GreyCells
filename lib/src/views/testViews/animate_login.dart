import 'package:flutter/material.dart';

class MyAnimateLoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new LoginPageState();
  }
}

class LoginPageState extends State<MyAnimateLoginPage>
    with SingleTickerProviderStateMixin {
  // Animation Controller
  late AnimationController _iconanimationController;
  late Animation<double> _iconAnimation;

  @override
  void initState() {
    super.initState();
    _iconanimationController = new AnimationController(
        vsync: this, duration: new Duration(milliseconds: 500));
    _iconAnimation = new CurvedAnimation(
        parent: _iconanimationController, curve: Curves.bounceInOut);
    _iconAnimation.addListener(() => this.setState(() {}));
    _iconanimationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.blue,
      body: new Stack(
        // Full Screen Body
        fit: StackFit.expand,
        children: <Widget>[
          new Image(
            image: new AssetImage("assets/images/todole.png"),
            fit: BoxFit.cover,
            color: Colors.black87, // Black Opacity
            colorBlendMode: BlendMode.darken,
          ),
          new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new FlutterLogo(
                size: _iconAnimation.value * 100,
              ),
              new Form(
                  child: new Theme(
                data: new ThemeData(
                    brightness: Brightness.dark,
                    primarySwatch: Colors.amber,
                    inputDecorationTheme: InputDecorationTheme(
                        labelStyle:
                            new TextStyle(color: Colors.amber, fontSize: 20.5),
                        fillColor: Colors.indigoAccent)),
                child: Container(
                  padding: EdgeInsets.all(40.0),
                  child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      // Email Field
                      new TextFormField(
                        decoration: InputDecoration(labelText: "Enter Email"),
                        keyboardType: TextInputType.emailAddress,
                      ),
                      // Email Field
                      new TextFormField(
                        decoration:
                            InputDecoration(labelText: "Enter Password"),
                        keyboardType: TextInputType.text,
                        obscureText: true,
                      ),
                      new Padding(padding: EdgeInsets.only(top: 30.3)),
                      new MaterialButton(
                        height: 50,
                        minWidth: 160,
                        color: Colors.red,
                        textColor: Colors.white,
                        child: new Text("Login"),
                        onPressed: () => {},
                        splashColor: Colors.white,
                      )
                    ],
                  ),
                ),
              ))
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
