import 'package:flutter/material.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F6F0),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF1E293B)),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Configurações',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1E293B),
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          ListTile(
            leading: const Icon(Icons.notifications_outlined, color: Color(0xFF7B2CBF)),
            title: const Text('Notificações'),
            subtitle: const Text('Gerenciar alertas e avisos'),
            trailing: Switch(
              value: true,
              activeColor: const Color(0xFF7B2CBF),
              onChanged: (val) {},
            ),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.lock_outline, color: Color(0xFF7B2CBF)),
            title: const Text('Privacidade e Segurança'),
            subtitle: const Text('Senha e biometria'),
            onTap: () {},
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.palette_outlined, color: Color(0xFF7B2CBF)),
            title: const Text('Tema do Aplicativo'),
            subtitle: const Text('Roxo e Lilás padrão'),
            onTap: () {},
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.info_outline, color: Color(0xFF7B2CBF)),
            title: const Text('Sobre o Aplicativo'),
            subtitle: const Text('Versão 1.0.0'),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}