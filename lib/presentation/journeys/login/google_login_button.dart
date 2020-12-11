import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:allnotes/presentation/blocs/login_bloc/login_bloc.dart';

class GoogleLoginButton extends StatelessWidget {
  const GoogleLoginButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RaisedButton.icon(
      onPressed: () =>
        BlocProvider.of<LoginBloc>(context).add(LoginWithGooglePressed()),
      icon: Icon(FontAwesomeIcons.google),
      label: Text('Continue with Google'),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0)
      ),
    );
  }
}