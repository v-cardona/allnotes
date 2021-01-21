import 'package:formz/formz.dart';
import 'package:meta/meta.dart';

enum PasswordConfirmValidationError { invalid }

class PasswordConfirm
    extends FormzInput<String, PasswordConfirmValidationError> {
      
  final String password;

  const PasswordConfirm.pure({this.password = ''}) : super.pure(' ');
  const PasswordConfirm.dirty({@required this.password, String value = ''})
      : super.dirty(value);


  @override
  PasswordConfirmValidationError validator(String value) {
    return password == value ? null : PasswordConfirmValidationError.invalid;
  }
}
