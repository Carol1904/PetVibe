import 'package:flutter/material.dart';

abstract class HomeCoordinator {
  void logout(BuildContext context);
}

class DefaultHomeCoordinator implements HomeCoordinator {
  const DefaultHomeCoordinator();

  @override
  void logout(BuildContext context) {
    Navigator.of(context).pop();
  }
}