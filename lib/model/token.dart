import 'package:flutter/foundation.dart';
import 'package:right_spot/model/bas_model.dart';

class Token implements BaseModel {
  String accessToken;
  final String tokenType;
  int expiresIn;

  Token({ @required this.accessToken, @required this.tokenType, @required this.expiresIn });

  factory Token.fromJson(Map<String, dynamic> json) {
    if (null != json["access_token"]) {
      throw ConvertExeption('Token');
    }
    return Token(
      accessToken: json["access_token"] as String, 
      tokenType: json["token_type"] as String,
      expiresIn: json["expire_in"] as int
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "data": "token"
    };
  }

  String entityName() {
    return 'Token';
  }
}