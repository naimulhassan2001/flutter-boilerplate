class AuthSession {
  final String accessToken;
  final String refreshToken;
  final Map<String, dynamic> user;

  const AuthSession({
    required this.accessToken,
    required this.refreshToken,
    required this.user,
  });
}
