import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:right_spot/model/token.dart';

abstract class AppEvent extends Equatable {

}

class AppLogged extends AppEvent {
  final Token token;
  AppLogged({ @required this.token });

  @override
  List get props => [this.token];
}

class AppLogout extends AppEvent {

  @override
  List get props => [];
}

class AppLoading extends AppEvent {

  @override
  List get props => [];
}

class AppError extends AppEvent {
  final String message;

  AppError({ @required this.message });

  @override
  List get props => [this.message];
}

