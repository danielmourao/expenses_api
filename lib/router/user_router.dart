import 'package:dart_week_api/dart_week_api.dart';
import '../controllers/login/login_controller.dart';

class UsersRouter {
  static void configure(Router router, ManagedContext context){
    router.route('/login').link(() => LoginController(context));
  }
}