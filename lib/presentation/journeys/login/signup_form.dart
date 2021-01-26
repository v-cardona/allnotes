import 'package:allnotes/presentation/blocs/signup_bloc/signup_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

class SignupForm extends StatelessWidget {
  const SignupForm({Key key}) : super(key: key);

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
                  'Sign Up',
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
                  height: 30,
                ),
                _PasswordConfirmInput(),
                SizedBox(
                  height: 60,
                ),
                _SignUpButton()
              ],
            ),
          ),
          FlatButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Already have an account? Login here'),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0)),
          )
        ],
      ),
    );
  }
}


class _EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupBloc, SignupState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: TextField(
            onChanged: (value) => BlocProvider.of<SignupBloc>(context)
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
    return BlocBuilder<SignupBloc, SignupState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: TextField(
            onChanged: (value) => BlocProvider.of<SignupBloc>(context)
                .add(PasswordChanged(password: value)),
            keyboardType: TextInputType.emailAddress,
            obscureText: true,
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

class _PasswordConfirmInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupBloc, SignupState>(
      buildWhen: (previous, current) =>
          previous.password != current.password ||
          previous.passwordConfirm != current.passwordConfirm,
      builder: (context, state) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: TextField(
            onChanged: (value) => BlocProvider.of<SignupBloc>(context)
                .add(PasswordConfirmChanged(password: value)),
            keyboardType: TextInputType.emailAddress,
            obscureText: true,
            decoration: InputDecoration(
                icon: Icon(
                  Icons.lock_outline,
                  color: Colors.deepPurple,
                ),
                labelText: 'Confirma tu contraseña',
                errorText: state.passwordConfirm.invalid
                    ? 'Las contraseñas no coinciden'
                    : null),
          ),
        );
      },
    );
  }
}


class _SignUpButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupBloc, SignupState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status.isSubmissionInProgress
            ? const CircularProgressIndicator()
            : RaisedButton(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 80, vertical: 15),
        child: Text('Registrarse'),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      elevation: 0,
      color: Colors.deepPurple,
      textColor: Colors.white,
      onPressed: state.status.isValid
          ? () {
              BlocProvider.of<SignupBloc>(context).add(
                  SignupWithCredentialsPressed(
                      email: state.email,
                      password: state.password,
                      passwordConfirm: state.passwordConfirm));
            }
          : null,
    );
      },
    );
  }
}