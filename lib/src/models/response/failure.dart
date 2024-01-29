import 'package:greycell_app/src/models/response/response.dart';

class Failure implements ResponseMania {
  ResponseManiaStatus responseStatus;
  String? responseMessage;

  Failure({this.responseMessage, required this.responseStatus});
}

const String responseTokenErrorMessage =
    'There is a problem, while retrieving.';
const String responseFailedMessage = 'No Data available';
const String internalMessage = 'Internal errors';
