import 'package:flutter/material.dart';
import 'profile_view.dart';

// ============================================================================
// FÁBRICA DA CENA DE PERFIL (ProfileFactory)
// Responsável por instanciar e retornar a tela de perfil do usuário.
// ============================================================================
class ProfileFactory {
  static Widget create() {
    return const ProfileView();
  }
}