import 'package:right_spot/api/app_exception.dart';

abstract class BaseModel {

  BaseModel.fromJson(Map<String, dynamic> json);

  Map<String, dynamic> toJson();

  String entityName();
}

class ConvertExeption extends AppException {
  ConvertExeption([String message])
    : super(message, "Error decode JSON");
}