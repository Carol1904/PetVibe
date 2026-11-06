import 'package:flutter/material.dart';

// ============================================================================
// CONTRATO DO COORDENADOR DA HOME (HomeCoordinator)
// Define as regras de navegação e ações disponíveis para a tela principal.
// ============================================================================
abstract class HomeCoordinator {
  void logout(BuildContext context);
}

// ============================================================================
// IMPLEMENTAÇÃO PADRÃO DO COORDENADOR (DefaultHomeCoordinator)
// Executa de fato a lógica de navegação definida no contrato.
// ============================================================================
class DefaultHomeCoordinator implements HomeCoordinator {
  const DefaultHomeCoordinator();

  @override
  void logout(BuildContext context) {
    // Remove a tela atual da pilha de navegação, retornando à tela anterior (ex: Login)
    Navigator.of(context).pop();
  }
}