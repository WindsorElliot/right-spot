import 'package:flutter/foundation.dart';
import 'package:right_spot/api/base_api_helper.dart';
import 'package:right_spot/api/repository/base_repository.dart';
import 'package:right_spot/model/geoloc.dart';

class GeolocRepository implements BaseRepository {
  final String bearerToken;

  GeolocRepository({ @required this.bearerToken });

  final BaseApiHelper _helper = BaseApiHelper();

  Future<List<Geoloc>> fetch() async {
    final response = await this._helper.get(target: '/geoloc', header: BaseApiHelper.headers(token: this.bearerToken), params: BaseApiHelper.params());
    return GeolocResponse.fromJson(response).geolocs;
  }

  Future<Geoloc> getById(int id) async {
    final response = await this._helper.get(target: '/geoloc', header: BaseApiHelper.headers(token: this.bearerToken), params: BaseApiHelper.params());
    return Geoloc.fromJson(response);
  }

  Future<Geoloc> update(int id, data) async {
    throw UnimplementedError();
  }

  Future<int> delete(int id) async {
    throw UnimplementedError();
  }
}