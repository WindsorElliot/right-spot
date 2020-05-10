import 'dart:async';

import 'package:right_spot/api/api_response.dart';
import 'package:right_spot/api/repository/login_repository.dart';
import 'package:right_spot/model/token.dart';

class LoginController {
  LoginRepository _loginRepository;
  StreamController _controller;

  StreamSink<ApiResponse<Token>> get loginSink => this._controller.sink;
  Stream<ApiResponse<Token>> get loginStream => this._controller.stream;

  LoginController() {
    _loginRepository = LoginRepository();
    _controller = StreamController<ApiResponse<Token>>();
  }

  getAuthToken(String username, String password) async {
    try {
      this._controller.add(ApiResponse.loading('Get authentication token'));
      final response = await this._loginRepository.getAuthToken(username, password);
      this._controller.add(ApiResponse.completed(response));
    } catch (e) {
      this._controller.add(ApiResponse.error(e.toString()));
    }
  }

  void dispose() {
    _controller.close();
  }
}