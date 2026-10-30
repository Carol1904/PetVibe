import '../../models/session.dart';
import '../../models/user.dart';
import '../../result/result.dart';
import '../auth_repository.dart';

class InMemoryAuthRepository implements AuthRepository {
  Session? _currentSession;

  @override
  Session? get currentSession => _currentSession;

  @override
  Future< Result< Session>> login({
    required String email,
    required String password,
  }) async {
  final user = User(
      id: '1',
      name: 'Usuario Teste',
      email: email,
      createdAt: DateTime.now(),
    );

    _currentSession = Session(
      token: 'fake_token',
      user: user,
    );
    return Ok(_currentSession!);
  }

  @override
  Future< Result< void>> logout() async {
    _currentSession = null;
    return const Ok(null);
  }

  @override
  Future< Result< Session?>> restore() async {
    return Ok(_currentSession);
  }
}