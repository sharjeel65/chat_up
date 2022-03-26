
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

    RegExp emailRegExp = RegExp(
        r"^(?:(?:\+?1\s*(?:[.-]\s*)?)?(?:\(\s*([2-9]1[02-9]|[2-9][02-8]1|[2-9][02-8][02-9])\s*\)|([2-9]1[02-9]|[2-9][02-8]1|[2-9][02-8][02-9]))\s*(?:[.-]\s*)?)?([2-9]1[02-9]|[2-9][02-9]1|[2-9][02-9]{2})\s*(?:[.-]\s*)?([0-9]{4})(?:\s*(?:#|x\.?|ext\.?|extension)\s*(\d+))?$");

    if (number.isEmpty) {
      return 'Number can\'t be empty';
    } else if (!emailRegExp.hasMatch(number)) {
      return 'Enter a correct Number';
    }
    return null;
  }

  static String? validateEmail({required String? email}) {
    if (email == null) {
      return null;
    }

    RegExp emailRegExp = RegExp(
        r"([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})");

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
  static String? ValidateConfPassword({required String? Confpassword,required String? password}) {
    if (Confpassword == null) {
      return null;
    }
    if (Confpassword.isEmpty) {
      return 'Password can\'t be empty';
    } else if (Confpassword!=password) {
      return 'Your Passwords are different';
    }

    return null;
  }
}
