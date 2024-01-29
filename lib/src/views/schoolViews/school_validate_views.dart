import 'package:flutter/material.dart';
import 'package:greycell_app/src/commons/actions/dialog_handler.dart';
import 'package:greycell_app/src/commons/actions/message_notifier.dart';
import 'package:greycell_app/src/commons/logo/MyLogo.dart';
import 'package:greycell_app/src/commons/themes/textstyle.dart';
import 'package:greycell_app/src/config/apiauth_config.dart';
import 'package:greycell_app/src/manager/main_model.dart';
import 'package:greycell_app/src/utils/validation/validation.dart';
import 'package:greycell_app/src/views/authViews/login_views.dart';
import 'package:scoped_model/scoped_model.dart';

class MySchoolValidate extends StatefulWidget {
  @override
  _MySchoolValidateState createState() => _MySchoolValidateState();
}

class _MySchoolValidateState extends State<MySchoolValidate> with Validation {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _schoolController = TextEditingController();
  double _minValue = 8.0;

  bool _autoValidate = false;
  bool isError = false;
  String message = "";

  @override
  void initState() {
    super.initState();
//    SystemConfig.makeStatusBarVisible();
  }

  void onSubmit(MainModel model) async {
    if (_formKey.currentState!.validate()) {
      // do
      DialogHandler.showMyLoader(context: context);
      ResponseStatus responseStatus =
          await model.schoolValidate(schoolCode: _schoolController.text);
      Navigator.of(context).pop();
      _schoolController.text = '';
      print(responseStatus);
      if (responseStatus == ResponseStatus.ERROR) {
        setState(() {
          message = "Error occured. Please check your connectivity";
          isError = true;
        });
      } else if (responseStatus == ResponseStatus.FAILURE) {
        setState(() {
          message = "Invalid school code";
          isError = true;
        });
      } else if (responseStatus == ResponseStatus.SUCCESS) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => MyLoginScreen(
                      isSchool: true,
                    )));
      }
//      await Future.delayed(Duration(seconds: 2));

//      if (_schoolController.text == "1234") {
//        setState(() {
//          isError = false;
//        });
//        Navigator.push(
//            context,
//            MaterialPageRoute(
//                builder: (BuildContext context) => MyLoginScreen()));
//      } else {
//        setState(() {
//          isError = true;
//        });
//      }
    } else {
      setState(() => _autoValidate = true);
    }
  }

  Widget sizedBox() {
    return SizedBox(
      height: 18.0,
    );
  }

  Widget _buildButton() {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: ScopedModelDescendant(builder: (context, _, MainModel model) {
        return ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: _minValue * 2),
            elevation: 4.0,
            backgroundColor: Theme.of(context).primaryColor,
          ),
          onPressed: () => onSubmit(model),
          clipBehavior: Clip.antiAlias,
          child: Text(
            "SUBMIT",
            style: CustomTextStyle.buttonStyle,
          ),
        );
      }),
    );
  }

  Widget _buildTextField() {
    return TextFormField(
      validator: schoolCodeValidator,
      controller: _schoolController,
      decoration: InputDecoration(
          errorStyle: CustomTextStyle.errorTextStyle,
          labelText: "School Code",
          labelStyle: CustomTextStyle.labelStyle,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(_minValue),
              borderSide: BorderSide())),
    );
  }

  Widget _buildForm() {
    final title =
        Theme.of(context).textTheme.headlineMedium!.apply(fontWeightDelta: 1);
    final suby = Theme.of(context).textTheme.headlineSmall;
    final st = Theme.of(context).textTheme.titleMedium;
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: Container(
        child: Form(
            key: _formKey,
            autovalidateMode: _autoValidate
                ? AutovalidateMode.always
                : AutovalidateMode.disabled,
            child: ListView(
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height / 3,
//                  color: Colors.red,
                  child: Center(
                      child: MyLogo(
                    hasVertical: true,
                    elevation: 0.0,
                    backgroundColor: Colors.grey[100],
                  )),
                ),
                isError
                    ? Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: _minValue * 2,
                        ),
                        child: MyMessageNotifier.errorNotifier(
                            context: context,
                            message: message,
                            onClose: () {
                              setState(() {
                                isError = false;
                              });
                            }),
                      )
                    : Container(),
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: _minValue * 4, vertical: _minValue * 3),
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "School Validation",
                        style: title,
                      ),
                      sizedBox(),
                      Text(
                        "Enter school code",
                        style: suby,
                      ),
                      sizedBox(),
                      _buildTextField(),
                      sizedBox(),
                      sizedBox(),
                      _buildButton()
                    ],
                  ),
                )
              ],
            )),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//        appBar: AppBar(),
        backgroundColor: Colors.grey[100],
        body: _buildForm());
  }
}
