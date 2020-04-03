import 'package:dart_week_api/controllers/users/dto/save_user_request.dart';
import 'package:dart_week_api/model/user_model.dart';
import 'package:dart_week_api/utils/crypt_utils.dart';

import 'package:dart_week_api/controllers/login/dto/login_request.dart';
import 'package:dart_week_api/dart_week_api.dart';
import 'package:dart_week_api/repository/user_repository.dart';
import 'package:dart_week_api/utils/jwt_utils.dart';

class UserService {
  UserService(this.context) : userRepository = UserRepository(context);

  final ManagedContext context;
  final UserRepository userRepository;

  Future<String> login(LoginRequest request) async {
    final String username = request.username;
    final String password = request.password;
    final String passCrypt = CryptUtils.encryptPassword(password);
    //print(passCrypt);
    final user = await userRepository.checkUserLogin(username, passCrypt);

    if(user != null) {
      return JwtUtils.GenerateTokenJwt(user);
    }

    return null;
  }

  Future<void> saveUser(SaveUserRequest request) async {
    await userRepository.saveUser(request);
  }

  Future<UserModel> searchForId(int id) async {
    return await userRepository.searchForId(id);
  }
}