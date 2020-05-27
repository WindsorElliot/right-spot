import 'package:flutter/foundation.dart';
import 'package:right_spot/model/bas_model.dart';

class User implements BaseModel {
  final int id;
  final String username;
  final String email;
  final String profilImageUrl;

  User({ @required this.id, @required this.username, @required this.email, @required this.profilImageUrl});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'], 
      username: json['username'], 
      email: json['email'],
      profilImageUrl: json['profilImageUrl'] ?? null
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
      "email": this.email
    };
  }

  
}