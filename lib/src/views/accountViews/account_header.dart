import 'package:flutter/material.dart';
import 'package:greycell_app/src/commons/widgets/user_info.dart';
import 'package:greycell_app/src/models/payment/due_detail.dart';

class MyAccountInfoHeader extends StatelessWidget {
  final DueDetail? dueDetail;

  MyAccountInfoHeader({required this.dueDetail});

  double minValue = 8.0;

  Widget _buildRow(BuildContext context, {String? name, String? data}) {
    final hS = Theme.of(context).textTheme.bodyMedium;
    final resultS =
        Theme.of(context).textTheme.titleSmall!.apply(fontWeightDelta: 1);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: minValue * 3, vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Text(
            "$name: ",
            style: hS,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            "${data ?? ''}",
            overflow: TextOverflow.ellipsis,
            style: resultS,
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          MyUserInfo(),
          SizedBox(
            height: minValue,
          ),
//           Row(
//             children: <Widget>[
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: <Widget>[
//                   _buildRow(context,
//                       data: dueDetail!.getStdnId, name: "Student Id"),
//                   _buildRow(context,
//                       data: dueDetail!.getPayAmtFrom, name: "Payment From"),
//                   _buildRow(context,
//                       data: dueDetail!.getAcctLvlRcptReqd,
//                       name: "Account Receipt"),
//                 ],
//               ),
// //              Expanded(
// //                child: Container(),
// //              ),
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: <Widget>[
//                   _buildRow(context,
//                       data: dueDetail!.getFinYear, name: "Finacial Year"),
//                   _buildRow(context,
//                       data: dueDetail!.getPolicyValue, name: "Policy Type"),
//                   _buildRow(context,
//                       data: dueDetail!.getAllowFeeSchSel, name: "Allow Fee"),
//                 ],
//               )
//             ],
//           )
        ],
      ),
    );
  }
}
