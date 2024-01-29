import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:greycell_app/src/commons/themes/textstyle.dart';
import 'package:greycell_app/src/models/payment/due_detail.dart';
import 'package:greycell_app/src/models/payment/payable_fee.dart';

class _PaymentBodyView extends StatefulWidget {
  final DueDetail? dueDetail;

  const _PaymentBodyView(this.dueDetail);

  @override
  _MyPaymentScreenState createState() => _MyPaymentScreenState();
}

class _MyPaymentScreenState extends State<_PaymentBodyView> {
  final double minValue = 8.0;
  DueDetail? _dueDetail;

  double _totalFeeAmount = 0.0;
  double _totalPayAbleAmount = 0.0;

  bool isScrollDown = false;

  ScrollController? _scrollController;
  double _height = 210.0;
  double _width = 0.0;

  void _onCreated() async {
    _dueDetail = widget.dueDetail;
    if (_dueDetail == null) {
      // Make Api Call and Get Data
    } else {
      // You have transaction data
      print("${_dueDetail!.getMerchantKey}");
      _dueDetail!.payableFeeDetails!.forEach((PayableFee fee) {
        _totalFeeAmount += fee.feeAmount!;
        _totalPayAbleAmount += fee.netPayAbleAmount!;
      });
      setState(() {});
    }
  }

  void _listenOnScroll() {
//    print(_scrollController.position.axisDirection.index);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _width = MediaQuery.of(context).size.width;
    print("Did Change Depen");
  }

  @override
  void dispose() {
    _scrollController!.dispose();

    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _onCreated();
    _scrollController = ScrollController(initialScrollOffset: 0.0);
//    _scrollController.addListener(_listenOnScroll);
  }

  Widget _buildPaymentButton() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 60.0,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [Colors.blue, Theme.of(context).primaryColor])),
      child: MaterialButton(
        padding: EdgeInsets.all(15.0),
        onPressed: () => null,
        child: Text(
          "Proceed to pay",
          style: CustomTextStyle(context)
              .subtitle1!
              .apply(color: Colors.white, fontWeightDelta: 1),
        ),
        textColor: Colors.white,
      ),
    );
  }

  Widget _buildTotalAmount() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text("Total fee amount"),
              Text(
                "₹${_totalFeeAmount}",
                style: CustomTextStyle(context)
                    .subtitle1!
                    .apply(fontWeightDelta: 1),
              )
            ],
          ),
          SizedBox(
            height: 12.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text("Net payable amount"),
              Text(
                "₹${_totalPayAbleAmount}",
                style: CustomTextStyle(context)
                    .subtitle1!
                    .apply(fontWeightDelta: 1),
              )
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: _dueDetail == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: NotificationListener<ScrollUpdateNotification>(
                      onNotification: (ScrollNotification scroll) {
                        if (_scrollController!.position.userScrollDirection ==
                            ScrollDirection.reverse) {
                          if (!isScrollDown)
                            setState(() {
                              isScrollDown = true;
                              _height = 210.0;
                              _width = MediaQuery.of(context).size.width;
                            });
                        } else {
                          if (_scrollController!.position.userScrollDirection ==
                              ScrollDirection.forward) {
                            if (isScrollDown)
                              setState(() {
                                isScrollDown = false;
                                _height = 0.0;
                                _width = 0.0;
                              });
                          }
                        }
                        return false;
                      },
                      child: ListView.builder(
                          controller: _scrollController,
                          itemCount: _dueDetail!.payableFeeDetails!.length,
                          itemBuilder: (BuildContext context, int index) {
                            final PayableFee _fee =
                                _dueDetail!.payableFeeDetails![index];
                            return PayableTile(
                              payableFee: _fee,
                              isEditable: _dueDetail!.getPolicyValue == "P",
                            );
                          }),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 500),
                      height: _height,
                      width: _width,
                      color: Colors.grey[200],
//                        padding: EdgeInsets.symmetric(horizontal: 12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          _buildTotalAmount(),
                          _buildPaymentButton(),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
    );
  }
}

class PayableTile extends StatelessWidget {
  final PayableFee? payableFee;
  final bool? isEditable;

  const PayableTile({Key? key, this.payableFee, this.isEditable});

  @override
  Widget build(BuildContext context) {
    final Color _amountColor = Colors.black87;

    return Container(
      width: MediaQuery.of(context).size.width,
      height: isEditable! ? 130.0 : 100.0,
      child: Card(
        margin: EdgeInsets.only(bottom: 8),
        elevation: 0.0,
        child: Container(
          padding: EdgeInsets.all(12.0),
          child: Row(
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
                                    .apply(
                                        color: _amountColor,
                                        fontWeightDelta: 1),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 15.0,
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
                                          fontWeightDelta: 1))
                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              isEditable!
                  ? Container(
                      margin: EdgeInsets.only(left: 12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          IconButton(
                              icon: Icon(Icons.edit),
                              iconSize: 18.0,
                              onPressed: () => null),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              textStyle: TextStyle(color: Colors.white),
                              elevation: 0.0,
                              backgroundColor: Colors.blueAccent,
                              padding: EdgeInsets.all(5),
                            ),
                            onPressed: () => null,
                            child: Text("PAY"),
                          )
                        ],
                      ),
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
