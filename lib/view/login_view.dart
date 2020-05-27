import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:right_spot/controller/bloc/app_bloc.dart';
import 'package:right_spot/controller/bloc/login_bloc.dart';
import 'package:right_spot/controller/event/app_event.dart';
import 'package:right_spot/controller/event/login_event.dart';
import 'package:right_spot/controller/state/api_response.dart';
import 'package:right_spot/model/login.dart';




class LoginView extends StatefulWidget {

  @override
  _LoginViewState createState() => _LoginViewState();
}


class _LoginViewState extends State<LoginView> {

  TextEditingController _textFieldUsername;
  TextEditingController _textFieldPassword;
  LoginBloc _loginBloc;

  @override
  void initState() {
    _textFieldUsername = TextEditingController();
    _textFieldPassword = TextEditingController();
    _loginBloc = LoginBloc();
    super.initState();
  }

  @override
  void dispose() {
    _loginBloc.close();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login')
      ),
      body: BlocConsumer(
        bloc: this._loginBloc,
        listener: (BuildContext context, ApiResponse<Login> state) {
          if (state.status == Status.NONE) {
            Scaffold.of(context)
              ..hideCurrentSnackBar();
          }
          if (state.status == Status.LOADING) {
            Scaffold.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(SnackBar(content: Center(child: Text('Loading ...'))));
          }
          if (state.status == Status.ERROR) {
            Scaffold.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(SnackBar(content: Center(child: Text(state.message))));
          }
          if (state.status == Status.COMPLETED) {
            BlocProvider.of<AppBloc>(context)
              ..add(AppLogged(token: state.data.token));
          }
        },
        builder: (BuildContext context, ApiResponse<Login> state) {
          return Container(
            margin: EdgeInsets.only(left: 20, right: 20),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: this._textFieldUsername,
                  ),
                  TextField(
                    controller: this._textFieldPassword,
                  ),
                  SizedBox(height: 20),
                  RaisedButton(
                    onPressed: () {
                      this._loginBloc.add(LoginSbmitted(username: this._textFieldUsername.text, password: this._textFieldPassword.text));
                    },
                    child: Center(
                      child: Text('Login'),
                    ),
                  )
                ],
              )
            )
          );
        }
      )
    );
  } 
}