class User {
  String? getUserId;
  String? getUserWingId;
  String? getUserType;

  User({this.getUserId, this.getUserWingId, this.getUserType});

  User.fromJson(Map<String, dynamic> json) {
    getUserId = json['getUserId'];
    getUserWingId = json['getUserWingId'];
    getUserType = json['getUserType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['getUserId'] = this.getUserId;
    data['getUserWingId'] = this.getUserWingId;
    return data;
  }
}

class MyMenu {
  List<UserMenu>? getMenuListVector;

  MyMenu({this.getMenuListVector});

  MyMenu.fromJson(Map<String, dynamic>? json) {
    this.getMenuListVector = <UserMenu>[];
    if (this.getMenuListVector != null) {
      json!['getMenuListVector'].forEach((value) {
        this.getMenuListVector!.add(UserMenu.fromJson(value));
      });
    }
  }
}

class UserMenu {
  String? menuItemId;
  String? mobileappMenuId;
  String? mobileappMenuCode;
  String? mobileappMenuName;

  UserMenu(
      {this.menuItemId,
      this.mobileappMenuId,
      this.mobileappMenuCode,
      this.mobileappMenuName});

  UserMenu.fromJson(List detail) {
    this.menuItemId = detail[0];
    this.mobileappMenuId = detail[1];
    this.mobileappMenuCode = detail[2];
    this.mobileappMenuName = detail[3];
  }
}
