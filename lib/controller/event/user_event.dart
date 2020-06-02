import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:right_spot/model/user.dart';

abstract class UserEvent extends Equatable {}

class GetCurrentUserEvent extends UserEvent {
  
  @override
  List get props => [];
}

class UpdateCurrentUserEvent extends UserEvent {
  final User userUpdated;

  UpdateCurrentUserEvent({ @required this.userUpdated });

  @override
  List get props => [this.userUpdated];
}

