import 'dart:convert';
import 'package:crypto/crypto.dart';

import 'package:dart_week_api/controllers/login/dto/login_request.dart';
import 'package:dart_week_api/dart_week_api.dart';
import 'package:dart_week_api/repository/user_repository.dart';

class UserService {
  UserService(this.context) : userRepository = UserRepository(context);

  final ManagedContext context;
  final UserRepository userRepository;

  Future<String> login(LoginRequest request) async {
    final String username = request.username;
    final String password = request.password;
    final passBytes = utf8.encode(password);
    final String passCrypt = sha256.convert(passBytes).toString();
    //print(passCrypt);
    final user = await userRepository.checkUserLogin(username, passCrypt);

    return user?.username;
  }
}