import '../entities/auth_session.dart';
import '../repositories/sign_in_repository.dart';

class SignInUseCase {
  final SignInRepository _repository;

  SignInUseCase(this._repository);

  Future<AuthSession> call({
    required String email,
    required String password,
  }) {
    return _repository.signIn(email: email, password: password);
  }
}
