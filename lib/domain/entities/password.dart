import 'package:allnotes/common/constants/regex_constants.dart';
import 'package:formz/formz.dart';

enum PasswordValidationError { invalid }

class Password extends FormzInput<String, PasswordValidationError> {

  const Password.pure() : super.pure('');
  const Password.dirty([String value = '']) : super.dirty(value);

  @override
  PasswordValidationError validator(String value) {
    return Regex.passwordRegExp.hasMatch(value) ? null : PasswordValidationError.invalid;
  }
}