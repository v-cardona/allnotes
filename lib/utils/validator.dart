import 'package:allnotes/common/constants/regex_constants.dart';

class Validator {

  static isValidEmail(String email) {
    return Regex.emailRegExp.hasMatch(email);
  }

  static isValidPassword(String password) {
    return Regex.passwordRegExp.hasMatch(password);
  }
}