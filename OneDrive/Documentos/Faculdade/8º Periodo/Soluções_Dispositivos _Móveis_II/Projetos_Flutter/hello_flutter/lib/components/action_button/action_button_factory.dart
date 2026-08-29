import 'package:flutter/material.dart';
import 'action_button_view_model.dart';

class ActionButtonFactory {
  static ActionButtonViewModel createPrimary({
    required String text,
    required VoidCallback onPressed,
    IconData? icon,
  }) {
    return ActionButtonViewModel(
      text: text,
      onPressed: onPressed,
      icon: icon ?? Icons.stars,
      backgroundColor: const Color(0xFFE8DEF8),
      foregroundColor: const Color(0xFF1D192B),
    );
  }
}