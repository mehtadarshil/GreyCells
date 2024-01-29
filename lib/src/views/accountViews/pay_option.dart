import 'package:flutter/material.dart';
import 'package:greycell_app/src/manager/main_model.dart';
import 'package:greycell_app/src/models/payment/due_detail.dart';
import 'package:scoped_model/scoped_model.dart';

class MyOnlinePayOption extends StatelessWidget {
  final DueDetail? dueDetail;
  final Function? onSelected;

  MyOnlinePayOption({required this.dueDetail, this.onSelected});

  double minValue = 8.0;

  Widget _buildCard(BuildContext context, index, List gateway) {
    String gName = gateway[1];
    String pCode = gateway[2];

    return Card(
      elevation: 5,
      color: Colors.lightGreen,
      margin: EdgeInsets.only(right: minValue),
      child: ScopedModelDescendant(
        builder: (context, _, MainModel model) {
          return InkWell(
            onTap: onSelected == null
                ? null
                : () {
                    model.selectedGateway = gateway;
                    onSelected!(gateway);
                  },
            child: Container(
              width: 110.0,
              child: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Flexible(
                        child: Text(
                          "$gName",
                          style: TextStyle(fontSize: 16.0, color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(
                        height: minValue,
                      ),
                      Text(
                        "$pCode",
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .apply(color: Colors.white70),
                      ),
                    ],
                  ),
                  model.selectedGateway != null &&
                          model.selectedGateway![1] == gateway[1]
                      ? Align(
                          alignment: Alignment.bottomRight,
                          child: CircleAvatar(
                            child: Icon(Icons.done),
                          ),
                        )
                      : Container()
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.5,
      clipBehavior: Clip.antiAlias,
      margin:
          EdgeInsets.symmetric(horizontal: minValue, vertical: minValue * 2),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(minValue * 2)),
      ),
      child: Container(
        padding:
            EdgeInsets.symmetric(horizontal: minValue, vertical: minValue * 2),
        height: 170.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Pay Options Available",
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall!
                  .apply(fontWeightDelta: 1),
            ),
            SizedBox(
              height: minValue * 2,
            ),
            Expanded(
              child: dueDetail!.getOnlinePayOptionVector == null ||
                      dueDetail!.getOnlinePayOptionVector!.length == 0
                  ? Center(child: Text("No Gateway found"))
                  : ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: dueDetail!.getOnlinePayOptionVector!.length,
                      itemBuilder: (context, index) {
                        return _buildCard(context, index,
                            dueDetail!.getOnlinePayOptionVector![index]);
                      }),
            )
//            Row(
//              children: <Widget>[
//                _buildCard(context, Colors.indigoAccent),
//                _buildCard(context, Colors.pink),
//              ],
//            ),
          ],
        ),
      ),
    );
  }
}
