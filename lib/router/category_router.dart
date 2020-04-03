import 'package:dart_week_api/dart_week_api.dart';
import 'package:dart_week_api/config/jwt_authentication.dart';
import 'package:dart_week_api/controllers/category/category_controller.dart';

class CategoryRouter {
  static void configure(Router router, ManagedContext context) {
    router.route('/categories/:type')
    .link(() => JwtAuth(context)).link(() => CategoryController(context));
  }
}