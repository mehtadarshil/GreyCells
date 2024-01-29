import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:greycell_app/src/commons/widgets/custom_card_list.dart';
import 'package:greycell_app/src/manager/main_model.dart';
import 'package:greycell_app/src/models/student/student_model.dart';
import 'package:greycell_app/src/views/observer/future_observer.dart';
import 'package:greycell_app/src/views/userViews/studentViews/guardian_details.dart';
import 'package:greycell_app/src/views/userViews/studentViews/personal_details.dart';

class MyProfileViews extends StatefulWidget {
  final MainModel model;

  MyProfileViews({required this.model});

  @override
  _MyProfileViewsState createState() => _MyProfileViewsState();
}

class _MyProfileViewsState extends State<MyProfileViews> {
  Student? _student;
  Future<Student?>? _studentFuture;

  double minValue = 8.0;

  void _onCreate() async {
    _studentFuture = widget.model.getStudentProfile();
    _student = await _studentFuture;
  }

  @override
  void initState() {
    super.initState();
    _onCreate();
  }

  Widget _buildCacheImage() {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [Theme.of(context).primaryColorDark, Colors.black87])),
      child: Opacity(
        opacity: 0.1,
        child: CachedNetworkImage(
          imageUrl: _student!.getWebPhotoPath!,
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
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return SliverAppBar(
      expandedHeight: MediaQuery.of(context).size.height / 2.7,
      floating: false,
      pinned: true,
      elevation: 0.0,
      title: Text(""),
      flexibleSpace: FlexibleSpaceBar(
          title: Text(
            "PROFILE",
            style: TextStyle(color: Colors.grey[100]),
          ),
          centerTitle: true,
          collapseMode: CollapseMode.parallax,
          background: Hero(
            tag: "profileHero",
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                _buildCacheImage(),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    _student!.getWebPhotoPath == null
                        ? Container()
                        : CircleAvatar(
                            radius: 65,
                            backgroundImage:
                                NetworkImage(_student!.getWebPhotoPath!),
                            child: Container(),
                          ),
                    SizedBox(
                      height: 12.0,
                    ),
                    Text(
                      "${_student!.getFirstName! + (_student!.getMiddleName!.trim().isNotEmpty ? (' ' + _student!.getMiddleName!) : "") + (_student!.getLastName!.trim().isNotEmpty ? (' ' + _student!.getLastName!) : "")}",
                      style: TextStyle(
                          fontSize: 17.0,
                          color: Colors.white,
                          fontWeight: FontWeight.w700),
                    )
                  ],
                ),
//              Container(
//                height: 120.0,
//                width: 120.0,
//                decoration: BoxDecoration(
//                    borderRadius:
//                    BorderRadius.all(Radius.circular(minValue * 5)),
//                    image: DecorationImage(
//                        image: NetworkImage(_student.getWebPhotoPath),
//                        fit: BoxFit.cover)),
//              )
//
              ],
            ),
          )),
    );
  }

  Widget _buildBody() {
    return Container(
      child: ListView(
        children: <Widget>[
          MyCustomCardTile(
            headerName: 'Current academic class',
            textValue: _student!.getCurrentAcademicSession,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: minValue * 2),
            child: MyPersonalDetails(
              student: _student,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: minValue * 2),
            child: MyGuardianDetails(
              student: _student,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          top: false,
          bottom: false,
          child: FutureObserver<Student?>(
            future: _studentFuture,
            onSuccess: (context, Student student) {
              return NestedScrollView(
                headerSliverBuilder:
                    (BuildContext context, bool innerBoxIsScrolled) {
                  return <Widget>[_buildHeader()];
                },
                body: _buildBody(),
              );
            },
          )),
    );
  }
}
