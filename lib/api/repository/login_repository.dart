import 'package:right_spot/api/base_api_helper.dart';
import 'dart:convert';

import 'package:right_spot/model/token.dart';

class LoginRepository {
  final BaseApiHelper _baseApiHelper = BaseApiHelper();
  
  String _generateBaseToken() {
    const clientID = "com.rightspot.postman";
    final String clientCredentials = const Base64Encoder().convert("$clientID:".codeUnits);
    return clientCredentials;
  }

  String _generateBody(username, password) {
    return "username=$username&password=$password&grant_type=password";
  }

  Map<String, String> _getHeader() {
    return {
      "Content-Type": "application/x-www-form-urlencoded",
      "Authorization": "Basic ${this._generateBaseToken()}"
    };
  }

  Future<Token> getAuthToken(String username, String password) async {
    final response = await this._baseApiHelper.post(target: '/auth/token', header: this._getHeader(), body: this._generateBody(username, password));
    return Token.fromJson(response);
  }

}