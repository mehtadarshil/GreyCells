import 'package:greycell_app/src/models/response/response.dart';

class Success<T> implements ResponseMania {
  T? success;

  Success({this.success});
}
