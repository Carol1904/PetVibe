import 'package:flutter/material.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  bool _notificationsEnabled = true;
  bool _biometricsEnabled = false;
  final String _selectedCurrency = 'Real (R\$)';

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF7B1FA2); // Roxo do Design System

    return Scaffold(
      backgroundColor: const Color(0xFFF8F6FA),
      appBar: AppBar(
        title: const Text(
          'Configurações',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          const Text(
            'PREFERÊNCIAS',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
              letterSpacing: 0.8,
            ),
          ),
          const SizedBox(height: 12),
          DecoratedBox(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: Column(
              children: [
                SwitchListTile(
                  title: const Text('Notificações Push', style: TextStyle(fontWeight: FontWeight.w500)),
                  subtitle: const Text('Receber alertas de transações e faturas', style: TextStyle(fontSize: 12, color: Colors.grey)),
                  value: _notificationsEnabled,
                  activeThumbColor: primaryColor,
                  onChanged: (value) {
                    setState(() {
                      _notificationsEnabled = value;
                    });
                  },
                ),
                const Divider(height: 1),
                SwitchListTile(
                  title: const Text('Bloqueio por Biometria', style: TextStyle(fontWeight: FontWeight.w500)),
                  subtitle: const Text('Exigir digital ou Face ID ao abrir', style: TextStyle(fontSize: 12, color: Colors.grey)),
                  value: _biometricsEnabled,
                  activeThumbColor: primaryColor,
                  onChanged: (value) {
                    setState(() {
                      _biometricsEnabled = value;
                    });
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'GERAL',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
              letterSpacing: 0.8,
            ),
          ),
          const SizedBox(height: 12),
          DecoratedBox(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: Column(
              children: [
                ListTile(
                  title: const Text('Moeda Principal', style: TextStyle(fontWeight: FontWeight.w500)),
                  subtitle: Text(_selectedCurrency, style: const TextStyle(fontSize: 12, color: Colors.grey)),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Moeda predefinida: Real (R\$)')),
                    );
                  },
                ),
                const Divider(height: 1),
                ListTile(
                  title: const Text('Versão da Aplicação', style: TextStyle(fontWeight: FontWeight.w500)),
                  subtitle: const Text('1.0.0 (Build 2026)', style: TextStyle(fontSize: 12, color: Colors.grey)),
                  trailing: const Icon(Icons.info_outline, size: 20, color: Colors.grey),
                  onTap: () {}, // Corrigido de onPressed para onTap
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}