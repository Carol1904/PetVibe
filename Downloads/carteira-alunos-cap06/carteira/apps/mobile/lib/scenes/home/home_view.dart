import 'package:carteira_design_system/carteira_design_system.dart';
import 'package:flutter/material.dart';
import '../login/login_factory.dart';
import 'home_view_model.dart';

class HomeView extends StatefulWidget {
  const HomeView({required this.viewModel, super.key});

  final HomeViewModel viewModel;

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _currentBottomTab = 0;

  // Paleta oficial de Roxo / Lilás do Design System
  static const primaryPurple = Color(0xFF7F3DFF);
  static const lightPurpleBg = Color(0xFFEEE5FF);
  static const darkPurpleText = Color(0xFF1E0E38);
  static const surfaceBg = Color(0xFFFBF8FF);

  @override
  void initState() {
    super.initState();
    widget.viewModel.loadData();
  }

  void _showNewTransactionModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(AppRadius.lg)),
      ),
      builder: (ctx) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(ctx).viewInsets.bottom + AppSpacing.lg,
          top: AppSpacing.lg,
          left: AppSpacing.lg,
          right: AppSpacing.lg,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Novo Lançamento',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: darkPurpleText),
                ),
                IconButton(
                  icon: const Icon(Icons.close, color: darkPurpleText),
                  onPressed: () => Navigator.of(ctx).pop(),
                ),
              ],
            ),
            const Gap.md(),
            TextField(
              decoration: InputDecoration(
                labelText: 'Descrição',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(AppRadius.md)),
              ),
            ),
            const Gap.sm(),
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Valor (R\$)',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(AppRadius.md)),
              ),
            ),
            const Gap.lg(),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryPurple,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppRadius.md)),
              ),
              onPressed: () {
                Navigator.of(ctx).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Lançamento adicionado com sucesso!')),
                );
              },
              child: const Text('Salvar'),
            ),
          ],
        ),
      ),
    );
  }

