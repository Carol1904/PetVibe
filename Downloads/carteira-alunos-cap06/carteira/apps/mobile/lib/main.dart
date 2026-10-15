import 'package:carteira_design_system/carteira_design_system.dart';
import 'package:flutter/material.dart';
import 'scenes/login/login_factory.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Carteira',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      themeMode: ThemeMode.light,
      home: LoginFactory.makeLoginScene(),
    );
  }
}