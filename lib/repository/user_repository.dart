import 'package:dart_week_api/controllers/users/dto/save_user_request.dart';
import 'package:dart_week_api/dart_week_api.dart';
import 'package:dart_week_api/model/user_model.dart';
import 'package:dart_week_api/utils/crypt_utils.dart';

class UserRepository {
  UserRepository(this.context);

  final ManagedContext context;

  Future<UserModel> checkUserLogin(String username, String password){
    final query = Query<UserModel>(context)
    ..where((userlogin) => userlogin.username).equalTo(username)
    ..where((userlogin) => userlogin.password).equalTo(password);

    return query.fetchOne();
  }

  Future<void> saveUser(SaveUserRequest request) async {
    final userSave = UserModel()..read(request.asMap());
    userSave.password = CryptUtils.encryptPassword(request.password);

    await context.insertObject(userSave);
  }

  Future<UserModel> searchForId(int id) async {
    final query = Query<UserModel>(context)
    ..where((user) => user.id).equalTo(id);
    return await query.fetchOne();
  }
}