import '../../domain/entities/auth_session.dart';

class AuthSessionModel extends AuthSession {
  const AuthSessionModel({
    required super.accessToken,
    required super.refreshToken,
    required super.user,
  });

  factory AuthSessionModel.fromJson(Map<String, dynamic>? json) {
    final data = json ?? {};
    return AuthSessionModel(
      accessToken: data['accessToken'] ?? '',
      refreshToken: data['refreshToken'] ?? '',
      user: data['user'] ?? {},
    );
  }
}
