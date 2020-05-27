import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

abstract class LoginEvent extends Equatable {

}

class LoginUsernameChange extends LoginEvent {
  final String username;

  LoginUsernameChange({ @required this.username });

  @override
  List get props => [this.username];
}

class LoginPasswordChange extends LoginEvent {
  final String password;

  LoginPasswordChange({ @required this.password });

  @override
  List get props => [this.password];
}

class LoginSbmitted extends LoginEvent {
  final String username;
  final String password;

  LoginSbmitted({ @required this.username, @required this.password });

  @override
  List get props => [this.username, this.password];
}