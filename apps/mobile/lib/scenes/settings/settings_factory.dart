import 'package:flutter/material.dart';
import 'settings_view.dart';

// ============================================================================
// FÁBRICA DA CENA DE CONFIGURAÇÕES (SettingsFactory)
// Responsável por instanciar e retornar a tela de configurações do aplicativo.
// ============================================================================
class SettingsFactory {
  static Widget create() {
    return const SettingsView();
  }
}