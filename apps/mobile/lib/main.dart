import 'package:carteira_design_system/carteira_design_system.dart';
import 'package:flutter/material.dart';
import 'scenes/login/login_factory.dart';

// ============================================================================
// PONTO DE ENTRADA DO APLICATIVO (main)
// Função principal que inicia a execução da aplicação Flutter.
// ============================================================================
void main() {
  runApp(const MyApp());
}

// ============================================================================
// WIDGET RAIZ (MyApp)
// Configura as propriedades globais do aplicativo, como título, temas e rota inicial.
// ============================================================================
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Carteira',                  // Nome exibido pelo sistema operacional
      debugShowCheckedModeBanner: false,  // Remove a faixa de "Debug" do canto da tela
      theme: AppTheme.light(),            // Define o tema claro padrão do Design System
      darkTheme: AppTheme.dark(),         // Define o tema escuro do Design System
      themeMode: ThemeMode.light,         // Força o aplicativo a usar o modo claro
      home: LoginFactory.makeLoginScene(),// Define a tela inicial chamando a fábrica de login
    );
  }
}