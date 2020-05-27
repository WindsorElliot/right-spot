import 'package:flutter/foundation.dart';
import 'package:right_spot/model/bas_model.dart';

class Image implements BaseModel {
  final int id;
  final String name;
  final String url;
  final bool isDefault;

  Image({ @required this.id, @required this.name, @required this.url, @required this.isDefault });

  factory Image.fromJson(Map<String, dynamic> json) {
    return Image(
      id: json['id'], 
      name: json['name'], 
      url: json['url'],
      isDefault: json['isDefault']
    );
  }

  @override
  String entityName() {
    return "Image";
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': this.id,
      'name': this.name,
      'url': this.url,
      'isDefault': this.isDefault
    };
  }
}