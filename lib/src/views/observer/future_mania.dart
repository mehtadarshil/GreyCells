import 'package:flutter/material.dart';
import 'package:greycell_app/src/models/response/failure.dart';
import 'package:greycell_app/src/models/response/response.dart';
import 'package:greycell_app/src/models/response/success.dart';

class FutureMania extends StatelessWidget {
  @required
  final Function? onError;

  @required
  final Function? onSuccess;

  final Function? onFailed;

  @required
  final Future<ResponseMania?>? future;

  final Function? onWaiting;

  FutureMania(
      {this.onError,
      this.onSuccess,
      this.future,
      this.onWaiting,
      this.onFailed})
      : assert(onFailed != null || onError != null);

  Function get _defaultOnWaiting => (context) => Center(
        child: CircularProgressIndicator(),
      );

  Function get _defaultOnError => (context, error) => Center(
        child: Text(error),
      );

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ResponseMania?>(
      future: future,
      builder: (BuildContext context, AsyncSnapshot<ResponseMania?> snapshot) {
        print(snapshot.data);
        if (snapshot.hasError)
          return onError!<Failure>(
              context,
              Failure(
                  responseMessage: "Internal error occured",
                  responseStatus: ResponseManiaStatus.ERROR));
        if (snapshot.hasData) {
          ResponseMania? mania = snapshot.data;
//          print("Mania is ${mania is Failure}");
//          print("Mania is ${mania is Success}");
          if (mania is Failure) {
            if (mania.responseStatus == ResponseManiaStatus.FAILED) {
              /// For Making onFailed Optional
//              print("Mania is Failure");

              return onFailed != null
                  ? onFailed!(
                      context,
                      Failure(
                          responseMessage: mania.responseMessage,
                          responseStatus: mania.responseStatus))
                  : onError!<Failure>(
                      context,
                      Failure(
                          responseMessage: mania.responseMessage,
                          responseStatus: mania.responseStatus));
            } else {
//              print("Mania is Failure");

              return onError!(
                  context,
                  Failure(
                      responseMessage: mania.responseMessage,
                      responseStatus: mania.responseStatus));
            }
          } else if (mania is Success) {
            return onSuccess!(context, mania.success);
          } else {
            return onError!<Failure>(
                context,
                Failure(
                    responseMessage: "",
                    responseStatus: ResponseManiaStatus.ANY));
          }
        } else {
          return onWaiting != null
              ? onWaiting!(context)
              : _defaultOnWaiting(context);
        }
      },
    );
  }
}
