import 'package:dart_week_api/controllers/login/dto/login_request.dart';
import 'package:dart_week_api/services/user_service.dart';

import '../../dart_week_api.dart';

class LoginController extends ResourceController {
  LoginController(this.context) : userService = UserService(context);

  final ManagedContext context;
  final UserService userService;
  @Operation.post()
  Future<Response> login(@Bind.body() LoginRequest request) async {
    print(request.asMap());
    final token = await userService.login(request);
    return Response.ok({'autenticado' : token != null, 'token': token});
  }
}