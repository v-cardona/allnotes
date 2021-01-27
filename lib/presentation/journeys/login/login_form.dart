import 'package:allnotes/presentation/blocs/login_bloc/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import 'email_signup_button.dart';
import 'google_login_button.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SafeArea(
            child: Container(
              height: 130,
            ),
          ),
          Container(
            width: size.width * 0.85,
            margin: EdgeInsets.only(top: 30, left: 30, bottom: 10, right: 30),
            padding: EdgeInsets.symmetric(vertical: 30),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Colors.black26,
                    blurRadius: 3,
                    offset: Offset(0, 5),
                    spreadRadius: 3)
              ],
            ),
            child: Column(
              children: <Widget>[
                Text(
                  'Login',
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(
                  height: 40,
                ),
                _EmailInput(),
                SizedBox(
                  height: 30,
                ),
                _PasswordInput(),
                SizedBox(
                  height: 60,
                ),
                _LoginButton(),
                SizedBox(
                  height: 30,
                ),
                Row(children: <Widget>[
                  Expanded(child: Divider()),
                  SizedBox(
                    width: 20,
                  ),
                  Text("Or continue using"),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(child: Divider()),
                ]),
                SizedBox(
                  height: 20,
                ),
                GoogleLoginButton(),
              ],
            ),
          ),
          EmailSignupButton()
        ],
      ),
    );
  }
}

class _EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: TextField(
            onChanged: (value) => BlocProvider.of<LoginBloc>(context)
                .add(EmailChanged(email: value)),
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
                icon: Icon(
                  Icons.alternate_email,
                  color: Colors.deepPurple,
                ),
                hintText: 'ejemplo@correo.com',
                labelText: 'Correo Electrónico',
                errorText: state.email.invalid ? 'Correo inválido' : null),
          ),
        );
      },
    );
  }
}

class _PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: TextField(
            onChanged: (value) => BlocProvider.of<LoginBloc>(context)
                .add(PasswordChanged(password: value)),
            keyboardType: TextInputType.visiblePassword,
            obscureText: true,
            enableSuggestions: false,
            autocorrect: false,
            decoration: InputDecoration(
                icon: Icon(
                  Icons.lock_outline,
                  color: Colors.deepPurple,
                ),
                labelText: 'Contraseña',
                errorText: state.password.invalid
                    ? 'Debe tener una longitud entre 8 y 50 carácteres'
                    : null),
          ),
        );
      },
    );
  }
}

class _LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status.isSubmissionInProgress
            ? const CircularProgressIndicator()
            : RaisedButton(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                  child: Text('Ingresar'),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                elevation: 0,
                color: Colors.deepPurple,
                textColor: Colors.white,
                onPressed: state.status.isValid
                    ? () {
                        BlocProvider.of<LoginBloc>(context).add(
                            LoginWithCredentialsPressed(
                                email: state.email, password: state.password));
                      }
                    : null,
              );
      },
    );
  }
}
