import 'package:allnotes/presentation/journeys/signup/signup_screen.dart';
import 'package:flutter/material.dart';

class EmailOpenSignupButton extends StatelessWidget {
  const EmailOpenSignupButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: () => Navigator.push(
          context, MaterialPageRoute(builder: (context) => SignupScreen())),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Don\'t have an account? '),
          Text(
            'Sign Up',
            style: TextStyle(color: Colors.deepPurple),
          ),
        ],
      ),
    );
  }
}
