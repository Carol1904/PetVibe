import '../../models/user.dart';
import '../../result/result.dart';
import '../../api/api_client.dart';
import '../user_repository.dart';

class RemoteUserRepository implements UserRepository {
  RemoteUserRepository(this._client);

  final ApiClient _client;

  @override
  Future<Result<User>> getProfile() async {
    final result = await _client.get('/auth/profile');
    return result.when(
      ok: (data) => Ok(User.fromJson(data as Map<String, dynamic>)),
      failure: (error) => Failure(error),
    );
  }

  @override
  Future<Result<User>> updateProfile({String? avatarUrl, required String name}) async {
    final result = await _client.put('/auth/profile', body: {
      'name': name,
      if (avatarUrl != null) 'avatarUrl': avatarUrl,
    });
    
    return result.when(
      ok: (data) => Ok(User.fromJson(data as Map<String, dynamic>)),
      failure: (error) => Failure(error),
    );
  }
}