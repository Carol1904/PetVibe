import '../../models/page.dart';
import '../../models/summary.dart';
import '../../models/transaction.dart';
import '../../models/transaction_filter.dart';
import '../../result/app_error.dart';
import '../../result/result.dart';
import '../../api/api_client.dart';
import '../transaction_repository.dart';

class RemoteTransactionRepository implements TransactionRepository {
  RemoteTransactionRepository(this._client);

  final ApiClient _client;

  @override
  Future<Result<Page<Transaction>>> list(TransactionFilter filter) async {
    final Map<String, String> queryParams = {
      if (filter.type != null) 'type': filter.type.toString().split('.').last,
    };

    final result = await _client.get('/transactions', query: queryParams);

    return result.when(
      ok: (data) {
        if (data is Map<String, dynamic>) {
          final page = Page<Transaction>.fromJson(
            data,
            (json) => Transaction.fromJson(json as Map<String, dynamic>),
          );
          return Ok(page);
        }
        return Failure(UnknownError('Invalid response format'));
      },
      failure: (error) => Failure(error),
    );
  }

  @override
  Future<Result<Transaction>> getById(String id) async {
    final result = await _client.get('/transactions/$id');
    return result.when(
      ok: (data) => Ok(Transaction.fromJson(data as Map<String, dynamic>)),
      failure: (error) => Failure(error),
    );
  }

  @override
  Future<Result<Transaction>> create(Transaction transaction) async {
    final result = await _client.post('/transactions', body: transaction.toJson());
    return result.when(
      ok: (data) => Ok(Transaction.fromJson(data as Map<String, dynamic>)),
      failure: (error) => Failure(error),
    );
  }

  @override
  Future<Result<Transaction>> update(Transaction transaction) async {
    final result = await _client.put('/transactions/${transaction.id}', body: transaction.toJson());
    return result.when(
      ok: (data) => Ok(Transaction.fromJson(data as Map<String, dynamic>)),
      failure: (error) => Failure(error),
    );
  }

  @override
  Future<Result<void>> delete(String id) async {
    final result = await _client.delete('/transactions/$id');
    return result.when(
      ok: (_) => const Ok(null),
      failure: (error) => Failure(error),
    );
  }

  @override
  Future<Result<Summary>> summary(String month) async {
    final result = await _client.get('/transactions/summary', query: {'month': month});
    return result.when(
      ok: (data) => Ok(Summary.fromJson(data as Map<String, dynamic>)),
      failure: (error) => Failure(error),
    );
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