import 'package:dart_week_api/model/user_model.dart';
import 'package:jaguar_jwt/jaguar_jwt.dart';

class JwtUtils {
  static const String _jwtPrivateKey = '14b5cc1f2283528355fa32474ebec6a024d6c46c0e9992ae35643d2e025855c8';
  static String GenerateTokenJwt (UserModel user){
    final claimSet = JwtClaim(
      issuer: 'http://localhost',
      subject: user.id.toString(),
      otherClaims: <String,dynamic>{},
      maxAge: const Duration(days:1)
    );

    final token = 'Bearer ${issueJwtHS256(claimSet, _jwtPrivateKey)}';

    return token;
  }

  static JwtClaim verifyToken(String token) {
    return verifyJwtHS256Signature(token, _jwtPrivateKey);
  }

}