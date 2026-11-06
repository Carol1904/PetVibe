import 'package:flutter/material.dart';
import '../../../scenes/login/login_factory.dart';

// ============================================================================
// PONTO DE ENTRADA ISOLADO (main)
// Permite rodar ou testar esta tela de login de forma independente.
// ============================================================================
void main() {
  runApp(const MyApp());
}

// ============================================================================
// WIDGET RAIZ LOCAL (MyApp)
// Configura um ambiente MaterialApp temporário apenas para exibir esta tela.
// ============================================================================
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Carteira Digital',            // Título do aplicativo para este contexto
      debugShowCheckedModeBanner: false,    // Remove a faixa de "Debug" do canto
      home: LoginFactory.create(),          // Instancia a cena de login através da factory
    );
  }
}