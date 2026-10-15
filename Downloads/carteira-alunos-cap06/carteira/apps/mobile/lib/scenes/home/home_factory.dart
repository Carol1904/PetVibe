import 'package:flutter/material.dart';
import 'home_coordinator.dart';
import 'home_view.dart';
import 'home_view_model.dart';

class HomeFactory {
  static Widget makeHomeScene() {
    const coordinator = DefaultHomeCoordinator();
    final viewModel = HomeViewModel(coordinator: coordinator);
    return HomeView(viewModel: viewModel);
  }
}