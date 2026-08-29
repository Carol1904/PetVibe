import 'package:flutter/material.dart';
import '../components/text_field/text_field_factory.dart';
import '../components/text_field/text_field_widget.dart';

class SampleTextFieldScreen extends StatelessWidget {
  const SampleTextFieldScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textFieldViewModel = TextFieldFactory.create(
      label: 'Campo de Teste',
      hint: 'Digite algo...',
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Sample Text Field')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: TextFieldWidget(viewModel: textFieldViewModel),
      ),
    );
  }
}