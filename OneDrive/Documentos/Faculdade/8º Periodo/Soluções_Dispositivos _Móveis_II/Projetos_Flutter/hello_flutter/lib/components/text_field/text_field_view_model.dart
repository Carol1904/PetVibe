import 'package:flutter/material.dart';
import 'text_field_delegate.dart';

class TextFieldViewModel {
  final String label;
  final String hint;
  final TextEditingController controller;
  TextFieldDelegate? delegate;

  TextFieldViewModel({
    required this.label,
    required this.hint,
    TextEditingController? controller,
    this.delegate,
  }) : controller = controller ?? TextEditingController();

  void updateText(String text) {
    if (delegate != null) {
      // Notificação opcional via delegate
    }
  }

  void dispose() {
    controller.dispose();
  }
}