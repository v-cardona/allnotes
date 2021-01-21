import 'package:allnotes/common/constants/regex_constants.dart';
import 'package:formz/formz.dart';

enum EmailValidationError { invalid}

class Email extends FormzInput<String, EmailValidationError> {

  const Email.pure() : super.pure('');
  const Email.dirty([String value = '']) : super.dirty(value);

  @override
  EmailValidationError validator(String value) {
    return Regex.emailRegExp.hasMatch(value) ? null : EmailValidationError.invalid;
  }

}