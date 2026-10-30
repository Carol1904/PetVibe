import '../../models/page.dart';
import '../../models/summary.dart';
import '../../models/transaction.dart';
import '../../models/transaction_filter.dart';
import '../../result/app_error.dart';
import '../../result/result.dart';
import '../transaction_repository.dart';

class InMemoryTransactionRepository implements TransactionRepository {
  InMemoryTransactionRepository({List<Transaction>? initialTransactions})
      : _transactions = initialTransactions ?? [];

  final List<Transaction> _transactions;

  @override
  Future<Result<Page<Transaction>>> list(TransactionFilter filter) async {
    List<Transaction> result = List.from(_transactions);

    final filterType = filter.type;
    if (filterType != null) {
      result = result.where((t) => t.type == filterType).toList();
    }

    final page = Page<Transaction>(
      items: result,
      total: result.length,
      page: 1,
      pageSize: result.isEmpty ? 1 : result.length,
    );

    return Ok(page);
  }

  @override
  Future<Result<Transaction>> getById(String id) async {
    try {
      final transaction = _transactions.firstWhere((t) => t.id == id);
      return Ok(transaction);
    } catch (_) {
      return Failure(const UnknownError('Transaction not found'));
    }
  }

  @override
  Future<Result<Transaction>> create(Transaction transaction) async {
    _transactions.add(transaction);
    return Ok(transaction);
  }

  @override
  Future<Result<Transaction>> update(Transaction transaction) async {
    final index = _transactions.indexWhere((t) => t.id == transaction.id);
    if (index >= 0) {
      _transactions[index] = transaction;
      return Ok(transaction);
    }
    return Failure(const UnknownError('Transaction not found'));
  }

  @override
  Future<Result<void>> delete(String id) async {
    _transactions.removeWhere((t) => t.id == id);
    return Ok(null);
  }

  @override
  Future<Result<Summary>> summary(String month) async {
    List<Transaction> result = List.from(_transactions);

    double income = 0;
    double expense = 0;

    for (final t in result) {
      if (t.type.toString().contains('income')) {
        income += t.amount;
      } else {
        expense += t.amount;
      }
    }

    final summaryData = Summary(
      month: month,
      income: income,
      expense: expense,
    );

    return Ok(summaryData);
  }

  @override
  Stream<List<Transaction>> watch() async* {
    final res = await list(TransactionFilter());
    if (res is Ok<Page<Transaction>>) {
      yield res.value.items;
    } else {
      yield [];
    }
  }
}