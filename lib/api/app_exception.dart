class AppException implements Exception {
  final _message;
  final _prefix;

  AppException([this._message, this._prefix]);

  String toString() {
    return "$_prefix$_message";
  }
}

class FetchDataException extends AppException {
  FetchDataException([String message])
      : super(message, "Error During Communication: ");
}

class PostDataExeption extends AppException {
  PostDataExeption([String message])
    : super(message, "Error During Communication: ");
}

class PutDataExeption extends AppException {
  PutDataExeption([String message])
    : super(message, "Error During Communication: ");
}

class DeleteDataExeption extends AppException {
  DeleteDataExeption([String message])
    : super(message, "Error During Communication: ");
}

class BadRequestException extends AppException {
  BadRequestException([message]) : super(message, "Invalid Request: ");
}

class UnauthorisedException extends AppException {
  UnauthorisedException([message]) : super(message, "Unauthorised: ");
}

class InvalidInputException extends AppException {
  InvalidInputException([String message]) : super(message, "Invalid Input: ");
}