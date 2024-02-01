import 'package:flutter/material.dart';
import 'package:greycell_app/src/commons/actions/dialog_handler.dart';
import 'package:greycell_app/src/commons/themes/textstyle.dart';
import 'package:greycell_app/src/commons/widgets/error_data.dart';
import 'package:greycell_app/src/manager/main_model.dart';
import 'package:greycell_app/src/models/payment/due_detail.dart';
import 'package:greycell_app/src/models/payment/payable_fee.dart';
import 'package:greycell_app/src/models/response/response.dart';
import 'package:greycell_app/src/models/response/success.dart';
import 'package:greycell_app/src/views/accountViews/account_header.dart';
import 'package:greycell_app/src/views/accountViews/pay_option.dart';
import 'package:greycell_app/src/views/paymentViews/payable_tile.dart';
import 'package:greycell_app/src/views/paymentViews/payment_confirmation_screen.dart';
import 'package:greycell_app/src/views/paymentViews/payment_edit_field_view.dart';
import 'package:scoped_model/scoped_model.dart';

class PaymentBodyView extends StatefulWidget {
  final DueDetail? dueDetail;
  final MainModel? model;

  //

  const PaymentBodyView({this.dueDetail, this.model});

  @override
  _MyPaymentScreenState createState() => _MyPaymentScreenState();
}

class _MyPaymentScreenState extends State<PaymentBodyView> {
  final TextEditingController _paymentEditController = TextEditingController();
  final TextEditingController _paymentSearchController =
      TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final double minValue = 8.0;
  DueDetail? _dueDetail;

  double _totalFeeAmount = 0.0;

  /// Is user is Scrolling
  bool isScrollDown = false;

  ScrollController? _scrollController;

  // Current Index
  int _currentIndex = -999999;

  void setUp() {
    if (_dueDetail!.getPayAmtFrom == 'FA') {
      // There will be one custom payable fee in the list: for more info check Account Service for FA
      widget.model!.addPayableFee(_dueDetail!.payableFeeDetails!.first);
    }
  }

  void _onCreated() async {
    _dueDetail = widget.dueDetail;
    if (_dueDetail == null) {
      // Make Api Call and Get Data
      final ResponseMania? _result = await widget.model!.getAccountDueDetail();
      if (_result is Success) {
        _dueDetail = _result.success;
        setUp();
        _calculateAmount();
      }
    } else {
      // You have transaction data
      setUp();
      _calculateAmount();
    }
  }

  void _calculateAmount() {
    if (_dueDetail != null && _dueDetail!.payableFeeDetails != null) {
      _dueDetail!.payableFeeDetails!.forEach((PayableFee fee) {
        _totalFeeAmount += fee.feeAmount!;
      });
    }
    setState(() {});
  }

  void _onPayableTap(int index) {
    if (!mounted) return;
    setState(() {
      if (_currentIndex == index) {
        _currentIndex = -99999;
      } else {
        _currentIndex = index;
      }
    });
  }

  void _onAddPayableFee(int index, PayableFee selectedFee) {
    widget.model!.addPayableFee(selectedFee);
    _showSnackBar("Added to the payment");
    setState(() {
      _currentIndex = -99999;
    });
  }

  void _onEditPayableFee(int index, PayableFee selectedFee) async {
    _paymentEditController.text = selectedFee.feeAmount.toString();
    DialogHandler.onCustomAlertDialog(
        title: "Edit amount",
        context: context,
        content: PaymentEditTextFiled(
          context: context,
          key: _formKey,
          fee: selectedFee,
          paymentEditController: _paymentEditController,
        ).build(),
        onSubmit: () {
          if (_formKey.currentState!.validate()) {
            selectedFee.netPayAbleAmount =
                double.parse(_paymentEditController.text);
            widget.model!.editPayableAmount(index, selectedFee);
            Navigator.of(context).pop();
            _showSnackBar("Updated and added to the payment");
          }
        });
  }

  void _onRemovePayableFee(int index, PayableFee selectedFee) {
    print("remove Called");
    widget.model!.removePayableFee(selectedFee);
    _showSnackBar("Successfully removed");
    setState(() {
      _currentIndex = -99999;
    });
  }

