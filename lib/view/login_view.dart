import 'package:flutter/material.dart';
import 'package:right_spot/api/api_response.dart';
import 'package:right_spot/controller/app_controller.dart';
import 'package:right_spot/controller/login_controller.dart';

class LoginView extends StatelessWidget {
  final AppController appController;
  final TextEditingController _textFieldUsername = TextEditingController();
  final TextEditingController _textFieldPassword = TextEditingController();

  LoginView({ @required this.appController });

  Widget build(BuildContext context) {
    final loginController = LoginController(appController: this.appController);
    return Scaffold(
      appBar: AppBar(
        title: Text('Login')
      ),
      body: Builder(
        builder: (BuildContext context) {
          loginController.loginStream.listen((event) {
            if (event.status == Status.LOADING) {
              Scaffold.of(context)
                ..hideCurrentSnackBar()..showSnackBar(
                  SnackBar(content: Text('Chargement'))
              );
            }
            if (event.status == Status.ERROR) {
              Scaffold.of(context)
                ..hideCurrentSnackBar()..showSnackBar(
                  SnackBar(content: Text(event.message))
              );
            }
            if (event.status == Status.COMPLETED) {
              Scaffold.of(context)
                ..hideCurrentSnackBar()..showSnackBar(
                  SnackBar(content: Text(event.data.toString()))
              );
            }
          });
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
                      loginController.getAuthToken(this._textFieldUsername.text, this._textFieldPassword.text);
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