import 'package:flutter/material.dart';
import 'package:greycell_app/src/commons/themes/textstyle.dart';
import 'package:greycell_app/src/manager/main_model.dart';
import 'package:greycell_app/src/models/payment/payable_fee.dart';
import 'package:scoped_model/scoped_model.dart';

class PayableTile extends StatelessWidget {
  final PayableFee? payableFee;
  final bool? isEditable;
  final bool? isSelected;
  final Function? onChanged;
  final Function? onBottomAction;

  const PayableTile(
      {Key? key,
      this.onBottomAction,
      this.payableFee,
      this.isEditable,
      this.isSelected,
      this.onChanged});

  @override
  Widget build(BuildContext context) {
    final Color _amountColor = Colors.black87;

    return GestureDetector(
      onTap: onChanged as void Function()?,
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: Card(
          margin: EdgeInsets.only(bottom: 18, left: 8, right: 8),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
          color: isSelected! ? Colors.grey[100] : Colors.white,
          elevation: isSelected! ? 10.0 : 0.0,
          child: Container(
            padding: EdgeInsets.all(12.0),
            child: Column(
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: isEditable!
                      ? MainAxisAlignment.spaceBetween
                      : MainAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Text(
                            "${payableFee!.headName}",
                            style: CustomTextStyle(context)
                                .subtitle1!
                                .apply(fontWeightDelta: 1),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Flexible(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text("Fee Amount",
                                        style: CustomTextStyle(context)
                                            .caption!
                                            .apply(color: Colors.black54)),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      "₹${payableFee!.feeAmount}",
                                      style: CustomTextStyle(context)
                                          .subtitle1!
                                          .apply(color: _amountColor),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 15.0,
                                child: isEditable!
                                    ? ScopedModelDescendant(
                                        builder: (_, __, MainModel model) {
                                          return model.shouldAddPayment(
                                                  payableFee!.id)
                                              ? Icon(
                                                  Icons.done,
                                                  size: 32.0,
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                )
                                              : Container();
                                        },
                                      )
                                    : Container(),
                              ),
                              Flexible(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text("Payable Amount",
                                        style: CustomTextStyle(context)
                                            .caption!
                                            .apply(color: Colors.black54)),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text("₹${payableFee!.netPayAbleAmount}",
                                        style: CustomTextStyle(context)
                                            .subtitle1!
                                            .apply(
                                              color: _amountColor,
                                            ))
                                  ],
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
//                  isEditable
//                      ? Container(
//                          margin: EdgeInsets.only(left: 12.0),
//                          child: Column(
//                            crossAxisAlignment: CrossAxisAlignment.end,
//                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                            children: <Widget>[
//                              Checkbox(
//                                value: isSelected,
//                                activeColor: Colors.white,
//                                onChanged: onChanged,
//                                checkColor: Colors.black87,
//                                hoverColor: Theme.of(context).primaryColor,
//                              ),
////                          SizedBox(
////                            height: 25.0,
////                            width: 55.0,
////                            child: RaisedButton(
////                              padding: EdgeInsets.all(5),
////                              onPressed: () => null,
////                              child: Text("PAY"),
////                              textColor: Colors.white,
////                              elevation: 0.0,
////                              color: Colors.blueAccent,
////                            ),
////                          )
//                            ],
//                          ),
//                        )
//                      : Container(),
                  ],
                ),
                isEditable! && isSelected!
                    ? Padding(
                        padding: EdgeInsets.symmetric(vertical: 2.0),
                        child: Divider(
                          thickness: 1.5,
                        ),
                      )
                    : Container(),
                isEditable! && isSelected!
                    ? ScopedModelDescendant(builder: (_, __, MainModel model) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            _buildTileAction(
                              iconData: Icons.add,
                              iconColor: Colors.green,
                              title: "Add to pay",
                              isActive: model.shouldAddPayment(payableFee!.id),
                              tap: model.shouldAddPayment(payableFee!.id)
                                  ? null
                                  : () => onBottomAction!('ADD'),
                            ),
                            _buildTileAction(
                              iconData: Icons.edit,
                              title: "Edit",
                              iconColor: Theme.of(context).primaryColor,
                              isActive: false,
                              tap: () => onBottomAction!('EDIT'),
                            ),
                            _buildTileAction(
                              iconData: Icons.delete,
                              title: "Remove",
                              iconColor: Colors.red,
                              isActive: !model.shouldAddPayment(payableFee!.id),
                              tap: !model.shouldAddPayment(payableFee!.id)
                                  ? null
                                  : () => onBottomAction!('DELETE'),
                            ),
                          ],
                        );
                      })
                    : Container(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTileAction(
      {IconData? iconData,
      VoidCallback? tap,
      String? title,
      required bool isActive,
      Color? iconColor}) {
    final Color activeColor = isActive ? Colors.grey : Colors.black87;

    return Expanded(
      child: InkWell(
        onTap: tap,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 6.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(iconData, color: !isActive ? iconColor : Colors.grey),
              SizedBox(
                height: 5,
              ),
              Text(
                "${title}",
                style: TextStyle(color: activeColor),
              )
            ],
          ),
        ),
      ),
    );
  }
}
