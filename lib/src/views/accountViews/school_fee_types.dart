import 'package:flutter/material.dart';
import 'package:greycell_app/src/config/data.dart';

class MyPaymentFeeType extends StatelessWidget {
  final List<List<dynamic>>? feeTypes;

  MyPaymentFeeType({required this.feeTypes});

  double minValue = 8.0;

  String? getMont(int month) => CustomDateTime.monthList[month - 1]['short'];

  Widget _buildCard(BuildContext context, List data) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(minValue)),
      child: Card(
        elevation: 0.0,
        color: Colors.white,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(minValue * 2))),
        margin: EdgeInsets.only(right: minValue * 2),
        child: Container(
          width: MediaQuery.of(context).size.width / 2.3,
          padding: EdgeInsets.only(left: minValue),
          decoration: BoxDecoration(
              border: Border(
                  left:
                      BorderSide(color: Colors.orangeAccent[100]!, width: 5))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: minValue,
              ),
              Text(
                "${data[1]}",
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall!
                    .apply(color: Colors.black, fontWeightDelta: 1),
              ),
              Text(
                "Start term: ${getMont(int.parse(data[3]))! + '-' + data[6]}",
                style: Theme.of(context)
                    .textTheme
                    .titleSmall!
                    .apply(color: Colors.grey[700]),
              ),
              Text(
                "End term: ${getMont(int.parse(data[4]))! + '-' + data[7]}",
                style: Theme.of(context).textTheme.titleSmall!.apply(
                      color: Colors.grey[700],
                    ),
              ),
              SizedBox(
                height: minValue * 2,
              ),
              Text(
                "Status - ${data[5]}",
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall!
                    .apply(color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return feeTypes == null || feeTypes!.length == 0
        ? Container()
        : Card(
            elevation: 0.0,
            color: Colors.transparent,
            clipBehavior: Clip.antiAlias,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(minValue * 2)),
            ),
            child: Container(
              height: feeTypes == null || feeTypes!.length == 0 ? 100.0 : 230.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 20.0,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: minValue),
                    child: Text(
                      "Payment Fee Terms",
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium!
                          .apply(fontWeightDelta: 1),
                    ),
                  ),
                  SizedBox(
                    height: minValue * 2,
                  ),
                  feeTypes == null || feeTypes!.length == 0
                      ? Center(child: Text("Not available"))
                      : Expanded(
                          child: ListView.builder(
                              padding: EdgeInsets.symmetric(
                                horizontal: minValue,
                              ),
                              reverse: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: feeTypes!.length,
                              itemBuilder: (context, index) {
                                List data = feeTypes![index];
                                return _buildCard(context, data);
                              }),
                        )
                ],
              ),
            ),
          );
  }
}
