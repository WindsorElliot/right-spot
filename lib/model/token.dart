import 'package:flutter/foundation.dart';
import 'package:right_spot/model/bas_model.dart';

class Token implements BaseModel {
  String accessToken;
  final String tokenType;
  int expiresIn;
  final String refreshToken;
  int createdTimestamp;

  Token({ @required this.accessToken, @required this.tokenType, @required this.expiresIn, @required this.refreshToken, @required this.createdTimestamp });

  factory Token.fromJson(Map<String, dynamic> json) {
    if (null == json["access_token"]) {
      throw ConvertExeption('Token');
    }
    return Token(
      accessToken: json["access_token"] as String, 
      tokenType: json["token_type"] as String,
      expiresIn: json["expires_in"] as int,
      refreshToken: json["refresh_token"] as String,
      createdTimestamp: (json["createdTimestamp"] != null) ? json["createdTimestamp"] : DateTime.now().millisecondsSinceEpoch
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "access_token": this.accessToken,
      "token_type": this.tokenType,
      "expires_in": this.expiresIn,
      "refresh_token": this.refreshToken,
      "createdTimestamp": this.createdTimestamp
    };
  }

  String entityName() {
    return 'Token';
  }
}