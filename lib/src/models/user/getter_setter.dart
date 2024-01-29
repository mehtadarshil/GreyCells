import 'package:greycell_app/src/models/user/user.dart';

class UserGS {
  User? _user;

  User? get userData => _user == null ? User() : _user;

  set userData(User? u) {
    _user = u;
  }
}
