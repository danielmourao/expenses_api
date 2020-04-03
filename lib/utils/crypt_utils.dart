import 'dart:convert';
import 'package:crypto/crypto.dart';

class CryptUtils {
  static String encryptPassword(String password) {
    final passBytes = utf8.encode(password);
    return sha256.convert(passBytes).toString();    
  }
}