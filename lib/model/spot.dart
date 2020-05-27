import 'package:flutter/foundation.dart';
import 'package:right_spot/model/bas_model.dart';
import 'package:right_spot/model/comment.dart';
import 'package:right_spot/model/geoloc.dart';
import 'package:right_spot/model/image.dart';

class SpotResponse {
  final List<Spot> spots;

  SpotResponse({ @required this.spots });

  factory SpotResponse.fromJson(List<dynamic> json) {
    List<Spot> list = List<Spot>();
    json.forEach((element) {
      list.add(Spot.fromJson(element));
    });

    return SpotResponse(spots: list);
  }
}

enum SpotType {
  beachBreak,
  reefBreak,
  pointBreak
}

class Spot implements BaseModel {
  final int id;
  final String name;
  final double note;
  final String description;
  final SpotType type;
  final Geoloc geoloc;
  final List<Comment> comments;
  final List<Image> images;

  Spot({ 
    @required this.id, 
    @required this.name, 
    @required this.note, 
    @required this.description, 
    @required this.type,
    @required this.geoloc,
    @required this.images,
    @required this.comments
  });

  factory Spot.fromJson(Map<String, dynamic> json) {
    if (null == json['id'] ||  null == json['geoloc']) {
      throw ConvertExeption('Spot');
    }
    List<Image> images = List<Image>();
    if (json['images'] != null) {
      final list = json['images'] as List;
      images = list.map((e) => Image.fromJson(e)).toList();
    }
    List<Comment> comments = List<Comment>();
    if (json['comments'] != null) {
      final list = json['comments'] as List;
      comments = list.map((e) => Comment.fromJson(e)).toList();
    }


    return Spot(
      id: json['id'] as int, 
      name: json['name'] as String, 
      note: (json['note'] != null) ? json['note'] as double : null, 
      description: (json['description'] != null) ? json['description'] as String : null,
      type: Spot.typeFromString(json['type']),
      geoloc: Geoloc.fromJson(json['geoloc']),
      images: images,
      comments: comments
    );
  }

  static SpotType typeFromString(String string) {
    if (string == "beachBreak") {
      return SpotType.beachBreak;
    }
    if (string == "pointBreak") {
      return SpotType.pointBreak;
    }
    if (string == "reefBreak") {
      return SpotType.reefBreak;
    }

    return SpotType.beachBreak;
  }

  String typeName() {
    switch (this.type) {
      case SpotType.beachBreak:
        return "Beach\nbreak";
        break;
      case SpotType.reefBreak:
        return "Reef\nbreak";
        break;
      case SpotType.pointBreak:
        return "Point\nbreak";
        break;
      default:
        return "Beach\nbreak";
    }
  }

  String enumName() {
    switch (this.type) {
      case SpotType.beachBreak:
        return "beachBreak";
        break;
      case SpotType.reefBreak:
        return "reefBreak";
        break;
      case SpotType.pointBreak:
        return "pointBreak";
        break;
      default:
        return "beachBreak";
    }
  }

  Map<String, dynamic> toJson() {
    return {
      "id": this.id,
      "name": this.name,
      "note": this.note,
      "description": this.description,
      "type": this.enumName(),
      "geoloc": this.geoloc.toJson()
    };
  }

  String entityName() {
    return 'Spot';
  }
}