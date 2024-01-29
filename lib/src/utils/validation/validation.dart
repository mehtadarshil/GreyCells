class Validation {
  String? validatePassword(String value) {
    Pattern pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regex = RegExp(pattern as String);
    String? msg;
    if (value.isEmpty) {
      msg = 'Please enter a password';
    } else {
      if (!regex.hasMatch(value))
        msg =
            'Password must contain upper case, lower case,\n digit and one special character';
      else
        msg = null;
    }
    return msg;
  }

// Making Form Email Validation
  String validateEmail(String value) {
    Pattern pattern = r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
    RegExp regex = RegExp(pattern as String);
    String? msg = '';
    if (!regex.hasMatch(value)) {
      msg = 'Please enter a valid email';
    } else {
      msg = null;
    }
    return msg!;
  }

  String usernameValidator(String value) {
    if (value.isEmpty) {
      return 'Please enter a name';
    } else if (value.length < 4) {
      return 'Name must be 4';
    } else {
      return '';
    }
  }

  String? loginPasswordValidator(String? value) {
    if (value!.isEmpty) {
      return 'Please enter a password';
    } else if (value.length < 4) {
      return 'Passowrd must be 4';
    }
  }

  String? schoolCodeValidator(String? value) {
    if (value!.isEmpty) {
      return 'Please enter school code';
    } else if (value.length < 4) {
      return 'School code must be 4';
    }
  }

  String? userIdValidator(String? value) {
    if (value!.isEmpty) {
      return 'Please enter user id';
    } else if (value.length < 2) {
      return 'User id must be valid';
    }
  }

  String? confirmPassowardValidator(String password, String confrim) {
    if (confrim.isEmpty) {
      return 'Please enter confirm password';
    } else if (password != confrim) {
      return 'Passwords not match';
    }
  }

  String mobileValidator(String value) {
    String patttern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      return 'Please enter mobile number';
    } else if (!regExp.hasMatch(value)) {
      return 'Please enter valid mobile number';
    } else {
      return '';
    }
  }
}
