import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:right_spot/api/repository/login_repository.dart';
import 'package:right_spot/controller/event/app_event.dart';
import 'package:right_spot/controller/state/app_state.dart';
import 'package:right_spot/model/token.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppBloc extends Bloc<AppEvent, AppState<Token>> {

  final LoginRepository _loginRepository = LoginRepository();

  AppBloc() {
    this.add(AppLoading());
  }

  @override
  AppState<Token> get initialState => AppState.loading("connection ...");

  @override
  Stream<AppState<Token>> mapEventToState(AppEvent event) async* {
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

  Stream<AppState<Token>> _appLoadingToState(AppLoading event) async* {
    yield AppState.loading("checkin user ...");

    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonString = prefs.getString("app_token_string");
      if (null == jsonString) {
        yield AppState.notLogged();
      }
      else {
        final jsonToken = json.decode(jsonString);
        final token = Token.fromJson(jsonToken);
        final currentTimestamp = DateTime.now().millisecondsSinceEpoch;
        if (currentTimestamp + (token.expiresIn * 1000) >= (token.createdTimestamp + (token.expiresIn * 1000))) {
          final newToken = await this._loginRepository.getAuthTokenWithRefresh(token.refreshToken);
          await this._saveToken(newToken);
          yield AppState.logged(newToken);
        }
        else {
          yield AppState.logged(token);
        }
      }
    }
    catch (error) {
      yield AppState.error(error.toString());
    }
  }

  Stream<AppState<Token>> _appLoggedToState(AppLogged event) async* {
    try {
      await this._saveToken(event.token);
      yield AppState.logged(event.token);
    }
    catch (error) {
      yield AppState.error(error.toString());
    }
  }

  Stream<AppState<Token>> _appLogoutToState(AppLogout event) async * {
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

  Stream<AppState<Token>> _appErrorToState(AppError event) async* {
    yield AppState.error(event.message);
  }

  Future<void> _saveToken(Token token) async {
    final jsonString = json.encode(token.toJson());
    final prefs = await SharedPreferences.getInstance();
    bool success = await prefs.setString("app_token_string", jsonString);
    if (false == success) {
      throw UnimplementedError();
    }
    return;
  }

}