  void _onProceedToPay() {
    if (widget.model!.selectedPayableFees.isNotEmpty) {
      Navigator.of(context)
          .push(MaterialPageRoute(
              builder: (_) => PaymentConfirmationScreen(
                  model: widget.model,
                  dueDetail: _dueDetail,
                  totalFeeAmount: _totalFeeAmount,
                  totalPayAbleAmount: widget.model!.totalPayableAmount,
                  payableFees: widget.model!.selectedPayableFees

//              payableFees: <PayableFee>[_dueDetail.payableFeeDetails[0]],
                  )))
          .then((value) {});
    }
  }

  void _reset() {
    widget.model!.clearSelectedPayable();
  }

  @override
  void dispose() {
    _scrollController!.dispose();
    _reset();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _onCreated();
    _scrollController = ScrollController(initialScrollOffset: 0.0);
  }

  bool get isNotDueFound =>
      _dueDetail!.payableFeeDetails == null ||
      _dueDetail!.payableFeeDetails!.length == 0;

  void onAllSelectChanged(bool value) {}

  void _showSnackBar(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        "$msg",
        style: CustomTextStyle(context).caption!.apply(color: Colors.white),
      ),
      backgroundColor: Colors.green[400],
    ));
  }

  Widget _buildPaymentButton() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 50.0,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [Colors.blue, Theme.of(context).primaryColor])),
      child: MaterialButton(
        padding: EdgeInsets.all(15.0),
        onPressed: _onProceedToPay,
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
              ScopedModelDescendant(builder: (_, __, MainModel model) {
                return Text(
                  "₹${model.totalPayableAmount}",
                  style: CustomTextStyle(context)
                      .subtitle1!
                      .apply(fontWeightDelta: 1),
                );
              })
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFinalAmount() {
    return ScopedModelDescendant(builder: (_, __, MainModel model) {
      return Container(
        padding: EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              "Final Payable Amount",
              style: CustomTextStyle(context).subtitle2,
            ),
            Flexible(
              child: Text(
                "₹${model.totalPayableAmount}",
                style: CustomTextStyle(context).headline6,
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget _buildFAbody() {
    final PayableFee _fee = _dueDetail!.payableFeeDetails!.first;

    return Container(
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            PayableTile(
              isEditable: false,
              isSelected: false,
              payableFee: _fee,
            ),
            _dueDetail!.getPolicyValue != "P"
                ? Container()
                : Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: Text(
                          "Partially Pay",
                          style: CustomTextStyle(context).subtitle2,
                        ),
                      ),
                      MaterialButton(
                        onPressed: () => _onEditPayableFee(0, _fee),
                        child: Text("Change"),
                        padding: EdgeInsets.symmetric(vertical: 15.0),
                      )
                    ],
                  ),
            Divider(),
            _buildFinalAmount(),
            SizedBox(
              height: 20.0,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: _buildPaymentButton(),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[50],
      child: _dueDetail == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: <Widget>[
                Expanded(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
//                          PaymentSearchFilter(),
                          MyAccountInfoHeader(
                            dueDetail: _dueDetail,
                          ),
                          MyOnlinePayOption(
                            dueDetail: _dueDetail,
                          ),
                          isNotDueFound
                              ? MyErrorData(
                                  errorMsg: "No dues found",
                                  subtitle: "No payable fees available",
                                )
                              : _dueDetail!.getPayAmtFrom == 'FA'
                                  ? _buildFAbody()
                                  : ListView.builder(
                                      controller: _scrollController,
                                      shrinkWrap: true,
                                      physics: ClampingScrollPhysics(),
                                      itemCount:
                                          _dueDetail!.payableFeeDetails!.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        final PayableFee _fee = _dueDetail!
                                            .payableFeeDetails![index];
                                        return PayableTile(
                                          payableFee: _fee,
                                          isEditable:
                                              _dueDetail!.getPolicyValue == "P",
                                          onChanged: () {
                                            _onPayableTap(index);
                                          },
                                          isSelected: _currentIndex == index,
                                          onBottomAction: (String action) {
                                            if (action == 'EDIT')
                                              _onEditPayableFee(index, _fee);
                                            else if (action == 'DELETE')
                                              _onRemovePayableFee(index, _fee);
                                            else
                                              _onAddPayableFee(index, _fee);
                                          },
                                        );
                                      }),
                        ],
                      ),
                    ),
                  ),
                ),
                isNotDueFound || _dueDetail!.getPayAmtFrom == 'FA'
                    ? Container()
                    : Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.blue[50],
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(12),
                                  topRight: Radius.circular(12.0))),
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
    );
  }
}
