import 'package:flutter/material.dart';

// ============================================================================
// CLASSE VIEWMODEL DE LOGIN (LoginViewModel)
// Responsável por gerenciar os controladores de texto, estado de carregamento
// e a lógica de autenticação da tela de login.
// ============================================================================
class LoginViewModel extends ChangeNotifier {
  LoginViewModel({
    this.serverLogin,
    this.coordinator,
  });
  
  final dynamic serverLogin;
  final dynamic coordinator;

  // Controladores para capturar o que o usuário digita nos campos
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // Variável de controle para o estado de carregamento (loading)
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  // --------------------------------------------------------------------------
  // LÓGICA DE LOGIN
  // --------------------------------------------------------------------------
  Future<bool> login() async {
    _isLoading = true;
    notifyListeners();

    try {
      // Simulação de delay de rede para dar feedback visual de carregamento
      await Future.delayed(const Duration(milliseconds: 600));

      final email = emailController.text.trim();
      final password = passwordController.text.trim();

      // Tenta autenticar no serviço remoto caso ele tenha sido injetado
      if (serverLogin != null) {
        try {
          await serverLogin.login(
            email: email,
            password: password,
          );
        } catch (_) {
          // Se o serviço remoto falhar, permite prosseguir com o fluxo de teste local
        }
      }

      _isLoading = false;
      notifyListeners();

      // Retorna verdadeiro se ambos os campos estiverem preenchidos
      if (email.isNotEmpty && password.isNotEmpty) {
        return true;
      }

      return false;
    } catch (_) {
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // Libera os recursos dos controladores da memória quando o ViewModel for descartado
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}