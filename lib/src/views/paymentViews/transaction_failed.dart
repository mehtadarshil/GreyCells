import 'package:flutter/material.dart';
import 'package:greycell_app/src/commons/widgets/error_data.dart';
import 'package:greycell_app/src/manager/main_model.dart';
import 'package:greycell_app/src/views/homeViews/home_views.dart';
import 'package:scoped_model/scoped_model.dart';

class TransactionFailed extends StatelessWidget {
  final String? message;

  TransactionFailed({Key? key, this.message});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[100],
        elevation: 0.0,
        leading: ScopedModelDescendant(
          builder: (_, __, MainModel model) {
            return IconButton(
                icon: Icon(Icons.arrow_back),
                color: Colors.black87,
                onPressed: () => Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => MyHomeViews(
                              model: model,
                              index: 1,
                            )),
                    (route) => false));
          },
        ),
        title: Text(
          "Transaction Failed",
          style: TextStyle(color: Colors.black87),
        ),
      ),
      body: MyErrorData(
        errorMsg: "Transaction Failed",
        subtitle:
            message ?? "Something went wrong.\nPlease check your connectivity.",
      ),
    );
  }
}
