import 'package:flutter/material.dart';

class EmailOpenLoginButton extends StatelessWidget {
  const EmailOpenLoginButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: () => Navigator.pop(context),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Already have an account? '),
          Text(
            'Login here',
            style: TextStyle(color: Colors.deepPurple),
          ),
        ],
      ),
    );
  }
}
