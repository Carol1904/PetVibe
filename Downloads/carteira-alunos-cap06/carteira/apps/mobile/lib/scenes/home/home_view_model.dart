import 'package:flutter/material.dart';

class HomeViewModel extends ChangeNotifier {
  final dynamic coordinator;

  HomeViewModel({this.coordinator});

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String _selectedFilter = 'Todos';
  String get selectedFilter => _selectedFilter;

  String _selectedMonth = 'set/2026';
  String get selectedMonth => _selectedMonth;

  String _searchQuery = '';
  String get searchQuery => _searchQuery;

  final List<String> months = ['out/2026', 'set/2026', 'ago/2026', 'jul/2026'];
  final List<String> filters = ['Todos', 'Receita', 'Despesa', 'Transf.'];

  final List<Map<String, dynamic>> categories = [
    {'name': 'Moradia', 'amount': 'R\$ 3.027,16', 'pct': 58, 'val': 0.58},
    {'name': 'Saúde', 'amount': 'R\$ 883,90', 'pct': 17, 'val': 0.17},
    {'name': 'Alimentação', 'amount': 'R\$ 380,85', 'pct': 7, 'val': 0.07},
    {'name': 'Educação', 'amount': 'R\$ 304,43', 'pct': 6, 'val': 0.06},
    {'name': 'Transporte', 'amount': 'R\$ 261,72', 'pct': 5, 'val': 0.05},
  ];

  final List<Map<String, dynamic>> _allTransactions = [
    // --- SETEMBRO / 2026 ---
    {
      'monthKey': 'set/2026',
      'date': 'Domingo, 27 de setembro',
      'title': 'Mercado Pão de Açúcar',
      'sub': 'Alimentação · Nubank',
      'amount': '-R\$ 306,70',
      'type': 'Despesa',
      'icon': Icons.arrow_upward,
      'color': const Color(0xFFB35A46),
      'bgColor': const Color(0xFFF7EBE8),
    },
    {
      'monthKey': 'set/2026',
      'date': 'Sábado, 26 de setembro',
      'title': 'Plano de saúde Amil',
      'sub': 'Saúde · Carteira',
      'amount': '-R\$ 480,00',
      'type': 'Despesa',
      'icon': Icons.arrow_upward,
      'color': const Color(0xFFB35A46),
      'bgColor': const Color(0xFFF7EBE8),
    },
    {
      'monthKey': 'set/2026',
      'date': 'Sexta-feira, 25 de setembro',
      'title': 'Spotify',
      'sub': 'Lazer · Nubank',
      'amount': '-R\$ 21,90',
      'type': 'Despesa',
      'icon': Icons.arrow_upward,
      'color': const Color(0xFFB35A46),
      'bgColor': const Color(0xFFF7EBE8),
    },
    {
      'monthKey': 'set/2026',
      'date': 'Terça-feira, 22 de setembro',
      'title': 'Freelance site institucional',
      'sub': 'Outros · Nubank',
      'amount': '+R\$ 1.026,55',
      'type': 'Receita',
      'icon': Icons.arrow_downward,
      'color': const Color(0xFF2E7D32),
      'bgColor': const Color(0xFFE8F5E9),
    },
    {
      'monthKey': 'set/2026',
      'date': 'Domingo, 6 de setembro',
      'title': 'Transferência para reserva',
      'sub': 'Itaú -> Nubank',
      'amount': 'R\$ 1.500,00',
      'type': 'Transf.',
      'icon': Icons.swap_horiz,
      'color': const Color(0xFF5A626A),
      'bgColor': const Color(0xFFF1F3F5),
    },

    // --- OUTUBRO / 2026 ---
    {
      'monthKey': 'out/2026',
      'date': 'Segunda-feira, 5 de outubro',
      'title': 'Salário Empresa',
      'sub': 'Trabalho · Itaú',
      'amount': '+R\$ 6.500,00',
      'type': 'Receita',
      'icon': Icons.arrow_downward,
      'color': const Color(0xFF2E7D32),
      'bgColor': const Color(0xFFE8F5E9),
    },
    {
      'monthKey': 'out/2026',
      'date': 'Quarta-feira, 7 de outubro',
      'title': 'Aluguel do apartamento',
      'sub': 'Moradia · Itaú',
      'amount': '-R\$ 2.200,00',
      'type': 'Despesa',
      'icon': Icons.arrow_upward,
      'color': const Color(0xFFB35A46),
      'bgColor': const Color(0xFFF7EBE8),
    },

    // --- AGOSTO / 2026 ---
    {
      'monthKey': 'ago/2026',
      'date': 'Quinta-feira, 20 de agosto',
      'title': 'Supermercado Carrefour',
      'sub': 'Alimentação · Nubank',
      'amount': '-R\$ 542,10',
      'type': 'Despesa',
      'icon': Icons.arrow_upward,
      'color': const Color(0xFFB35A46),
      'bgColor': const Color(0xFFF7EBE8),
    },
  ];

  // Lógica de filtragem tripla (Mês Selecionado + Tipo de Filtro + Busca)
  List<Map<String, dynamic>> get filteredTransactions {
    return _allTransactions.where((t) {
      final matchesMonth = t['monthKey'] == _selectedMonth;
      final matchesFilter = _selectedFilter == 'Todos' || t['type'] == _selectedFilter;
      final matchesQuery = _searchQuery.isEmpty ||
          (t['title'] as String).toLowerCase().contains(_searchQuery.toLowerCase()) ||
          (t['sub'] as String).toLowerCase().contains(_searchQuery.toLowerCase());

      return matchesMonth && matchesFilter && matchesQuery;
    }).toList();
  }

  Future<void> loadData() async {
    _isLoading = true;
    notifyListeners();

    await Future.delayed(const Duration(milliseconds: 300));

    _isLoading = false;
    notifyListeners();
  }

  void selectFilter(String filter) {
    _selectedFilter = filter;
    notifyListeners();
  }

  void selectMonth(String month) {
    _selectedMonth = month;
    notifyListeners();
  }

  void updateSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  void onAddNewTransaction() {
    try {
      coordinator?.showCreateTransaction();
    } catch (_) {}
  }

  void onOpenProfile() {
    try {
      coordinator?.showProfile();
    } catch (_) {}
  }
}