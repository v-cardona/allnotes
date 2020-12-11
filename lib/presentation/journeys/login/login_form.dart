import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:allnotes/di/get_it.dart';
import 'package:allnotes/presentation/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:allnotes/presentation/blocs/login_bloc/login_bloc.dart';

import 'create_account_button.dart';
import 'google_login_button.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {

  LoginBloc _loginBloc;

  @override
  void initState() { 
    super.initState();
    _loginBloc = getItInstance<LoginBloc>();
  }

  @override
  void dispose() {
    super.dispose();
    _loginBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      cubit: _loginBloc,
      listener: (context, LoginState state) {
        // if fail when login show snackbar fail
        if (state.isFailure) {
          Text('Login failure...');
        }

        // if submitting when login show snackbar loading
        if (state.isSubmitting) {
          CircularProgressIndicator();
        }

        if (state.isSuccess) {
          BlocProvider.of<AuthenticationBloc>(context).add(LoggedIn());
        }
      },
      child: BlocBuilder(
        cubit: _loginBloc,
        builder: (context, state) {
          return Padding(
            padding:EdgeInsets.symmetric(vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                GoogleLoginButton(),
                CreateAccountButton()
              ],
            ),
          );
        },
      ),
    );
  }
}