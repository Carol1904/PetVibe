import 'package:flutter/material.dart';
import '../components/action_button/action_button_factory.dart';
import '../components/action_button/action_button_widget.dart';

class SampleActionButtonScreen extends StatelessWidget {
  const SampleActionButtonScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final buttonViewModel = ActionButtonFactory.createPrimary(
      text: 'Exemplo Botão',
      onPressed: () {},
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Sample Action Button')),
      body: Center(
        child: ActionButtonWidget(viewModel: buttonViewModel),
      ),
    );
  }
}