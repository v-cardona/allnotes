import 'package:allnotes/di/get_it.dart';
import 'package:allnotes/presentation/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:allnotes/presentation/blocs/login_bloc/login_bloc.dart';
import 'package:allnotes/presentation/journeys/login/login_form.dart';
import 'package:flutter/material.dart';
import 'package:formz/formz.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../widgets/authentication_background.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
    return Scaffold(
        body: BlocProvider.value(
      value: _loginBloc,
      child: BlocListener(
        cubit: _loginBloc,
        child: BlocBuilder(
          cubit: _loginBloc,
          builder: (context, state) {
            return Stack(
              children: <Widget>[AuthenticationBackground(), LoginForm()],
            );
          },
        ),
        listener: (context, LoginState state) {
          // hide previous snackbars
          Scaffold.of(context).hideCurrentSnackBar();

          // if fail when login show snackbar fail
          if (state.status.isSubmissionFailure) {
            Scaffold.of(context).showSnackBar(SnackBar(
              content: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [Text('Login failure...'), Icon(Icons.error)],
              ),
              backgroundColor: Colors.red,
            ));
          }

          // if login success emit Logged state to change to homeScreen
          if (state.status.isSubmissionSuccess) {
            BlocProvider.of<AuthenticationBloc>(context).add(LoggedIn());
          }
        },
      ),
    ));
  }
}
