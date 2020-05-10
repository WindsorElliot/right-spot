import 'package:flutter/foundation.dart';
import 'package:right_spot/model/bas_model.dart';

class GeolocResponse {
  final List<Geoloc> geolocs;

  GeolocResponse({ @required this.geolocs });

  factory GeolocResponse.fromJson(List<Map<String, dynamic>> json) => GeolocResponse(geolocs: json.map((e) => Geoloc.fromJson(e)).toList());
}

class Geoloc implements BaseModel {
  final int id;
  double lattitude;
  double longitude;

  Geoloc({ @required this.id, @required this.lattitude, @required this.longitude });

  factory Geoloc.fromJson(Map<String, dynamic> json) {
    if (null == json['id'] || null == json['lattitude'] || null == json['longitude']) {
      throw ConvertExeption('Geoloc');
    }
    return Geoloc(
      id: json['id'] as int,
      lattitude: json['lattitude'] as double,
      longitude: json['longitude'] as double
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": this.id,
      "lattitude": this.lattitude,
      "longitude": this.longitude
    };
  }

  String entityName() {
    return 'Geoloc';
  }
}