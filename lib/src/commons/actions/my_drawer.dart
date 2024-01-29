import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:greycell_app/src/config/core_config.dart';
import 'package:greycell_app/src/manager/main_model.dart';
import 'package:greycell_app/src/views/authViews/login_views.dart';
import 'package:greycell_app/src/views/generalViews/about_school.dart';
import 'package:greycell_app/src/views/generalViews/app_info.dart';
import 'package:greycell_app/src/views/generalViews/help_views.dart';
import 'package:greycell_app/src/views/userViews/staffViews/staff_profile_views.dart';
import 'package:scoped_model/scoped_model.dart';

import 'package:greycell_app/src/views/userViews/studentViews/profile_views.dart';

class MyDrawer extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MyDrawerState();
  }
}

class MyDrawerState extends State<MyDrawer> {
  String getName(MainModel model) {
    print("Name: ${model.student?.fullName}");
    return model.student?.fullName != null
        ? model.student!.fullName
        : "${model.student!.getFirstName! + (model.student!.getMiddleName!.trim().isNotEmpty ? (' ' + model.student!.getMiddleName!) : "") + (model.student!.getLastName!.trim().isNotEmpty ? (' ' + model.student!.getLastName!) : "")}";
  }

  Widget _getProfilePic(String imageURL) {
    return CachedNetworkImage(
      imageUrl: imageURL,
      imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                  Theme.of(context).primaryColor, BlendMode.dstIn)),
        ),
      ),
      placeholder: (context, url) => Center(
        child: CircularProgressIndicator(),
      ),
      errorWidget: (context, url, error) => Icon(
        Icons.person,
        size: 65.0,
        color: Colors.grey,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant(
      builder: (BuildContext context, Widget? child, MainModel model) {
        return Drawer(
          child: model.user == null
              ? Container()
              : Column(
                  children: <Widget>[
                    Expanded(
                      child: ListView(
                        children: <Widget>[
                          model.student == null && model.staff == null
                              ? Container(
                                  child: Center(
                                    child: Text(
                                      "Menu",
                                      textAlign: TextAlign.center,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium!
                                          .apply(color: Colors.white),
                                    ),
                                  ),
                                  height: kToolbarHeight,
                                  decoration: BoxDecoration(
                                      color:
                                          Theme.of(context).primaryColorDark),
                                )
                              : model.user!.getUserType == Core.STUDENT_USER
                                  ? UserAccountsDrawerHeader(
                                      onDetailsPressed: () =>
                                          _onDetailsPressed(model, "STUDENT"),
                                      accountName: Text("${getName(model)}"),
                                      accountEmail:
                                          Text(model.user!.getUserId!),
                                      currentAccountPicture: GestureDetector(
                                        onTap: () =>
                                            _onDetailsPressed(model, "STUDENT"),
                                        child: Hero(
                                          tag: 'profileHero',
                                          child: CircleAvatar(
                                              backgroundColor: Colors.grey[100],
                                              child: _getProfilePic(model
                                                  .student!.getWebPhotoPath!)),
                                        ),
                                      ),
                                    )
                                  : UserAccountsDrawerHeader(
                                      onDetailsPressed: () =>
                                          _onDetailsPressed(model, "STAFF"),
                                      accountName:
                                          Text("${model.staff.getStaffName}"),
                                      accountEmail: Text(model.staff.getEmail!),
                                      currentAccountPicture: GestureDetector(
                                        onTap: () =>
                                            _onDetailsPressed(model, "STAFF"),
                                        child: Hero(
                                          tag: 'profileHero',
                                          child: CircleAvatar(
                                              backgroundColor: Colors.grey[100],
                                              child: _getProfilePic(model
                                                  .staff.getWebPhotoPath!)),
                                        ),
                                      ),
                                    ),
                          ListTile(
                            title: Text("About"),
                            onTap: () {
                              Navigator.of(context).pop();
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MyAboutSchool(
                                            model: model,
                                          )));
                            },
                            leading: Icon(
                              Icons.school,
                            ), //,
                          ),
//                    Divider(),
                          ListTile(
                            title: Text("Help"),
                            onTap: () {
                              Navigator.of(context).pop();
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MyHelpViews()));
                            },
                            leading: Icon(Icons.help), //,
                          ),
                          ListTile(
                            title: Text("App Info"),
                            onTap: () {
                              Navigator.of(context).pop();
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MyInfoViews()));
                            },
                            leading: Icon(Icons.info), //,
                          ),
//                    ListTile(
//                      title: Text("Share"),
//                      onTap: () => Navigator.of(context).pop(),
//                      leading: Icon(
//                        Icons.share,
//                      ), //,
//                    ),
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        color: Colors.grey[400],
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Expanded(
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    padding: EdgeInsets.all(15.0),
                                    backgroundColor: Theme.of(context)
                                        .colorScheme
                                        .secondary),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  _neverSatisfied(model, context, "Logout",
                                      "Are you sure, you want to do this?");
                                },
                                child: Text(
                                  "LOGOUT",
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .apply(color: Colors.white),
                                ),
                              ),
                            ),
//                      SizedBox(
//                        width: 2.0,
//                      ),
//                      Expanded(
//                        child: RaisedButton(
//                          padding: EdgeInsets.all(15.0),
//                          onPressed: () => Navigator.of(context).pop(),
//                          child: Text(
//                            "HOME",
//                            style: Theme.of(context)
//                                .textTheme
//                                .title
//                                .apply(color: Colors.white),
//                          ),
//                          color: Theme.of(context).accentColor,
//                        ),
//                      )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
        );
      },
    );
  }

  _onLoggedOut(MainModel model, BuildContext context) async {
    // await model.logoutUser();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => MyLoginScreen()));
  }

  void _neverSatisfied(
      MainModel model, BuildContext context, String title, String desc) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(desc),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.pop(context, true);
              },
            ),
            TextButton(
              child: Text('Logout'),
              onPressed: () {
                _onLoggedOut(model, context);
              },
            ),
          ],
        );
      },
    );
  }

  void _onDetailsPressed(MainModel model, String userType) {
    Navigator.of(context).pop();

    print("On Details pressed");
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => userType == "STAFF"
                ? StaffProfileViews(
                    model: model,
                  )
                : MyProfileViews(
                    model: model,
                  )));
  }

  _onTapItem(String s) {
    Navigator.of(context).pop();
//    Navigator.push(context,
//        MaterialPageRoute(builder: (BuildContext context) => MyPushTrial()));
  }
}
