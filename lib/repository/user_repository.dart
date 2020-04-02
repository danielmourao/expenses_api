import 'package:dart_week_api/dart_week_api.dart';
import 'package:dart_week_api/model/user_model.dart';

class UserRepository {
  UserRepository(this.context);

  final ManagedContext context;

  Future<UserModel> checkUserLogin(String username, String password){
    final query = Query<UserModel>(context)
    ..where((userlogin) => userlogin.username).equalTo(username)
    ..where((userlogin) => userlogin.password).equalTo(password);

    return query.fetchOne();
  }
}