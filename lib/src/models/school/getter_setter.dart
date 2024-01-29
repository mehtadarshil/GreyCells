import 'package:greycell_app/src/models/school/school.dart';

class SchoolGS {
  School? _school;

  School? get school => _school == null ? School() : _school;

  set school(School? s) {
    _school = s;
  }
}
