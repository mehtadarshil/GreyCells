import 'package:flutter/material.dart';
import 'package:greycell_app/src/commons/actions/dialog_handler.dart';
import 'package:greycell_app/src/commons/actions/message_notifier.dart';
import 'package:greycell_app/src/commons/themes/textstyle.dart';
import 'package:greycell_app/src/config/apiauth_config.dart';
import 'package:greycell_app/src/manager/main_model.dart';
import 'package:greycell_app/src/utils/validation/validation.dart';
import 'package:greycell_app/src/views/authViews/just_driddle.dart';
import 'package:scoped_model/scoped_model.dart';

class MyLoginScreen extends StatefulWidget {
  final bool isSchool;

  MyLoginScreen({this.isSchool = false});

  @override
  _MyLoginScreenState createState() => _MyLoginScreenState();
}

class _MyLoginScreenState extends State<MyLoginScreen> with Validation {
  TextEditingController _userIdController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  bool isError = false;
  String errorMessage = '';
  bool _obSecureText = true;
  bool _autoValidate = false;
  final double _minPadding = 8.0;

  void reset() {
    _userIdController.text = '';
    _passwordController.text = '';
  }

  void onLoginPressed(MainModel mainModel) async {
    if (_globalKey.currentState!.validate()) {
      DialogHandler.showMyLoader(context: context);
      String userId = _userIdController.text;
      String password = _passwordController.text;
      ResponseStatus status =
          await mainModel.onLogin(userId: userId, password: password);
      Navigator.of(context).pop();
      reset();
      if (status == ResponseStatus.ERROR) {
        setState(() {
          isError = true;
          errorMessage = "Invalid credentials";
        });
      } else if (status == ResponseStatus.FAILURE) {
        setState(() {
          isError = true;
          errorMessage = "Invalid credentials";
        });
      } else if (status == ResponseStatus.SUCCESS) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => MyAfterLoginCalled(
                      model: mainModel,
                    )),
            (Route<dynamic> route) => false);
      } else {
        setState(() {
          isError = true;
          errorMessage = "Can't sign in now.";
        });
      }
    } else {
      setState(() => _autoValidate = true);
    }
  }

  Widget _userId() {
    return TextFormField(
      controller: _userIdController,
      keyboardType: TextInputType.text,
      validator: userIdValidator,
      decoration: InputDecoration(
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(_minPadding - 3),
              borderSide: BorderSide(width: 2.0)),
          errorStyle: CustomTextStyle.errorTextStyle,
          labelText: 'User Id',
          labelStyle: CustomTextStyle.loginLabelStyle),
    );
  }

  Widget _password() {
    return TextFormField(
      controller: _passwordController,
      keyboardType: TextInputType.visiblePassword,
      obscureText: _obSecureText,
      validator: loginPasswordValidator,
      decoration: InputDecoration(
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(_minPadding - 3),
              borderSide: BorderSide(width: 2.0)),
          suffixIcon: TextButton(
              child: Text(
                "${_obSecureText ? 'SHOW' : 'HIDE'}",
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.blueGrey),
              ),
              onPressed: () {
                setState(() {
                  _obSecureText = _obSecureText ? false : true;
                });
              }),
          labelText: 'Password',
          errorStyle: CustomTextStyle.errorTextStyle,
          labelStyle: CustomTextStyle.loginLabelStyle),
    );
  }

  Widget _buildHeader() {
    return Container(
      height: MediaQuery.of(context).size.height / 3.5,
//                  color: Colors.red,
      child: ScopedModelDescendant(
        builder: (context, _, MainModel model) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                "${widget.isSchool ? 'Welcome' : 'Welcome back'}",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40.0),
              ),
              sizedBox(),
              Text(
                "${model.school?.schoolName}",
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium!
                    .apply(color: Colors.black),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget sizedBox() {
    return SizedBox(
      height: 18.0,
    );
  }

  Widget _buildTitle() {
    return Container(
      padding: EdgeInsets.all(_minPadding),
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Log in to your account",
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .apply(color: Colors.grey[700], fontWeightDelta: 1),
            textAlign: TextAlign.center,
          ),
//          sizedBox(),
//          Text(
//            "Log in to your account",
//            style: TextStyle(fontSize: 15),
//          )
        ],
      ),
    );
  }

  Widget _buildSubmitBtn() {
    return ScopedModelDescendant(
      builder: (BuildContext contex, _, MainModel mainModel) {
        return Container(
          width: MediaQuery.of(context).size.width,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(_minPadding * 5)),
              backgroundColor: Theme.of(context).primaryColor,
              elevation: 4.6,
              padding: EdgeInsets.all(_minPadding * 2),
            ),
            child: Text(
              "SIGN IN",
              textScaleFactor: 1,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .apply(color: Colors.white),
            ),
            onPressed: () {
              FocusScope.of(context).requestFocus(FocusNode());
              onLoginPressed(mainModel);
            },
          ),
        );
      },
    );
  }

  Widget _buildNotifier() {
    return isError
        ? Container(
            child: MyMessageNotifier.errorNotifier(
                onClose: () {
                  setState(() {
                    isError = false;
                  });
                },
                context: context,
                message: errorMessage),
          )
        : Container();
  }

  Widget _buildForm() {
    return Form(
      key: _globalKey,
      autovalidateMode: AutovalidateMode.always, // _autoValidate,
      child: Column(
        children: <Widget>[
          _buildNotifier(),
          _buildTitle(),
          sizedBox(),
          _userId(),
          sizedBox(),
          sizedBox(),
          _password(),
          sizedBox(),
          sizedBox(),
          _buildSubmitBtn(),
        ],
      ),
    );
  }

  Widget _buildBody() {
    return Container(
      child: ListView(
        children: <Widget>[
          _buildHeader(),
          Container(
            padding: EdgeInsets.symmetric(
                horizontal: _minPadding * 3, vertical: _minPadding * 2),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.all(Radius.circular(_minPadding * 4)),
            ),
            child: _buildForm(),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: Scaffold(
          backgroundColor: Colors.grey[200],
          body: _buildBody(),
        ),
      ),
    );
  }
}
