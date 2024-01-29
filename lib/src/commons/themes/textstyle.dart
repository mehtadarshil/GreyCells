import 'package:flutter/material.dart';

class CustomTextStyle {
  BuildContext? _context;

  CustomTextStyle(BuildContext? context) {
    _context = context;
  }

  static TextStyle errorTextStyle = TextStyle(
    color: Colors.red,
    fontSize: 18.0,
  );
  static TextStyle labelStyle =
      TextStyle(fontSize: 20.0, fontWeight: FontWeight.w400);
  static TextStyle loginLabelStyle = TextStyle(
      fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.blueGrey[700]);
  static TextStyle buttonStyle = TextStyle(
      fontSize: 18.0, color: Colors.white, fontWeight: FontWeight.bold);

  TextStyle? get headline6 => Theme.of(_context!).textTheme.titleLarge;

  TextStyle? get headline5 => Theme.of(_context!).textTheme.headlineSmall;

  TextStyle? get headline4 => Theme.of(_context!).textTheme.headlineMedium;

  TextStyle? get headline3 => Theme.of(_context!).textTheme.displaySmall;

  TextStyle? get headline2 => Theme.of(_context!).textTheme.displayMedium;

  TextStyle? get headline1 => Theme.of(_context!).textTheme.displayLarge;

  TextStyle? get subtitle1 => Theme.of(_context!).textTheme.titleMedium;

  TextStyle? get subtitle2 => Theme.of(_context!).textTheme.titleSmall;

  TextStyle? get bodyText2 => Theme.of(_context!).textTheme.bodyMedium;

  TextStyle? get bodyText1 => Theme.of(_context!).textTheme.bodyLarge;

  TextStyle? get caption => Theme.of(_context!).textTheme.bodySmall;

  TextStyle? get button => Theme.of(_context!).textTheme.labelLarge;
}
