import 'package:flutter/material.dart';
import 'package:greycell_app/src/app/my_app.dart';
import 'package:greycell_app/src/config/system_config.dart';
import 'package:greycell_app/src/manager/main_model.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemConfig.makeStatusBarHide();
  final MainModel _model = MainModel();

  await _model.handleVersion();
  _model.autoSchoolValidate();
  _model.autoAuthenticateUser();
  await initializeDateFormatting();

  runApp(MyApp(
    model: _model,
  ));
  // Version
//  getPackageInfo(_model);
}
