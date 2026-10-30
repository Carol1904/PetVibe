import 'package:flutter_test/flutter_test.dart';
import 'package:carteira_app/scenes/home/home_view_model.dart';

void main() {
  group('HomeViewModel Tests', () {
    late HomeViewModel viewModel;

    setUp(() {
      viewModel = HomeViewModel();
    });

    test('Estado inicial correto', () {
      expect(viewModel.isLoading, isFalse);
      expect(viewModel.selectedFilter, equals('Todos'));
      expect(viewModel.selectedMonth, equals('set/2026'));
      expect(viewModel.searchQuery, isEmpty);
      expect(viewModel.filteredTransactions.length, equals(5));
    });

    test('Deve alterar o filtro de lançamentos e filtrar a lista', () {
      viewModel.selectFilter('Receita');
      expect(viewModel.selectedFilter, equals('Receita'));
      expect(viewModel.filteredTransactions.length, equals(1));
      expect(viewModel.filteredTransactions.first['title'], equals('Freelance site institucional'));

      viewModel.selectFilter('Despesa');
      expect(viewModel.selectedFilter, equals('Despesa'));
      expect(viewModel.filteredTransactions.length, equals(3));
    });

    test('Deve filtrar lançamentos por busca de descrição', () {
      viewModel.updateSearchQuery('Spotify');
      expect(viewModel.searchQuery, equals('Spotify'));
      expect(viewModel.filteredTransactions.length, equals(1));
      expect(viewModel.filteredTransactions.first['title'], equals('Spotify'));
    });

    test('Deve alterar o mês selecionado', () {
      viewModel.selectMonth('out/2026');
      expect(viewModel.selectedMonth, equals('out/2026'));
    });

    test('Deve notificar carregamento no loadData', () async {
      final future = viewModel.loadData();
      expect(viewModel.isLoading, isTrue);

      await future;
      expect(viewModel.isLoading, isFalse);
    });
  });
}