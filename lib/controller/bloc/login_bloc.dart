import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:right_spot/api/repository/login_repository.dart';
import 'package:right_spot/controller/event/login_event.dart';
import 'package:right_spot/controller/state/api_response.dart';
import 'package:right_spot/model/login.dart';

class LoginBloc extends Bloc<LoginEvent, ApiResponse<Login>> {
  final _loginRepository = LoginRepository();

  @override
  ApiResponse<Login> get initialState => ApiResponse.none(Login.initial());

  @override
  Stream<Transition<LoginEvent, ApiResponse<Login>>> transformEvents(Stream<LoginEvent> events, transitionFn) {
    final debounceEvents = events
      .where((event) => event is LoginUsernameChange || event is LoginPasswordChange)
      .debounceTime(Duration(milliseconds: 500))
      .distinct()
      .switchMap(transitionFn);
    final nonDebounceEvents = events
      .where((event) => event is LoginSbmitted)
      .asyncExpand(transitionFn);

    return nonDebounceEvents.mergeWith([debounceEvents]);
  }

  @override
  Stream<ApiResponse<Login>> mapEventToState(LoginEvent event) async* {
    if (event is LoginUsernameChange) {
      yield* _mapLoginUsernameChangeToState(event);
    }
    else if (event is LoginPasswordChange) {
      yield* _mapLoginPasswordChangeToState(event);
    }
    else if (event is LoginSbmitted) {
      yield* _mapLoginSbmittedToState(event);
    }
    else {
      throw UnimplementedError();
    }
  }

  Stream<ApiResponse<Login>> _mapLoginUsernameChangeToState(LoginUsernameChange event) async*{
      final currentLogin = this.state.data;
      yield ApiResponse.none(currentLogin.copyWith(username: event.username));
  }

  Stream<ApiResponse<Login>> _mapLoginPasswordChangeToState(LoginPasswordChange event) async* {
    final currentLogin = this.state.data;
    yield ApiResponse.none(currentLogin.copyWith(password: event.password));
  }

  Stream<ApiResponse<Login>> _mapLoginSbmittedToState(LoginSbmitted event) async* {
    yield ApiResponse.loading("Connection");
    try {
      final token = await this._loginRepository.getAuthToken(event.username, event.password);
      yield ApiResponse.completed(Login(username: event.username, password: event.password, token: token));
    }
    catch (error) {
      yield ApiResponse.error(error.toString());
    }
  }
}