import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:right_spot/api/api_response.dart';
import 'package:right_spot/api/repository/login_repository.dart';
import 'package:right_spot/controller/app_controller.dart';
import 'package:right_spot/model/token.dart';

class LoginController {
  final AppController appController;
  LoginRepository _loginRepository;
  StreamController _controller;

  StreamSink<ApiResponse<Token>> get loginSink => this._controller.sink;
  Stream<ApiResponse<Token>> get loginStream => this._controller.stream;

  LoginController({ @required this.appController }) {
    _loginRepository = LoginRepository();
    _controller = StreamController<ApiResponse<Token>>();
  }

  void getAuthToken(String username, String password) async {
    try {
      this._controller.add(ApiResponse<Token>.loading('Get authentication token'));
      final response = await this._loginRepository.getAuthToken(username, password);
      this._controller.add(ApiResponse<Token>.completed(response));
      this.appController.setAppToken(response);
    } catch (e) {
      this._controller.add(ApiResponse<Token>.error(e.toString()));
    }
  }

  void dispose() {
    _controller.close();
  }
}