@override
  Widget build(BuildContext context) {
    return AppScaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          widget.viewModel.onAddNewTransaction();
          _showNewTransactionModal(context);
        },
        backgroundColor: primaryPurple,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.md),
        ),
        child: const Icon(Icons.add, size: 28),
      ),
      body: Container(
        color: surfaceBg,
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: AnimatedBuilder(
                  animation: widget.viewModel,
                  builder: (context, _) {
                    if (widget.viewModel.isLoading) {
                      return const Center(
                        child: CircularProgressIndicator(color: primaryPurple),
                      );
                    }

                    return Center(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 1000),
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.all(AppSpacing.lg),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              _buildHeader(context),
                              const Gap.md(),
                              _buildMonthSelector(context),
                              const Gap.md(),
                              _buildBalanceCard(context),
                              const Gap.lg(),
                              _buildCategorySection(context),
                              const Gap.xl(),
                              _buildSearchField(context),
                              const Gap.md(),
                              _buildFilterSegmentedControl(context),
                              const Gap.md(),
                              ..._buildTransactionList(context),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              NavigationBar(
                selectedIndex: _currentBottomTab,
                backgroundColor: Colors.white,
                onDestinationSelected: (index) {
                  setState(() {
                    _currentBottomTab = index;
                  });
                  if (index == 1) {
                    widget.viewModel.onOpenProfile();
                  }
                },
                indicatorColor: lightPurpleBg,
                destinations: const [
                  NavigationDestination(
                    icon: Icon(Icons.receipt_long_outlined, color: Colors.grey),
                    selectedIcon: Icon(Icons.receipt_long, color: primaryPurple),
                    label: 'Lançamentos',
                  ),
                  NavigationDestination(
                    icon: Icon(Icons.person_outline, color: Colors.grey),
                    selectedIcon: Icon(Icons.person, color: primaryPurple),
                    label: 'Perfil',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Olá, Ana 👋', style: TextStyle(fontSize: 14, color: Colors.grey)),
            Text('Carteira', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: darkPurpleText)),
          ],
        ),
        Row(
          children: [
            IconButton(
              icon: const Icon(Icons.person_outline, color: darkPurpleText),
              tooltip: 'Perfil',
              onPressed: () => widget.viewModel.onOpenProfile(),
            ),
            IconButton(
              icon: const Icon(Icons.settings_outlined, color: darkPurpleText),
              tooltip: 'Configurações',
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.logout_rounded, color: darkPurpleText),
              tooltip: 'Sair',
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (_) => LoginFactory.makeLoginScene()),
                );
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildMonthSelector(BuildContext context) {
    final vm = widget.viewModel;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: vm.months.map((month) {
          final isSelected = vm.selectedMonth == month;
          return Padding(
            padding: const EdgeInsets.only(right: AppSpacing.xs),
            child: ChoiceChip(
              showCheckmark: false,
              label: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (isSelected) const Icon(Icons.check, size: 16, color: Colors.white),
                  if (isSelected) const SizedBox(width: 4),
                  Text(month),
                ],
              ),
              selected: isSelected,
              selectedColor: primaryPurple,
              backgroundColor: lightPurpleBg,
              labelStyle: TextStyle(
                color: isSelected ? Colors.white : darkPurpleText,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                fontSize: 13,
              ),
              side: BorderSide(
                color: isSelected ? primaryPurple : lightPurpleBg,
              ),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppRadius.sm)),
              onSelected: (selected) {
                if (selected) vm.selectMonth(month);
              },
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildBalanceCard(BuildContext context) {
    final vm = widget.viewModel;

    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: lightPurpleBg),
        borderRadius: BorderRadius.circular(AppRadius.md),
        boxShadow: [
          BoxShadow(
            color: primaryPurple.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Saldo do mês', style: TextStyle(color: Colors.grey, fontSize: 14)),
              Text(
                vm.selectedMonth == 'set/2026' ? 'setembro de 2026' : vm.selectedMonth,
                style: const TextStyle(color: Colors.grey, fontSize: 12),
              ),
            ],
          ),
          const Gap.xs(),
          const Text('R\$ 4.286,41', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: darkPurpleText)),
          const Gap.md(),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Entradas', style: TextStyle(color: Colors.grey, fontSize: 12)),
                  Text('+ R\$ 9.526,55', style: TextStyle(color: Color(0xFF00A86B), fontWeight: FontWeight.bold)),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text('Saídas', style: TextStyle(color: Colors.grey, fontSize: 12)),
                  Text('- R\$ 5.240,14', style: TextStyle(color: Color(0xFFFD3C4A), fontWeight: FontWeight.bold)),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCategorySection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'POR CATEGORIA',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: AppSpacing.xs),
        ...widget.viewModel.categories.map((c) => Padding(
              padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(c['name'], style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: darkPurpleText)),
                      Row(
                        children: [
                          Text(c['amount'], style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: darkPurpleText)),
                          const SizedBox(width: AppSpacing.sm),
                          SizedBox(
                            width: 32,
                            child: Text(
                              '${c['pct']}%',
                              textAlign: TextAlign.end,
                              style: const TextStyle(fontSize: 12, color: Colors.grey),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(AppRadius.sm),
                    child: LinearProgressIndicator(
                      value: c['val'],
                      minHeight: 4,
                      backgroundColor: lightPurpleBg,
                      valueColor: const AlwaysStoppedAnimation<Color>(primaryPurple),
                    ),
                  ),
                ],
              ),
            )),
      ],
    );
  }

  Widget _buildSearchField(BuildContext context) {
    return TextField(
      onChanged: widget.viewModel.updateSearchQuery,
      decoration: InputDecoration(
        hintText: 'Buscar por descrição',
        hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
        prefixIcon: const Icon(Icons.search, color: primaryPurple),
        contentPadding: const EdgeInsets.symmetric(vertical: 14),
        filled: true,
        fillColor: Colors.white,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.md),
          borderSide: const BorderSide(color: lightPurpleBg),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.md),
          borderSide: const BorderSide(color: primaryPurple),
        ),
      ),
    );
  }

  Widget _buildFilterSegmentedControl(BuildContext context) {
    final vm = widget.viewModel;

    return Container(
      decoration: BoxDecoration(
        color: lightPurpleBg.withOpacity(0.5),
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: lightPurpleBg),
      ),
      child: Row(
        children: List.generate(vm.filters.length * 2 - 1, (index) {
          if (index.isOdd) {
            return Container(width: 1, height: 40, color: lightPurpleBg);
          }
          final filterName = vm.filters[index ~/ 2];
          final isSelected = vm.selectedFilter == filterName;
          return Expanded(
            child: InkWell(
              onTap: () => vm.selectFilter(filterName),
              borderRadius: BorderRadius.circular(AppRadius.md),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
                decoration: BoxDecoration(
                  color: isSelected ? primaryPurple : Colors.transparent,
                  borderRadius: BorderRadius.circular(AppRadius.md),
                ),
                child: Text(
                  filterName,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                    color: isSelected ? Colors.white : darkPurpleText,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  List<Widget> _buildTransactionList(BuildContext context) {
    final list = widget.viewModel.filteredTransactions;

    if (list.isEmpty) {
      return [
        const Padding(
          padding: EdgeInsets.symmetric(vertical: AppSpacing.xl),
          child: Center(
            child: Text(
              'Nenhum lançamento encontrado neste período.',
              style: TextStyle(color: Colors.grey, fontSize: 14),
            ),
          ),
        )
      ];
    }

    return list.expand((t) => [
      Padding(
        padding: const EdgeInsets.only(top: AppSpacing.md, bottom: AppSpacing.xs),
        child: Text(
          (t['date'] as String).toUpperCase(),
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.8,
            color: Colors.grey,
          ),
        ),
      ),
      ListTile(
        contentPadding: EdgeInsets.zero,
        leading: Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(color: t['bgColor'], borderRadius: BorderRadius.circular(AppRadius.md)),
          child: Icon(t['icon'], color: t['color'], size: 20),
        ),
        title: Text(t['title'], style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: darkPurpleText)),
        subtitle: Text(t['sub'], style: const TextStyle(fontSize: 13, color: Colors.grey)),
        trailing: Text(t['amount'], style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: t['color'])),
      ),
    ]).toList();
  }
}