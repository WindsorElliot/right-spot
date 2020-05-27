import 'package:right_spot/model/token.dart';

class Login {
  final String username;
  final String password;
  final Token token;

  bool get isValidePassword => this.password.length >= 6;
  bool get isValideUsername => this.username.length >= 5;
  
  bool get isGoodForSubmit => this.isValidePassword && this.isValideUsername;

  Login({ this.username, this.password, this.token });

  Login copyWith({ String username, String password, token }) {
    return Login(
      username: username ?? this.username,
      password: password ?? this.password,
      token: token ?? this.token
    );
  }

  factory Login.initial() {
    return Login();
  }
}