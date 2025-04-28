import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:new_untitled/services/storage/storage_services.dart';
import 'package:new_untitled/utils/log/error_log.dart';

class TokenServices {
  static Map<String, dynamic>? decodedToken;

  static bool get isLogIn => myEmail.isNotEmpty;

  static String get myNames => _getDecodedToken()['fullName'] ?? "";

  static String get myEmail => _getDecodedToken()['email'] ?? "";

  static String get myUserId => _getDecodedToken()['userId'] ?? "";

  static String get myRole => _getDecodedToken()['role'] ?? "";

  static bool isTokenExpired() {
    try {
      bool value = JwtDecoder.isExpired(LocalStorage.token);
      return value;
    } catch (e) {
      errorLog(e, source: "Token Service");
      return false;
    }
  }

  static Map<String, dynamic> _getDecodedToken() {
    try {
      decodedToken ??= JwtDecoder.decode(LocalStorage.token);
      return decodedToken!;
    } catch (e) {
      errorLog(e, source: "Token Service");
      return {};
    }
  }
}
