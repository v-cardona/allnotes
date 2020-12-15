import 'package:flutter/material.dart';

import 'create_account_button.dart';
import 'google_login_button.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding:EdgeInsets.symmetric(vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            GoogleLoginButton(),
            CreateAccountButton()
          ],
        ),
      ),
    );
  }
}