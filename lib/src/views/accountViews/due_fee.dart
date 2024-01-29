import 'package:flutter/material.dart';
import 'package:greycell_app/src/commons/themes/textstyle.dart';
import 'package:greycell_app/src/config/data.dart';

class MyPaymentDue extends StatelessWidget {
  final List<List<dynamic>>? dueList;

  MyPaymentDue({required this.dueList});

  double minValue = 8.0;

  String? getMont(int month) => CustomDateTime.monthList[month - 1]['short'];

  Widget _buildRow(BuildContext context, {String? name, String? data}) {
    final hS = Theme.of(context).textTheme.bodySmall!.apply(fontWeightDelta: 1);
    final resultS =
        CustomTextStyle(context).subtitle2!.apply(fontWeightDelta: 1);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: minValue * 2, vertical: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Text(
            "$name: ",
            style: hS,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            "$data",
            overflow: TextOverflow.ellipsis,
            style: resultS,
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    print("Due List: $dueList");
    return dueList == null || dueList!.length == 0
        ? Container()
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 20.0,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: minValue * 1.5, vertical: minValue * 2),
                child: Text(
                  "Payment Due",
                  style: CustomTextStyle(context)
                      .subtitle1!
                      .apply(fontWeightDelta: 1),
                ),
              ),
              dueList == null || dueList!.length == 0
                  ? Center(child: Text("Not available"))
                  : Container(
                      height: 210.0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                            child: ListView.builder(
//                  padding: EdgeInsets.symmetric(
//                    horizontal: minValue,
//                  ),
//                  reverse: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: dueList!.length,
                                itemBuilder: (context, index) {
                                  List data = dueList![index];
                                  final feeScheme = data[2];
                                  final feeName = data[3];
                                  final feeAmount = data[4];
                                  final discountAmount = data[5];
                                  final dueOn = data[6];
                                  final payableAmnt = data[7];
                                  final paidAmount = data[9];
                                  final feeDiscount = data[12];
                                  final lateFine = data[13];
                                  final finYear = data[15];
                                  final schemeChange = data[16];
                                  return Card(
                                    margin: EdgeInsets.symmetric(
                                        horizontal: minValue),
                                    elevation: 0.0,
                                    clipBehavior: Clip.antiAlias,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(minValue * 2)),
                                    ),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Flexible(
                                            child: Container(
                                              child: _buildRow(context,
                                                  name: "SCHEME NAME",
                                                  data: feeScheme),
                                            ),
                                          ),
                                          _buildRow(context,
                                              name: "FEE NAME", data: feeName),
                                          Container(
                                            color:
                                                Theme.of(context).primaryColor,
                                            height: 1.5,
                                            width: 50.0,
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 15.0,
                                                vertical: 5.0),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: <Widget>[
                                                  _buildRow(context,
                                                      name: "FEE AMOUNT",
                                                      data: feeAmount),
                                                  _buildRow(context,
                                                      name: "DISCOUNT AMOUNT",
                                                      data: discountAmount),
                                                  _buildRow(context,
                                                      name: "DUE ON",
                                                      data: dueOn),
                                                  _buildRow(context,
                                                      name: "PAYABLE AMOUNT",
                                                      data: payableAmnt),
                                                ],
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: <Widget>[
                                                  _buildRow(context,
                                                      name: "PAID AMOUNT",
                                                      data: paidAmount),
                                                  _buildRow(context,
                                                      name: "DISCOUNT FEE",
                                                      data: feeDiscount),
                                                  _buildRow(context,
                                                      name: "LATE FINE",
                                                      data: lateFine),
                                                  _buildRow(context,
                                                      name: "FINACIAL YEAR",
                                                      data: finYear),
                                                  _buildRow(context,
                                                      name: "SCHEME CHANGE",
                                                      data: schemeChange),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }),
                          )
                        ],
                      ),
                    ),
            ],
          );
  }
}
