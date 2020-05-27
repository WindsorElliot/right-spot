import 'package:flutter/foundation.dart';
import 'package:right_spot/api/base_api_helper.dart';
import 'package:right_spot/api/repository/base_repository.dart';
import 'package:right_spot/model/spot.dart';

class SpotRepository implements BaseRepository {
  final String bearerToken;

  SpotRepository({ @required this.bearerToken });

  final BaseApiHelper _baseApiHelper = BaseApiHelper();


  Future<List<Spot>> fetch() async {
    final response = await _baseApiHelper.get(target: "/spot", header: BaseApiHelper.headers(token: this.bearerToken), params: BaseApiHelper.params(includeGeoloc: true, includeImage: true, includeComments: true));
    return SpotResponse.fromJson(response).spots;
  }

  Future<Spot> getById(int id) async {
    final response = await _baseApiHelper.get(target: "/spot/$id", header: BaseApiHelper.headers(token: this.bearerToken), params: BaseApiHelper.params(includeSpot: true, includeGeoloc: true, includeImage: true));
    return Spot.fromJson(response);
  }

  Future<Spot> update(int id) async {
    return Future.error("not implmented");
  }

  Future<int> delete(int id) async {
    return Future.error("not implmented");
  }
}