import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:right_spot/api/repository/login_repository.dart';
import 'package:right_spot/api/repository/user_repository.dart';
import 'package:right_spot/controller/event/app_event.dart';
import 'package:right_spot/controller/state/app_state.dart';
import 'package:right_spot/model/token.dart';
import 'package:right_spot/model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppBloc extends Bloc<AppEvent, AppState<User>> {

  final LoginRepository _loginRepository = LoginRepository();

  AppBloc() {
    this.add(AppLoading());
  }

  @override
  AppState<User> get initialState => AppState.loading("connection ...");

  @override
  Stream<AppState<User>> mapEventToState(AppEvent event) async* {
    if (event is AppLoading) {
      yield* _appLoadingToState(event);
    }
    else if (event is AppLogged) {
      yield* _appLoggedToState(event);
    }
    else if (event is AppLogout) {
      yield* _appLogoutToState(event);
    }
    else if (event is AppError) {
      yield* _appErrorToState(event);
    }
    else {
      throw UnimplementedError();
    }
  }

  Stream<AppState<User>> _appLoadingToState(AppLoading event) async* {
    yield AppState.loading("checkin user ...");

    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonString = prefs.getString("app_user_string");
      if (null == jsonString) {
        yield AppState.notLogged();
      }
      else {
        final jsonUser = json.decode(jsonString);
        final user = User.fromJson(jsonUser);
        final currentTimestamp = DateTime.now().millisecondsSinceEpoch;
        if (currentTimestamp + (user.token.expiresIn * 1000) >= (user.token.createdTimestamp + (user.token.expiresIn * 1000))) {
          user.token = await this._loginRepository.getAuthTokenWithRefresh(user.token.refreshToken);
          await this._saveToken(user.token);
          await this._saveUser(user);
        }
        yield AppState.logged(user);
      }
    }
    catch (error) {
      yield AppState.error(error.toString());
    }
  }

  Stream<AppState<User>> _appLoggedToState(AppLogged event) async* {
    try {
      await this._saveToken(event.token);
      final user = await UserRepository(bearerToken: event.token.accessToken).getCurrentUser();
      user.token = event.token;  
      await this._saveUser(user);
      yield AppState.logged(user);
    }
    catch (error) {
      yield AppState.error(error.toString());
    }
  }

  Stream<AppState<User>> _appLogoutToState(AppLogout event) async * {
    try {
      if (this.state is AppLogged) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString("app_token_string", null);
      }
      yield AppState.notLogged();
    }
    catch (error) {
      yield AppState.error(error.toString());
    }
  }

  Stream<AppState<User>> _appErrorToState(AppError event) async* {
    yield AppState.error(event.message);
  }

  Future<void> _saveUser(User user) async {
    final jsonString = json.encode(user.toJsonWithToken());
    final prefs = await SharedPreferences.getInstance();
    bool success = await prefs.setString("app_user_string", jsonString);
    if (false == success) {
      throw ErrorDescription("unable to save User Localy");
    }
    return;
  }

  Future<void> _saveToken(Token token) async {
    final jsonString = json.encode(token.toJson());
    final prefs = await SharedPreferences.getInstance();
    bool success = await prefs.setString("app_token_string", jsonString);
    if (false == success) {
      throw ErrorDescription("unable to save Token Localy");
    }
    return;
  }

}