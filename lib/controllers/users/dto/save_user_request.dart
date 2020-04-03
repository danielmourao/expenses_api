
import 'package:dart_week_api/dart_week_api.dart';

class SaveUserRequest extends Serializable {

  String username;
  String password;

  @override
  Map<String, dynamic> asMap() {
    return {
      'username': username,
      'password': password
    };
  }

  @override
  void readFromMap(Map<String, dynamic> object) {
    username = object['username'] as String;
    password = object['password'] as String;
  }

  Map<String, String> validate() {
    final Map<String, String> mapValidate = {};
    if(username == null || username.isEmpty) {
      mapValidate['username'] = 'Nome de usuário obrigatório.';
    }
    if(password == null || password.isEmpty) {
      mapValidate['password'] = 'Senha de usuário obrigatória.';
    }    

    return mapValidate;
  }
}