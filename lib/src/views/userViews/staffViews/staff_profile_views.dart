import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:greycell_app/src/manager/main_model.dart';
import 'package:greycell_app/src/models/user/staff_model.dart';
import 'package:greycell_app/src/views/observer/future_observer.dart';
import 'package:greycell_app/src/views/userViews/staffViews/staff_persona_details.dart';

class StaffProfileViews extends StatefulWidget {
  final MainModel model;

  StaffProfileViews({required this.model});

  @override
  _StaffProfileViewsState createState() => _StaffProfileViewsState();
}

class _StaffProfileViewsState extends State<StaffProfileViews> {
  Staff? _Staff;
  Future<Staff?>? _staffFuture;

  double minValue = 8.0;

  void _onCreate() async {
    _staffFuture = widget.model.getStaffProfile();
    _Staff = await _staffFuture;
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
          imageUrl: _Staff!.getWebPhotoPath!,
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
            style: TextStyle(color: Colors.grey[100], fontSize: 16),
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
                    _Staff!.getWebPhotoPath == null
                        ? Container()
                        : CircleAvatar(
                            radius: 65,
                            child: CachedNetworkImage(
                              imageUrl: _Staff!.getWebPhotoPath!,
                              imageBuilder: (context, imageProvider) =>
                                  Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: imageProvider,
                                      fit: BoxFit.cover,
                                      colorFilter: ColorFilter.mode(
                                          Theme.of(context).primaryColor,
                                          BlendMode.dstIn)),
                                ),
                              ),
                              placeholder: (context, url) => Center(
                                child: CircularProgressIndicator(),
                              ),
                              errorWidget: (context, url, error) => Icon(
                                Icons.person,
                                size: 65.0,
                                color: Colors.white60,
                              ),
                            ),
                          ),
                    SizedBox(
                      height: 12.0,
                    ),
                    Text(
                      "${_Staff!.getStaffName}",
                      style: TextStyle(
                          fontSize: 17.0,
                          color: Colors.white,
                          fontWeight: FontWeight.w700),
                    ),
                    SizedBox(
                      height: 12.0,
                    ),
                    Text(
                      "${_Staff!.getDesignation}",
                      style: TextStyle(
                          fontSize: 14.0,
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
//                        image: NetworkImage(_Staff.getWebPhotoPath),
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
        padding: EdgeInsets.only(bottom: minValue * 4),
        children: <Widget>[
//          MyCustomCardTile(
//            headerName: 'Designation',
//            textValue: _Staff.getDesignation,
//          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: minValue),
            child: StaffPersonalDetails(
              staff: _Staff,
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
          child: FutureObserver<Staff?>(
            future: _staffFuture,
            onSuccess: (context, Staff Staff) {
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
