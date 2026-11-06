import 'package:carteira_core/carteira_core.dart';

// ============================================================================
// CONTRATO DO SERVIÇO DE LOGIN (ServerLogin)
// Define a interface abstrata para as operações de autenticação da aplicação.
// ============================================================================
abstract interface class ServerLogin {
  Future<Result> fetchLogin({
    required String email,
    required String password,
  });
}

// ============================================================================
// SERVIDOR MOCK DE LOGIN (LoginMockServer)
// Implementação offline simulada para uso em ambiente de desenvolvimento e testes.
// ============================================================================
class LoginMockServer implements ServerLogin {
  const LoginMockServer({this.delay = const Duration(milliseconds: 2000)});
  
  // Credenciais padrão permitidas no ambiente simulado
  static const email = 'ana@carteira.dev';
  static const password = '123456';
  final Duration delay;

  @override
  Future<Result> fetchLogin({
    required String email,
    required String password,
  }) async {
    // Valida se os campos de entrada estão vazios
    if (email.isEmpty || password.isEmpty) {
      return const Failure(ValidationError({}, detail: 'Campos vazios'));
    }

    // Valida se as credenciais correspondem à conta de teste padrão
    if (email != LoginMockServer.email || password != LoginMockServer.password) {
      return const Failure(ValidationError({}, detail: 'email ou senha invalidos'));
    }

    // Retorna sucesso caso as credenciais estejam corretas
    return const Ok(true);
  }
}

// ============================================================================
// SERVIDOR REAL DE LOGIN (LoginServer)
// Implementação real que se comunica com a API oficial do backend da Carteira.
// ============================================================================
class LoginServer implements ServerLogin {
  const LoginServer();
  
  static String baseUrl = 'http://localhost:8089';

  @override
  Future<Result> fetchLogin({
    required String email,
    required String password,
  }) async {
    // Comunicação real com o backend (atualmente com retorno padrão para integração)
    return const Ok(true);
  }
}