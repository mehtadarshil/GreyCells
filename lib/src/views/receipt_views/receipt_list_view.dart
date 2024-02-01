import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:greycell_app/src/commons/themes/textstyle.dart';
import 'package:greycell_app/src/config/apiauth_config.dart';
import 'package:greycell_app/src/manager/main_model.dart';
import 'package:greycell_app/src/models/payment/receipt_list_model.dart';
import 'package:greycell_app/src/services/tokenService/token_service.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher_string.dart';

class ReceiptListView extends StatefulWidget {
  const ReceiptListView({Key? key, required this.mainModel}) : super(key: key);

  final MainModel mainModel;

  @override
  State<ReceiptListView> createState() => _ReceiptListViewState();
}

class _ReceiptListViewState extends State<ReceiptListView> {
  ReceiptListModel? receiptList;
  DateTime fromDate = DateTime.now().subtract(Duration(days: 7));
  DateTime toDate = DateTime.now();
  TextEditingController fromDateController = TextEditingController();
  TextEditingController toDateController = TextEditingController();
  bool loading = false;

  @override
  void initState() {
    fromDateController.text = DateFormat("dd-MMM-yyyy").format(fromDate);
    toDateController.text = DateFormat("dd-MMM-yyyy").format(toDate);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getReceiptListData();
    });
    super.initState();
  }

  void getReceiptListData() async {
    setState(() {
      loading = true;
    });
    final DataFilter dataFilter = DataFilter();
    var tokenResponse = await dataFilter.getToken(
        serverUrl: RestAPIs.GREYCELL_TOKEN_URL,
        apiCode: ApiAuth.STDNPAYMENT_DETAILS_LIST);
    if (tokenResponse != null) {
      var data = await widget.mainModel.getReceiptList(
          tokens: tokenResponse, fromDate: fromDate, toDate: toDate);
      log((data?.toJson()).toString());
      receiptList = data;
    }
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Receipt List"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    readOnly: true,
                    onTap: () async {
                      var date = await showDatePicker(
                          context: context,
                          firstDate: DateTime(100),
                          lastDate: DateTime.now(),
                          initialDate: fromDate);
                      if (date != null && date.isBefore(toDate)) {
                        fromDate = date;
                        fromDateController.text =
                            DateFormat("dd-MMM-yyyy").format(fromDate);
                        getReceiptListData();
                      }
                    },
                    controller: fromDateController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(width: 2.0)),
                        labelText: 'From Date',
                        errorStyle: CustomTextStyle.errorTextStyle,
                        labelStyle: CustomTextStyle.loginLabelStyle
                            .copyWith(fontSize: 14)),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: TextFormField(
                    readOnly: true,
                    onTap: () async {
                      var date = await showDatePicker(
                          context: context,
                          firstDate: DateTime(100),
                          lastDate: DateTime.now(),
                          initialDate: toDate);
                      if (date != null && date.isAfter(fromDate)) {
                        toDate = date;
                        toDateController.text =
                            DateFormat("dd-MMM-yyyy").format(toDate);
                        getReceiptListData();
                      }
                    },
                    controller: toDateController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(width: 2.0)),
                        labelText: 'To Date',
                        errorStyle: CustomTextStyle.errorTextStyle,
                        labelStyle: CustomTextStyle.loginLabelStyle
                            .copyWith(fontSize: 14)),
                  ),
                )
              ],
            ),
          ),
          Expanded(
              child: loading
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : receiptList != null && receiptList!.getRctVector!.isNotEmpty
                      ? ListView.separated(
                          padding: EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10),
                          itemCount: receiptList!.getRctVector!.length,
                          itemBuilder: (context, index) {
                            var data = receiptList!.getRctVector![index];
                            return ReceiptCard(
                              data: data,
                              mainModel: widget.mainModel,
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return SizedBox(
                              height: 10,
                            );
                          },
                        )
                      : Center(
                          child: Text(
                            "No Data Found",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w600),
                          ),
                        ))
        ],
      ),
    );
  }
}

class ReceiptCard extends StatefulWidget {
  const ReceiptCard({
    Key? key,
    required this.data,
    required this.mainModel,
  }) : super(key: key);

  final List<String> data;
  final MainModel mainModel;

  @override
  State<ReceiptCard> createState() => _ReceiptCardState();
}

class _ReceiptCardState extends State<ReceiptCard> {
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.05),
                spreadRadius: 1,
                blurRadius: 5)
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  widget.data.elementAt(3),
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 2, horizontal: 5),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Text(
                  widget.data.elementAt(2),
                  style: TextStyle(
                      fontSize: 11,
                      color: Colors.white,
                      fontWeight: FontWeight.w400),
                ),
              )
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            children: [
              Expanded(
                child: Text(
                  widget.data.elementAt(0),
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300),
                ),
              ),
              Text(widget.data.elementAt(1))
            ],
          ),
          Row(
            children: [
              Expanded(
                  child: ElevatedButton(
                onPressed: () async {
                  setState(() {
                    loading = true;
                  });
                  final DataFilter dataFilter = DataFilter();
                  var tokenResponse = await dataFilter.getToken(
                      serverUrl: RestAPIs.GREYCELL_TOKEN_URL,
                      apiCode: ApiAuth.STDNFEE_RECEIPT_REPORT);
                  var student = await widget.mainModel.getStudentProfile();
                  if (tokenResponse != null && student?.getStudentId != null) {
                    var data = await widget.mainModel.getReceiptToView(
                        tokens: tokenResponse,
                        id: widget.data.elementAt(4),
                        studendId: student?.getStudentId);
                    log((data?.toJson()).toString());
                    if (data != null && data.getReportFilePath != null) {
                      launchUrlString(data.getReportFilePath!,
                          mode: LaunchMode.externalApplication);
                    }
                  }
                  setState(() {
                    loading = false;
                  });
                },
                child: loading
                    ? SizedBox(
                        height: 12,
                        width: 12,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                    : Text("Download Receipt"),
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10))),
              )),
            ],
          )
        ],
      ),
    );
  }
}
