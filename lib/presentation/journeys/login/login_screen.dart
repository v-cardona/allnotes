import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:allnotes/di/get_it.dart';
import 'package:allnotes/presentation/blocs/login_bloc/login_bloc.dart';
import 'package:allnotes/presentation/journeys/login/login_form.dart';

class LoginScreen extends StatefulWidget {

  const LoginScreen({Key key}) : super(key: key);

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
      appBar: AppBar(title: Text('Login'),),
      body: BlocProvider.value(
        value: _loginBloc,
        child: LoginForm(),
      )
    );
  }

}