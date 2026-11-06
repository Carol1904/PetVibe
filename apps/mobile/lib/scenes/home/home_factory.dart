import 'package:flutter/material.dart';
import 'home_coordinator.dart';
import 'home_view.dart';
import 'home_view_model.dart';

// ============================================================================
// FÁBRICA DA CENA HOME (HomeFactory)
// Responsável por instanciar e conectar todas as dependências da tela principal
// seguindo o padrão arquitetural (View, ViewModel e Coordinator).
// ============================================================================
class HomeFactory {
  static Widget makeHomeScene() {
    // Instancia o coordenador responsável pela navegação desta cena
    const coordinator = DefaultHomeCoordinator();
    
    // Instancia o ViewModel injetando o coordenador criado
    final viewModel = HomeViewModel(coordinator: coordinator);
    
    // Retorna a View principal injetando o ViewModel com os estados e lógica
    return HomeView(viewModel: viewModel);
  }
}