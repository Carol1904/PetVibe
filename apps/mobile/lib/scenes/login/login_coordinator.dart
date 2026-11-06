import 'package:flutter/material.dart';
import '../home/home_factory.dart';

// ============================================================================
// CONTRATO DO COORDENADOR DE LOGIN (LoginCoordinator)
// Define as rotas e navegações disponíveis a partir da tela de login.
// ============================================================================
abstract class LoginCoordinator {
  void navigateToHome(BuildContext context);
}

// ============================================================================
// IMPLEMENTAÇÃO PADRÃO DO COORDENADOR (DefaultLoginCoordinator)
// Realiza a navegação real entre cenas (substituindo a tela atual pela Home).
// ============================================================================
class DefaultLoginCoordinator implements LoginCoordinator {
  const DefaultLoginCoordinator();

  @override
  void navigateToHome(BuildContext context) {
    // Substitui a tela de login atual pela cena principal (Home) para que o usuário
    // não consiga voltar para o login usando o botão de voltar do dispositivo.
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => HomeFactory.makeHomeScene(),
      ),
    );
  }
}