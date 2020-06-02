import 'package:flutter/foundation.dart';
import 'package:right_spot/model/bas_model.dart';
import 'package:right_spot/model/token.dart';

class User implements BaseModel {
  final int id;
  final String username;
  final String email;
  final String profilImageUrl;
  Token token;

  User({ @required this.id, @required this.username, @required this.email, @required this.profilImageUrl, this.token});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'], 
      username: json['username'], 
      email: json['email'],
      profilImageUrl: json['profilImageUrl'] ?? null,
      token: (json['token'] != null) ? Token.fromJson(json['token']) : null
    );
  }

  @override
  String entityName() {
    return "User";
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "id": this.id,
      "username": this.username,
      "email": this.email,
      "profilImageUrl": this.profilImageUrl ?? null
    };
  }

  Map<String, dynamic> toJsonWithToken() {
    return {
      "id": this.id,
      "username": this.username,
      "email": this.email,
      "profilImageUrl": this.profilImageUrl ?? null,
      "token": this.token.toJson()
    };
  }

  
}