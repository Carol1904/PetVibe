import 'package:flutter/material.dart';
import 'login_coordinator.dart';
import 'login_view.dart';
import 'login_view_model.dart';
import 'server_login.dart';

// ============================================================================
// FÁBRICA DA CENA DE LOGIN (LoginFactory)
// Responsável por instanciar, configurar e injetar as dependências (coordinator,
// servidor de mock e viewModel) necessárias para montar a tela de login.
// ============================================================================
class LoginFactory {
  // Atalho estático para compatibilidade com outros pontos de chamada
  static Widget create() => makeLoginScene();

  static Widget makeLoginScene() {
    // Instancia o coordenador responsável pela navegação a partir do login
    const coordinator = DefaultLoginCoordinator();
    
    // Instancia o serviço de mock responsável por simular o backend de autenticação
    const serverLogin = LoginMockServer();
    
    // Instancia o ViewModel injetando tanto o mock de login quanto o coordenador
    final viewModel = LoginViewModel(
      serverLogin: serverLogin,
      coordinator: coordinator,
    );
    
    // Retorna a View de login com o seu respectivo ViewModel configurado
    return LoginView(viewModel: viewModel);
  }
}