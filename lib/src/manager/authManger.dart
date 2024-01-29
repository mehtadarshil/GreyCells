import 'package:greycell_app/src/models/school/school.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Authentication extends Model {
  Future<void> saveSchoolData(School school, List schoolInfo) async {
    school = await School(
        schoolRank: schoolInfo[0].toString(),
        schoolName: schoolInfo[1].toString(),
        schoolFullName: schoolInfo[2].toString(),
        schoolCode: schoolInfo[3].toString(),
        schoolFirstServerAddress: schoolInfo[4].toString(),
        schoolSecondServerAddress: schoolInfo[5].toString(),
        schoolStatus: schoolInfo[6].toString());
    print(school.schoolFirstServerAddress);
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("schoolRank", schoolInfo[0]);
    prefs.setString("schoolName", schoolInfo[1]);
    prefs.setString("schoolFullName", schoolInfo[2]);
    prefs.setString("schoolCode", schoolInfo[3]);
    prefs.setString("schoolFirstServerAddress", schoolInfo[4]);
    prefs.setString("schoolSecondServerAddress", schoolInfo[5]);
    prefs.setString("schoolStatus", schoolInfo[6]);

    print("Successfully Saved ${prefs.get('schoolFirstServerAddress')}");
    notifyListeners();
  }

  void autoSchoolValidate(School school) async {
    print("Auto autoSchoolValidate Called");
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? schoolStatus = prefs.get("schoolStatus") as String?;
    print("School Status: $schoolStatus");
    final String? schoolServer = prefs.get("schoolFirstServerAddress") as String?;
    if (schoolStatus != null && schoolServer != null) {
      final String schoolRank = prefs.getString("schoolRank")!;
      final String schoolName = prefs.getString("schoolName")!;
      final String schoolFullName = prefs.getString("schoolFullName")!;
      final String schoolCode = prefs.getString("schoolCode")!;
      final String schoolFirstServerAddress =
          prefs.getString("schoolFirstServerAddress")!;
      final String schoolSecondServerAddress =
          prefs.getString("schoolSecondServerAddress")!;
      final String schoolStatus = prefs.getString("schoolStatus")!;

      print(schoolRank +
          schoolName +
          schoolFullName +
          schoolCode +
          schoolSecondServerAddress +
          schoolFirstServerAddress +
          schoolStatus);

      school = await School(
          schoolStatus: schoolStatus,
          schoolSecondServerAddress: schoolSecondServerAddress,
          schoolFirstServerAddress: schoolFirstServerAddress,
          schoolCode: schoolCode,
          schoolFullName: schoolFullName,
          schoolName: schoolName,
          schoolRank: schoolRank);
      print(
          "School Server Data From Auto Validate : ${school.schoolFirstServerAddress}");
      notifyListeners();
      print("Auto autoSchoolValidate Ended ");
    }
  }
}
