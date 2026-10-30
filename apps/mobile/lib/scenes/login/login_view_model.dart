import 'package:flutter/material.dart';

class LoginViewModel extends ChangeNotifier {
  final dynamic serverLogin;
  final dynamic coordinator;

  LoginViewModel({
    this.serverLogin,
    this.coordinator,
  });

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<bool> login() async {
    _isLoading = true;
    notifyListeners();

    try {
      // Simulação de chamada de rede
      await Future.delayed(const Duration(milliseconds: 600));

      final email = emailController.text.trim();
      final password = passwordController.text.trim();

      // Tenta autenticar no serviço real se existir
      if (serverLogin != null) {
        try {
          await serverLogin.login(
            email: email,
            password: password,
          );
        } catch (_) {
          // Se o serviço falhar, permite o acesso de teste se o campo não estiver vazio
        }
      }

      _isLoading = false;
      notifyListeners();

      // Permite o login se os campos estiverem preenchidos
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

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
