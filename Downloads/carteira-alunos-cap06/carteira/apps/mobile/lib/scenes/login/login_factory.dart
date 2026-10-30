import 'package:flutter/material.dart';
import 'login_coordinator.dart';
import 'login_view.dart';
import 'login_view_model.dart';
import 'server_login.dart';

class LoginFactory {
  static Widget create() => makeLoginScene();

  static Widget makeLoginScene() {
    const coordinator = DefaultLoginCoordinator();
    final serverLogin = LoginMockServer();
    final viewModel = LoginViewModel(
      serverLogin: serverLogin,
      coordinator: coordinator,
    );
    return LoginView(viewModel: viewModel);
  }
}