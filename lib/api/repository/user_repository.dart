import 'package:flutter/foundation.dart';
import 'package:right_spot/api/base_api_helper.dart';
import 'package:right_spot/api/repository/base_repository.dart';
import 'package:right_spot/model/user.dart';

class UserRepository implements BaseRepository {
  final String bearerToken;

  UserRepository({ @required this.bearerToken });

  final BaseApiHelper _helper = BaseApiHelper();

  Future<User> getCurrentUser() async {
    final response = await this._helper.get(target: '/user', header: BaseApiHelper.headers(token: this.bearerToken));
    return User.fromJson(response);
  }

  @override
  Future<int> delete(int id) {
    throw UnimplementedError();
  }

  @override
  Future<List> fetch() {
    throw UnimplementedError();
  }

  @override
  Future<User> getById(int id) {
    throw UnimplementedError();
  }

  @override
  Future<User> update(int id, data) {
    throw UnimplementedError();
  }
  
}