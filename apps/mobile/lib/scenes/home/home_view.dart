import 'package:flutter/material.dart';
import 'home_view_model.dart';
import '../profile/profile_view.dart';
import '../new_transaction/new_transaction_view.dart';
import '../settings/settings_view.dart';

// ============================================================================
// MODELO DE DADOS (TransactionModel)
// Representa a estrutura de cada transação exibida na tela.
// ============================================================================
class TransactionModel {
  const TransactionModel({
    required this.dateHeader,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.value,
    required this.isPositive,
    required this.type,
  });

  final String dateHeader; // Cabeçalho da data (ex: QUINTA-FEIRA, 5 DE NOVEMBRO)
  final IconData icon;     // Ícone da transação (seta para cima, para baixo, etc.)
  final String title;      // Título principal (ex: Supermercado Extra)
  final String subtitle;   // Categoria e conta (ex: Alimentação · Nubank)
  final String value;      // Valor formatado (ex: -R$ 250,00)
  final bool isPositive;   // Define a cor do valor (verde para entrada, vermelho para saída)
  final String type;       // Tipo da transação para filtragem (Receita, Despesa, Transf.)
}

// ============================================================================
// WIDGET STATEFUL DA TELA INICIAL (HomeView)
// Permite gerenciar estados internos (meses selecionados, busca, filtros).
// ============================================================================
class HomeView extends StatefulWidget {
  const HomeView({super.key, required this.viewModel});
  final HomeViewModel viewModel;

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  // --------------------------------------------------------------------------
  // ESTADOS DA TELA
  // Variáveis para controlar os filtros ativos e navegação da barra inferior.
  // --------------------------------------------------------------------------
  int _selectedMonthIndex = 0;   // Índice do mês selecionado no carrossel superior
  int _selectedFilterIndex = 0;  // Índice do filtro ativo (0: Todos, 1: Receita, etc.)
  int _bottomNavIndex = 0;       // Aba selecionada na BottomNavigationBar
  String _searchQuery = '';      // Texto digitado no campo de busca

  // Lista de meses disponíveis para navegação
  final List<String> _months = const ['nov/2026', 'out/2026', 'set/2026', 'ago/2026', 'jul/2026'];
  
  // Categorias de filtros rápidos
  final List<String> _filters = const ['Todos', 'Receita', 'Despesa', 'Transf.'];

  // --------------------------------------------------------------------------
  // BASE DE DADOS SIMULADA (MOCK)
  // Mapeia o nome do mês para a sua respectiva lista de transações.
  // --------------------------------------------------------------------------
  final Map<String, List<TransactionModel>> _transactionsByMonth = const {
    'nov/2026': [
      TransactionModel(
        dateHeader: 'QUINTA-FEIRA, 5 DE NOVEMBRO',
        icon: Icons.arrow_upward,
        title: 'Supermercado Extra',
        subtitle: 'Alimentação · Nubank',
        value: '-R\$ 250,00',
        isPositive: false,
        type: 'Despesa',
      ),
      TransactionModel(
        dateHeader: 'TERÇA-FEIRA, 3 DE NOVEMBRO',
        icon: Icons.arrow_downward,
        title: 'Salário ACME',
        subtitle: 'Salário · Itaú',
        value: '+R\$ 5.000,00',
        isPositive: true,
        type: 'Receita',
      ),
    ],
    'out/2026': [
      TransactionModel(
        dateHeader: 'SEXTA-FEIRA, 30 DE OUTUBRO',
        icon: Icons.swap_horiz,
        title: 'Reserva de Emergência',
        subtitle: 'Itaú → Poupança',
        value: 'R\$ 1.000,00',
        isPositive: true,
        type: 'Transf.',
      ),
      TransactionModel(
        dateHeader: 'QUARTA-FEIRA, 28 DE OUTUBRO',
        icon: Icons.arrow_upward,
        title: 'Conta de Luz',
        subtitle: 'Moradia · Carteira',
        value: '-R\$ 180,50',
        isPositive: false,
        type: 'Despesa',
      ),
    ],
    'set/2026': [
      TransactionModel(
        dateHeader: 'DOMINGO, 27 DE SETEMBRO',
        icon: Icons.swap_horiz,
        title: 'Transferência para res...',
        subtitle: 'Itaú → Nubank',
        value: 'R\$ 1.500,00',
        isPositive: true,
        type: 'Transf.',
      ),
      TransactionModel(
        dateHeader: 'SÁBADO, 26 DE SETEMBRO',
        icon: Icons.arrow_upward,
        title: 'Plano de saúde Amil',
        subtitle: 'Saúde · Carteira',
        value: '-R\$ 480,00',
        isPositive: false,
        type: 'Despesa',
      ),
      TransactionModel(
        dateHeader: 'SEXTA-FEIRA, 25 DE SETEMBRO',
        icon: Icons.arrow_upward,
        title: 'Spotify',
        subtitle: 'Lazer · Nubank',
        value: '-R\$ 21,90',
        isPositive: false,
        type: 'Despesa',
      ),
    ],
    'ago/2026': [
      TransactionModel(
        dateHeader: 'SEGUNDA-FEIRA, 31 DE AGOSTO',
        icon: Icons.arrow_downward,
        title: 'Freelance Web',
        subtitle: 'Projetos · Nubank',
        value: '+R\$ 2.200,00',
        isPositive: true,
        type: 'Receita',
      ),
    ],
    'jul/2026': [
      TransactionModel(
        dateHeader: 'SEXTA-FEIRA, 31 DE JULHO',
        icon: Icons.arrow_upward,
        title: 'Compra Livro Flutter',
        subtitle: 'Educação · Cartão',
        value: '-R\$ 129,90',
        isPositive: false,
        type: 'Despesa',
      ),
    ],
  };

