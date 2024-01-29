import 'package:flutter/material.dart';

class FutureObserver<T> extends StatelessWidget {
  final Function? onError;

  @required
  final Function? onSuccess;

  @required
  final Future<T>? future;

  final Function? onWaiting;

  FutureObserver({this.onError, this.onSuccess, this.future, this.onWaiting});

  Function get _defaultOnWaiting => (context) => Center(
        child: CircularProgressIndicator(),
      );

  Function get _defaultOnError => (context, error) => Center(
        child: Text(error),
      );

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: future,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        print(snapshot.connectionState);
        if (snapshot.connectionState == ConnectionState.waiting ||
            snapshot.connectionState == ConnectionState.active) {
          return onWaiting != null
              ? onWaiting!(context)
              : _defaultOnWaiting(context);
        } else {
          if (snapshot.data == null) {
            return onError != null
                ? onError!(context, "Internal error")
                : _defaultOnError(context, "Internal error");
          } else if (snapshot.hasError) {
            return onError != null
                ? onError!(context, snapshot.error)
                : _defaultOnError(context, snapshot.error);
          } else {
            print("SnapShot Data : ${snapshot.data}");
            return onSuccess!(context, snapshot.data);
          }
        }
      },
    );
  }
}
