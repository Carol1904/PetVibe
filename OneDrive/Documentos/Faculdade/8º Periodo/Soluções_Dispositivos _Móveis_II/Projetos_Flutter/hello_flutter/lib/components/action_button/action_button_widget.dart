import 'package:flutter/material.dart';
import 'action_button_view_model.dart';

class ActionButtonWidget extends StatelessWidget {
  final ActionButtonViewModel viewModel;

  const ActionButtonWidget({
    super.key,
    required this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 160,
      height: 44,
      child: ElevatedButton.icon(
        onPressed: viewModel.onPressed,
        icon: Icon(viewModel.icon ?? Icons.stars, size: 18),
        label: Text(viewModel.text),
        style: ElevatedButton.styleFrom(
          backgroundColor: viewModel.backgroundColor ?? const Color(0xFFE8DEF8),
          foregroundColor: viewModel.foregroundColor ?? const Color(0xFF1D192B),
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
    );
  }
}