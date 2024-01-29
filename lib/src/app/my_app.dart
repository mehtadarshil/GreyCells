import 'package:flutter/material.dart' hide Router;
import 'package:greycell_app/src/app/router.dart';
import 'package:greycell_app/src/app/routes.dart';
import 'package:greycell_app/src/commons/themes/dark_theme.dart';
import 'package:greycell_app/src/config/core_config.dart';
import 'package:greycell_app/src/manager/main_model.dart';
import 'package:scoped_model/scoped_model.dart';

class MyApp extends StatelessWidget {
  final MainModel model;

  MyApp({required this.model});

  @override
  Widget build(BuildContext context) {
    return ScopedModel<MainModel>(
      model: model,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: Core.APPNAME,
        theme: lightTheme,
//        routes: Router.routes,
        initialRoute: initialRoute,
        onGenerateRoute: Router.generateRoute,
      ),
    );
  }
}