  // ==========================================================================
  // CONSTRUÇÃO DA INTERFACE (UI)
  // ==========================================================================
  @override
  Widget build(BuildContext context) {
    // Obtém o mês selecionado atualmente e busca suas transações
    final currentMonthKey = _months[_selectedMonthIndex];
    final monthTransactions = _transactionsByMonth[currentMonthKey] ?? [];

    // ------------------------------------------------------------------------
    // LÓGICA DE FILTRAGEM
    // Filtra a lista com base na palavra buscada e no chip de filtro selecionado.
    // ------------------------------------------------------------------------
    final filteredTransactions = monthTransactions.where((tx) {
      final matchesSearch = tx.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          tx.subtitle.toLowerCase().contains(_searchQuery.toLowerCase());
      
      if (_selectedFilterIndex == 1) {
        return matchesSearch && tx.type == 'Receita';
      } else if (_selectedFilterIndex == 2) {
        return matchesSearch && tx.type == 'Despesa';
      } else if (_selectedFilterIndex == 3) {
        return matchesSearch && tx.type == 'Transf.';
      }
      return matchesSearch;
    }).toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF9F6F0),
      
      // ----------------------------------------------------------------------
      // BARRA SUPERIOR (AppBar)
      // Contém o título e o ícone de configurações.
      // ----------------------------------------------------------------------
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Carteira',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1E293B),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined, color: Color(0xFF1E293B)),
            onPressed: () {
              // Navega para a tela de configurações
              Navigator.push(
                context,
                MaterialPageRoute<void>(builder: (context) => const SettingsView()),
              );
            },
          ),
        ],
      ),

      // ----------------------------------------------------------------------
      // CORPO PRINCIPAL DA TELA (Body)
      // ----------------------------------------------------------------------
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. CARROSSEL DE MESES
            SizedBox(
              height: 40,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _months.length,
                itemBuilder: (context, index) {
                  final isSelected = _selectedMonthIndex == index;
                  return Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: ChoiceChip(
                      label: Text(_months[index]),
                      selected: isSelected,
                      selectedColor: const Color(0xFF7B2CBF),
                      labelStyle: TextStyle(
                        color: isSelected ? Colors.white : const Color(0xFF334155),
                        fontWeight: FontWeight.bold,
                      ),
                      backgroundColor: Colors.white,
                      onSelected: (selected) {
                        setState(() {
                          _selectedMonthIndex = index;
                        });
                      },
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),

            // 2. CARD RESUMO FINANCEIRO (Saldo, Entradas e Saídas)
            DecoratedBox(
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
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Saldo do mês',
                          style: TextStyle(color: Colors.grey, fontSize: 14),
                        ),
                        Text(
                          _selectedMonthIndex == 0 ? 'novembro de 2026' :
                          _selectedMonthIndex == 1 ? 'outubro de 2026' :
                          _selectedMonthIndex == 2 ? 'setembro de 2026' :
                          _selectedMonthIndex == 3 ? 'agosto de 2026' : 'julho de 2026',
                          style: const TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'R\$ 4.286,41',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1E293B),
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Entradas\nR\$ 9.526,55',
                          style: TextStyle(color: Colors.green, fontSize: 13, fontWeight: FontWeight.w500),
                        ),
                        Text(
                          'Saídas\nR\$ 5.240,14',
                          style: TextStyle(color: Colors.red, fontSize: 13, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // 3. CAMPO DE PESQUISA (Search TextField)
            DecoratedBox(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    _searchQuery = value;
                  });
                },
                decoration: const InputDecoration(
                  hintText: 'Buscar por descrição',
                  hintStyle: TextStyle(color: Colors.grey),
                  prefixIcon: Icon(Icons.search, color: Colors.grey),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // 4. CHIPS DE FILTRAGEM DE CATEGORIA (Todos, Receita, Despesa, Transf.)
            SizedBox(
              height: 40,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _filters.length,
                itemBuilder: (context, index) {
                  final isSelected = _selectedFilterIndex == index;
                  return Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: ChoiceChip(
                      label: Text(_filters[index]),
                      selected: isSelected,
                      selectedColor: const Color(0xFF7B2CBF),
                      labelStyle: TextStyle(
                        color: isSelected ? Colors.white : const Color(0xFF334155),
                        fontWeight: FontWeight.w600,
                      ),
                      backgroundColor: Colors.white,
                      onSelected: (selected) {
                        setState(() {
                          _selectedFilterIndex = index;
                        });
                      },
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),

            // 5. LISTAGEM DAS TRANSAÇÕES FILTRADAS
            filteredTransactions.isEmpty
                ? const Center(
                    child: Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Text('Nenhuma transação encontrada', style: TextStyle(color: Colors.grey)),
                    ),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: filteredTransactions.length,
                    itemBuilder: (context, index) {
                      final tx = filteredTransactions[index];
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Agrupador de data (exibe apenas se a data mudar em relação ao item anterior)
                          if (index == 0 || filteredTransactions[index - 1].dateHeader != tx.dateHeader) ...[
                            if (index > 0) const SizedBox(height: 16),
                            Text(
                              tx.dateHeader,
                              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey),
                            ),
                            const SizedBox(height: 8),
                          ],
                          
                          // Card individual de transação
                          Container(
                            margin: const EdgeInsets.only(bottom: 12),
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.02),
                                  blurRadius: 4,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFF3E8FF),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Icon(tx.icon, color: const Color(0xFF7B2CBF)),
                                    ),
                                    const SizedBox(width: 12),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          tx.title,
                                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Color(0xFF1E293B)),
                                        ),
                                        const SizedBox(height: 2),
                                        Text(
                                          tx.subtitle,
                                          style: const TextStyle(color: Colors.grey, fontSize: 12),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Text(
                                  tx.value,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    color: tx.isPositive ? const Color(0xFF1E293B) : Colors.red.shade700,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  ),
          ],
        ),
      ),

      // ----------------------------------------------------------------------
      // BOTÃO FLUTUANTE DE ADICIONAR (+)
      // Navega para a tela de nova transação.
      // ----------------------------------------------------------------------
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF7B2CBF),
        child: const Icon(Icons.add, color: Colors.white),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute<void>(builder: (context) => const NewTransactionView()),
          );
        },
      ),

      // ----------------------------------------------------------------------
      // BARRA DE NAVEGAÇÃO INFERIOR (BottomNavigationBar)
      // Permite alternar entre a aba de Lançamentos e Perfil.
      // ----------------------------------------------------------------------
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _bottomNavIndex,
        selectedItemColor: const Color(0xFF7B2CBF),
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          if (index == 1) {
            // Abre a tela de Perfil ao clicar na aba correspondente
            Navigator.push(
              context,
              MaterialPageRoute<void>(builder: (context) => const ProfileView()),
            );
          } else {
            setState(() {
              _bottomNavIndex = index;
            });
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt_long),
            label: 'Lançamentos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Perfil',
          ),
        ],
      ),
    );
  }
}