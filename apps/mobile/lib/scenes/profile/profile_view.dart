import 'package:flutter/material.dart';

// ============================================================================
// CLASSE DA TELA DE PERFIL (ProfileView)
// Widget sem estado (StatelessWidget) responsável por exibir as informações
// cadastrais do usuário, foto de perfil, opções de salvamento e botão de logout.
// ============================================================================
class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F6F0),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Perfil',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1E293B),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Avatar / Iniciais da foto de perfil
            const Center(
              child: CircleAvatar(
                radius: 50,
                backgroundColor: Color(0xFFE2D9F3),
                child: Text(
                  'AR',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF7B2CBF),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            
            // Nome do usuário em destaque
            const Text(
              'Ana Ribeiro',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1E293B),
              ),
            ),
            const SizedBox(height: 4),
            
            // E-mail associado à conta
            const Text(
              'ana@carteira.dev',
              style: TextStyle(color: Colors.grey, fontSize: 14),
            ),
            const SizedBox(height: 4),
            
            // Data de cadastro na plataforma
            const Text(
              'Na Carteira desde 11/03/2024',
              style: TextStyle(color: Colors.grey, fontSize: 12),
            ),
            const SizedBox(height: 32),
            
            // Bloco de contêiner contendo os campos de dados do perfil
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.04),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'DADOS',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey),
                  ),
                  const SizedBox(height: 12),
                  
                  // Campo somente leitura para o Nome
                  TextField(
                    readOnly: true,
                    controller: TextEditingController(text: 'Ana Ribeiro'),
                    decoration: InputDecoration(
                      labelText: 'Nome',
                      prefixIcon: const Icon(Icons.person_outline, color: Color(0xFF7B2CBF)),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                  const SizedBox(height: 16),
                  
                  // Campo somente leitura para a URL da foto
                  TextField(
                    readOnly: true,
                    controller: TextEditingController(text: 'https://github.com/anaribeiro'),
                    decoration: InputDecoration(
                      labelText: 'URL da foto',
                      prefixIcon: const Icon(Icons.image_outlined, color: Color(0xFF7B2CBF)),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            
            // Botão principal para salvar alterações
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF7B2CBF),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: () {
                  // Exibe notificação visual de sucesso ao salvar
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Alterações salvas com sucesso!')),
                  );
                },
                child: const Text('Salvar', style: TextStyle(color: Colors.white, fontSize: 16)),
              ),
            ),
            const SizedBox(height: 12),
            
            // Botão de destaque secundário para encerrar sessão (Logout)
            SizedBox(
              width: double.infinity,
              height: 50,
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.red),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: () {
                  // Fecha a tela de perfil e remove todas as telas anteriores, voltando para a rota inicial (login)
                  Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.logout, color: Colors.red),
                    SizedBox(width: 8),
                    Text('Sair da conta', style: TextStyle(color: Colors.red, fontSize: 16)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}