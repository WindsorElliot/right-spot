import 'package:flutter/foundation.dart';
import 'package:right_spot/model/bas_model.dart';
import 'package:right_spot/model/user.dart';

class Comment implements BaseModel {
  final int id;
  final User user;
  final String comment;

  Comment({ @required this.id, @required this.comment, @required this.user });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      id: json['id'], 
      comment: json['comment'], 
      user: User.fromJson(json['user'])
    );
  }

  @override
  String entityName() {
    return "Comment";
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': this.id,
      'comment': this.comment,
    };
  }
  
}