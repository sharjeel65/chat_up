class Validator {
  static String? validateName({required String? name}) {
    if (name == null) {
      return null;
    }

    if (name.isEmpty) {
      return 'Name can\'t be empty';
    }

    return null;
  }

  static String? validateNumber({required String? number}) {
    if (number == null) {
      return null;
    }

    RegExp NumberRegExp = RegExp(r"^[0-9]{6,14}$");

    if (number.isEmpty) {
      return 'Number can\'t be empty';
    } else if (!NumberRegExp.hasMatch(number)) {
      return 'Enter a correct Number, no symbols';
    }
    return null;
  }

  static String? validateEmail({required String? email}) {
    if (email == null) {
      return null;
    }

    RegExp emailRegExp =
        RegExp(r"([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})");

    if (email.isEmpty) {
      return 'Email can\'t be empty';
    } else if (!emailRegExp.hasMatch(email)) {
      return 'Enter a correct email';
    }
    return null;
  }

  static String? validatePassword({required String? password}) {
    if (password == null) {
      return null;
    }

    if (password.isEmpty) {
      return 'Password can\'t be empty';
    } else if (password.length < 6) {
      return 'Enter a password with length at least 6';
    }

    return null;
  }

  static String? ValidateConfPassword(
      {required String? Confpassword, required String? password}) {
    if (Confpassword == null) {
      return null;
    }
    if (Confpassword.isEmpty) {
      return 'Password can\'t be empty';
    } else if (Confpassword != password) {
      return 'Your Passwords are different';
    }
    return null;
  }
}
