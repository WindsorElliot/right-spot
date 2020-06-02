import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:right_spot/api/repository/user_repository.dart';
import 'package:right_spot/controller/event/user_event.dart';
import 'package:right_spot/controller/state/api_response.dart';
import 'package:right_spot/model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserBloc extends Bloc<UserEvent, ApiResponse<User>> {

  UserBloc() {
    this.add(GetCurrentUserEvent());
  }

  @override
  ApiResponse<User> get initialState => ApiResponse.none(null);

  @override
  Stream<ApiResponse<User>> mapEventToState(UserEvent event) async* {
    if (event is GetCurrentUserEvent) {
      yield* _mapGetCurrentUserEventToState(event);
    }
    else if (event is UpdateCurrentUserEvent) {
      yield* _mapUpdateCurrentUserEventToState(event);
    }
    else {
      throw UnimplementedError();
    }
  }

  Stream<ApiResponse<User>> _mapGetCurrentUserEventToState(GetCurrentUserEvent event) async* {
    yield ApiResponse.loading("chargement de l'utilisateur");
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonString = prefs.getString("app_user_string");
      final jsonUser = json.decode(jsonString);
      final user = User.fromJson(jsonUser);

      print("success get saved user");

      yield ApiResponse.completed(user);
    }
    catch (error) {
      print(error.toString());
      yield ApiResponse.error(error.toString());
    }
  }

  Stream<ApiResponse> _mapUpdateCurrentUserEventToState(UpdateCurrentUserEvent event) async* {
    try {
      final updatedUser = UserRepository(bearerToken: event.userUpdated.token.accessToken).update(event.userUpdated.id, event.userUpdated);
      yield ApiResponse.completed(updatedUser);
    }
    catch (error) {
      print(error.toString());
      yield ApiResponse.error(error.toString());
    }
  }
  
}