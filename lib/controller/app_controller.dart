import 'dart:async';
import 'dart:convert';

import 'package:right_spot/controller/state/app_state.dart';
import 'package:right_spot/model/token.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppController {

  StreamController<AppState<Token>> _controller;

  StreamSink<AppState<Token>>  get streamSink => this._controller.sink;
  Stream<AppState<Token>> get stream => this._controller.stream;

  AppController() {
    _controller = StreamController<AppState<Token>>();
    _getAppToken();
  }

  void _getAppToken() async {
    try {
      final sharedPref = await SharedPreferences.getInstance();
      final jsonString = sharedPref.getString('app_token_string');
      if (null == jsonString) {
        this._controller.add(AppState.notLogged());
      }
      else {
        final token = Token.fromJson(json.decode(jsonString));
        this._controller.add(AppState.logged(token));
      }
    }
    catch (error) {
      this._controller.add(AppState.error(error.toString()));
    }
  }

  void setAppToken(Token token) async {
    this._controller.add(AppState.loading("connecting"));
    try {
      final sharedPrefs = await SharedPreferences.getInstance();
      final jsonString = json.encode(token.toJson());
      final success = await sharedPrefs.setString('app_token_string', jsonString);
      if (true == success) {
        this._controller.add(AppState.logged(token));
      }
      else {
        this._controller.add(AppState.error('unknow error please retry'));
      }
    }
    catch (error) {
      this._controller.add(AppState.error(error.toString()));
    }
  }

  void dispose() {
    _controller.close();
  }
}