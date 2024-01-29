import 'package:flutter/material.dart';
import 'package:greycell_app/src/app/routes.dart';
import 'package:greycell_app/src/manager/main_model.dart';
import 'package:greycell_app/src/views/launchViews/splash_views.dart';
import 'package:scoped_model/scoped_model.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case initialRoute:
        return MaterialPageRoute(
          builder: (_) => ScopedModelDescendant(
            builder: (BuildContext context, _, MainModel model) =>
                MySplashViews(
              mainModel: model,
            ),
          ),
        );
      case loginRoute:
        return MaterialPageRoute(builder: (_) => Container());
      case homeRoute:
        return MaterialPageRoute(builder: (_) => Container());
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                      child: Text('No route defined for ${settings.name}')),
                ));
    }
  }
}
