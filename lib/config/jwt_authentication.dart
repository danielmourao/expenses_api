import 'package:dart_week_api/services/user_service.dart';
import 'package:dart_week_api/utils/jwt_utils.dart';
import 'package:jaguar_jwt/jaguar_jwt.dart';

import '../dart_week_api.dart';

class JwtAuth extends Controller {

  JwtAuth(this.context) : service = UserService(context);
  final ManagedContext context;
  final UserService service;

  @override
  FutureOr<RequestOrResponse> handle(Request request) async {
    final authHeader = request.raw.headers['authorization'];
    if(authHeader == null || authHeader.isEmpty) {
      return Response.unauthorized(body: {'message': 'Usuário não autorizado'});
    }
    final authHeaderContent = authHeader[0]?.split(" ");
    if (authHeaderContent.length != 2 || authHeaderContent[0] != 'Bearer') {
      return Response.badRequest(body: {'message': 'token inválido'});
    }

    try {
      final token = authHeaderContent[1];

      final JwtClaim claimSet = JwtUtils.verifyToken(token);
      final userId = int.tryParse(claimSet.toJson()['sub'].toString());

      if(userId == null) {
        throw JwtException;
      }

      final actualDate = DateTime.now().toUtc();
      if(actualDate.isAfter(claimSet.expiry)){
        return Response.unauthorized(body: {'message': 'data expirada'});
      }

      final user = await service.searchForId(userId);
      request.attachments['user'] = user;
      return request;

    } on JwtException catch(e) {
      print(e);
      return Response.unauthorized(body: {'message': 'Usuário não autorizado'});
    }
  }
}