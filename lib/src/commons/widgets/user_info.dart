import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:greycell_app/src/config/core_config.dart';
import 'package:greycell_app/src/manager/main_model.dart';
import 'package:scoped_model/scoped_model.dart';

class MyUserInfo extends StatelessWidget {
  double minValue = 8.0;

  MyUserInfo();

  Widget _buildNetImage(String path) {
    return CircleAvatar(
      child: CachedNetworkImage(
        imageUrl: path,
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
          size: 25.0,
          color: Colors.white70,
        ),
      ),
    );
  }

  Widget _buildCustomListTile(
      BuildContext context, String title, String subtitle) {
    final titleStyle =
        Theme.of(context).textTheme.headlineSmall!.apply(fontWeightDelta: 1);
    final subhead = Theme.of(context).textTheme.titleSmall!;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          subtitle,
          style: subhead.apply(color: Colors.grey[600]),
        ),
        SizedBox(
          width: 3.0,
        ),
        Text(
          "$title",
          style: titleStyle,
        ),
      ],
    );
  }

  Widget _buildContentHeader(BuildContext context, MainModel model) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "${model.student!.fullName}",
            style: Theme.of(context).textTheme.titleMedium,
          ),
          Text(
            "${model.school?.schoolName}",
            style: Theme.of(context).textTheme.titleSmall,
          ),
          Text(
            "${model.student!.fullEmail}",
            style: Theme.of(context).textTheme.headlineSmall,
          ),
//          _buildCustomListTile(
//              context, model.student.getRegistrationNo, "Admission No:"),
//          _buildCustomListTile(context, model.student.getCurrentAcademicSession,
//              "Current Session:"),
        ],
      ),
    );
  }

  Widget _buildTile(BuildContext context, MainModel model) {
//    final trContentS = Theme
    return ListTile(
      leading: _buildNetImage(model.student!.getWebPhotoPath!),
      title: Text(
        "${model.student!.fullName}",
        style:
            Theme.of(context).textTheme.titleSmall!.apply(fontWeightDelta: 1),
      ),
      subtitle: Text(
        "${model.student!.fullEmail}",
        style: Theme.of(context).textTheme.bodyLarge,
      ),
      trailing: Container(
        width: 60,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text(
              "${model.user!.getUserId}",
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall!
                  .apply(
                    fontWeightDelta: 1,
                  )
                  .copyWith(fontSize: 13),
            ),
            Text(
              "Roll No",
              style: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .apply(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  Widget _staffBuildTile(BuildContext context, MainModel model) {
//    final trContentS = Theme
    return ListTile(
      leading: CircleAvatar(
        child: _buildNetImage(model.staff.getWebPhotoPath!),
      ),
      title: Text(
        "${model.staff.getStaffName}",
        style:
            Theme.of(context).textTheme.titleSmall!.apply(fontWeightDelta: 1),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "${model.staff.getEmail}",
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          Text(
            "${model.staff.getDesignation} (${model.staff.getDesignationType})",
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ],
      ),
      isThreeLine: true,
      trailing: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text(
              "${model.user!.getUserId}",
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall!
                  .apply(fontWeightDelta: 1),
            ),
            Text(
              "Staff ID",
              style: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .apply(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLayout(BuildContext context, MainModel model) {
    return Container(
      height: 170.0,
      padding: EdgeInsets.only(
          top: minValue * 2, left: minValue * 2, bottom: minValue * 2),
      child: Stack(
//        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          _buildContentHeader(context, model),
          Align(
              alignment: Alignment.bottomCenter,
              child: _buildNetImage(model.student!.getWebPhotoPath!)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: ScopedModelDescendant(
        builder: (context, _, MainModel model) {
          if (model.user == null) {
            return Container(
              child: Text("No User Information"),
            );
          }
          if (model.user!.getUserType == Core.STUDENT_USER) {
            return model.student == null
                ? Container(
                    child: Text("No User Information"),
                  )
                : _buildTile(context, model);
          }
          return _staffBuildTile(context, model);
        },
      ),
    );
  }
}
