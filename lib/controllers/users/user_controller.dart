import 'package:dart_week_api/services/user_service.dart';
import './dto/save_user_request.dart';

import '../../dart_week_api.dart';

class UserController extends ResourceController {

  UserController(this.context) : userService = UserService(context);

  final UserService userService;
  final ManagedContext context;

  @Operation.post()
  Future<Response> saveuser(@Bind.body() SaveUserRequest request) async {
    final validate = request.validate();

    if(validate.isNotEmpty) {
      return Response.badRequest(body: validate);
    }

    try {
      await userService.saveUser(request);
      return Response.ok({'message': 'Usuário cadastrado com sucesso.'});
    }catch(e) {
      print(e);
      return Response.serverError(body: {'message': 'Erro ao salvar usuário.', 'exception': e.toString()});
    }
  }

}