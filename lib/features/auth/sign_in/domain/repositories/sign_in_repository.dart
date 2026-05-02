import '../entities/auth_session.dart';

abstract class SignInRepository {
  Future<AuthSession> signIn({
    required String email,
    required String password,
  });
}
