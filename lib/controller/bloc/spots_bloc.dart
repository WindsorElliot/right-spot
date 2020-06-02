import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:right_spot/api/repository/spot_repository.dart';
import 'package:right_spot/controller/event/spots_event.dart';
import 'package:right_spot/controller/state/api_response.dart';
import 'package:right_spot/model/spot.dart';
import 'package:right_spot/model/token.dart';
import 'package:right_spot/model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SpotsBloc extends Bloc<SpotsEvent, ApiResponse<List<Spot>>> {

  SpotsBloc() {
    this.add(FetchSpotsEvent());
  }

  @override
  ApiResponse<List<Spot>> get initialState => ApiResponse.none(null);

  @override
  Stream<ApiResponse<List<Spot>>> mapEventToState(SpotsEvent event) async* {
    if (event is FetchSpotsEvent) {
      yield* _mapFetchSpotsEventToState(event);
    }
    else if (event is CreateSpotsEvent) {
      throw UnimplementedError();
    }
    else {
      throw UnimplementedError();
    }
  }

  Stream<ApiResponse<List<Spot>>> _mapFetchSpotsEventToState(FetchSpotsEvent event) async* {
    yield ApiResponse.loading("fetch spot");
    try {
      final token = await this._getToken();
      final user = await this._getUser();
      final response = await SpotRepository(bearerToken: token.accessToken).fetch();
      yield ApiResponse.completed(response);
    }
    catch (error) {
      yield ApiResponse.error(error.toString());
    }
  }

  Future<Token> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString("app_token_string");
    final jsonToken = json.decode(jsonString);

    return Token.fromJson(jsonToken);
  }

  Future<User> _getUser() async {
     final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString("app_user_string");
    final jsonUser = json.decode(jsonString);

    return User.fromJson(jsonUser);
  }
}