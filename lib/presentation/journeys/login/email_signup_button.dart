import 'package:allnotes/presentation/journeys/login/signup_screen.dart';
import 'package:flutter/material.dart';


class EmailSignupButton extends StatelessWidget {
  const EmailSignupButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: () =>
        Navigator.push(context, MaterialPageRoute(builder: (context) => SignupScreen())),
      child: Text('Don\'t have an account? Sign Up'),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0)
      ),
    );
  }
}