import 'package:dart_week_api/dart_week_api.dart';

class LoginRequest extends Serializable {

  String username;
  String password;

  @override
  Map<String, dynamic> asMap() {
    return {
      'login': username,
      'senha': password
    };
  }

  @override
  void readFromMap(Map<String, dynamic> object) {
    username = object['username'] as String;
    password = object['password'] as String;
  }

  Map<String, String> validate() {
    final Map<String, String> validateResult = {};

    if(username == null || username.isEmpty) {
      validateResult['username'] = 'Usuário obrigatório';
    }

    if(password == null || password.isEmpty) {
      validateResult['username'] = 'Senha obrigatória';
    }

    return validateResult;
  }

}