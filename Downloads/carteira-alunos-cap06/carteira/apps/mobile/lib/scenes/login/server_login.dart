import 'package:carteira_core/carteira_core.dart';

/// Authentication backend used by the login scene.
abstract interface class ServerLogin {
  Future<Result> fetchLogin({
    required String email,
    required String password,
  });
}

/// Offline [ServerLogin] for development and previews.
class LoginMockServer implements ServerLogin {
  static const email = 'ana@carteira.dev';
  static const password = '123456';
  final Duration delay;

  const LoginMockServer({this.delay = const Duration(milliseconds: 2000)});

  @override
  Future<Result> fetchLogin({
    required String email,
    required String password,
  }) async {
    if (email.isEmpty || password.isEmpty) {
      return Failure(ValidationError({}, detail: 'Campos vazios'));
    }

    if (email != LoginMockServer.email || password != LoginMockServer.password) {
      return Failure(ValidationError({}, detail: 'email ou senha invalidos'));
    }

    return const Ok(true);
  }
}

/// Real [ServerLogin], talking to the Carteira API.
class LoginServer implements ServerLogin {
  static String baseUrl = "http://localhost:8089";

  const LoginServer();

  @override
  Future<Result> fetchLogin({
    required String email,
    required String password,
  }) async {
    return const Ok(true);
  }
}