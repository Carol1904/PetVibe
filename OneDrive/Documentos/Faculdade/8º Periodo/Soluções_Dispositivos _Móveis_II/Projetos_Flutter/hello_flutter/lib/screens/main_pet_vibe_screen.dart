import 'package:flutter/material.dart';
import '../components/text_field/text_field_factory.dart';
import '../components/text_field/text_field_widget.dart';
import '../components/text_field/text_field_view_model.dart';
import '../components/text_field/text_field_delegate.dart';
import '../components/action_button/action_button_factory.dart';
import '../components/action_button/action_button_widget.dart';
import '../components/action_button/action_button_view_model.dart';

class MainPetVibeScreen extends StatefulWidget {
  const MainPetVibeScreen({super.key});

  @override
  State<MainPetVibeScreen> createState() => _MainPetVibeScreenState();
}

class _MainPetVibeScreenState extends State<MainPetVibeScreen>
    implements TextFieldDelegate {
  late final TextFieldViewModel nomePetViewModel;
  late final TextFieldViewModel racaPetViewModel;
  late final TextFieldViewModel idadePetViewModel;
  late final ActionButtonViewModel cadastrarBotaoViewModel;

  @override
  void initState() {
    super.initState();

    nomePetViewModel = TextFieldFactory.create(
      label: 'Nome do Pet',
      hint: 'Zeus',
      delegate: this,
    );

    racaPetViewModel = TextFieldFactory.create(
      label: 'Raça',
      hint: 'Cão - Husky Siberiano',
      delegate: this,
    );

    idadePetViewModel = TextFieldFactory.create(
      label: 'Idade',
      hint: '6 anos',
      delegate: this,
    );

    cadastrarBotaoViewModel = ActionButtonFactory.createPrimary(
      text: 'Cadastrar',
      onPressed: _cadastrarPet,
    );
  }

  @override
  void onBeginEditing(TextFieldWidget widget, String text) {}

  @override
  void onEditing(TextFieldWidget widget, String text) {}

  @override
  void onEndEditing(TextFieldWidget widget, String text) {}

  @override
  void dispose() {
    nomePetViewModel.dispose();
    racaPetViewModel.dispose();
    idadePetViewModel.dispose();
    super.dispose();
  }

  void _cadastrarPet() {
    final nome = nomePetViewModel.controller.text.isNotEmpty
        ? nomePetViewModel.controller.text
        : nomePetViewModel.hint;

    final raca = racaPetViewModel.controller.text.isNotEmpty
        ? racaPetViewModel.controller.text
        : racaPetViewModel.hint;

    final idade = idadePetViewModel.controller.text.isNotEmpty
        ? idadePetViewModel.controller.text
        : idadePetViewModel.hint;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Pet $nome ($raca, $idade) cadastrado com sucesso!'),
        backgroundColor: Colors.deepPurple,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F3FF),
      appBar: AppBar(
        title: const Text('PetVibe'),
        centerTitle: true,
        backgroundColor: const Color(0xFFF3EDF7),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle_outlined, color: Colors.black87),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
        child: Column(
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.stars, color: Colors.deepPurple, size: 20),
                SizedBox(width: 8),
                Text(
                  'Cadastro',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            TextFieldWidget(viewModel: nomePetViewModel),
            const SizedBox(height: 16),

            TextFieldWidget(viewModel: racaPetViewModel),
            const SizedBox(height: 16),

            TextFieldWidget(viewModel: idadePetViewModel),
            const SizedBox(height: 28),

            ActionButtonWidget(viewModel: cadastrarBotaoViewModel),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        selectedItemColor: Colors.deepPurple,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.explore),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark_border),
            label: 'Saved',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications_none),
            label: 'Updates',
          ),
        ],
      ),
    );
  }
}