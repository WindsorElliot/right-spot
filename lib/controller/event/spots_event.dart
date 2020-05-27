import 'package:equatable/equatable.dart';

abstract class SpotsEvent extends Equatable {

}

class FetchSpotsEvent extends SpotsEvent {
  
  @override
  List get props => [];
}

class CreateSpotsEvent extends SpotsEvent {

  @override
  List get props => [];
}

