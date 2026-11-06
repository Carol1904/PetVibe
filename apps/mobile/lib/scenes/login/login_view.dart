import 'package:carteira_design_system/carteira_design_system.dart';
import 'package:flutter/material.dart';
import '../home/home_factory.dart';
import 'login_view_model.dart';

// ============================================================================
// CLASSE DA TELA DE LOGIN (LoginView)
// Widget com estado responsável por renderizar a interface de autenticação.
// ============================================================================
class LoginView extends StatefulWidget {
  const LoginView({required this.viewModel, super.key});

  final LoginViewModel viewModel;

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  // Cores padronizadas utilizadas nesta tela específica
  static const primaryPurple = Color(0xFF7F3DFF);
  static const lightPurpleBg = Color(0xFFEEE5FF);
  static const darkPurpleText = Color(0xFF1E0E38);

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: ColoredBox(
        color: const Color(0xFFFBF8FF),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 400),
                // Ouve as alterações do ViewModel para reatividade da tela
                child: AnimatedBuilder(
                  animation: widget.viewModel,
                  builder: (context, _) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Ícone / Logo do App
                        Center(
                          child: Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              color: lightPurpleBg,
                              borderRadius: BorderRadius.circular(AppRadius.lg),
                            ),
                            child: const Icon(
                              Icons.account_balance_wallet_rounded,
                              size: 40,
                              color: primaryPurple,
                            ),
                          ),
                        ),
                        const Gap.lg(),

                        // Título e Subtítulo
                        const Text(
                          'Entrar',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: darkPurpleText,
                          ),
                        ),
                        const Gap.xs(),
                        const Text(
                          'Acesse sua carteira digital',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                        const Gap.xl(),

                        // Campo de Entrada: E-mail
                        TextField(
                          controller: widget.viewModel.emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            labelText: 'E-mail',
                            hintText: 'ana@carteira.dev',
                            prefixIcon: const Icon(Icons.email_outlined, color: primaryPurple),
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(AppRadius.md),
                              borderSide: const BorderSide(color: lightPurpleBg),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(AppRadius.md),
                              borderSide: const BorderSide(color: lightPurpleBg),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(AppRadius.md),
                              borderSide: const BorderSide(color: primaryPurple),
                            ),
                          ),
                        ),
                        const Gap.md(),

                        // Campo de Entrada: Senha
                        TextField(
                          controller: widget.viewModel.passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: 'Senha',
                            prefixIcon: const Icon(Icons.lock_outline, color: primaryPurple),
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(AppRadius.md),
                              borderSide: const BorderSide(color: lightPurpleBg),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(AppRadius.md),
                              borderSide: const BorderSide(color: lightPurpleBg),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(AppRadius.md),
                              borderSide: const BorderSide(color: primaryPurple),
                            ),
                          ),
                        ),
                        const Gap.lg(),

                        // Botão de Entrar e Lógica de Autenticação/Navegação
                        SizedBox(
                          height: 50,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: primaryPurple,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(AppRadius.md),
                              ),
                              elevation: 0,
                            ),
                            onPressed: widget.viewModel.isLoading
                                ? null // Desativa o botão enquanto carrega
                                : () async {
                                    // Executa a validação de login no ViewModel
                                    final success = await widget.viewModel.login();
                                    
                                    // Se bem-sucedido, redireciona para a Home
                                    if (success && context.mounted) {
                                      Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                          builder: (_) => HomeFactory.makeHomeScene(),
                                        ),
                                      );
                                    } else if (context.mounted) {
                                      // Exibe mensagem de erro caso falhe
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                          content: Text('Credenciais inválidas ou erro no login.'),
                                          backgroundColor: Colors.red,
                                        ),
                                      );
                                    }
                                  },
                            child: widget.viewModel.isLoading
                                ? const SizedBox(
                                    width: 24,
                                    height: 24,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 2,
                                    ),
                                  )
                                : const Text(
                                    'Entrar',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}