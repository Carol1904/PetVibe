import 'user.dart';

class Session {
  final String token;
  final User user;

  const Session({required this.token, required this.user});

  factory Session.fromJson(Map<String, dynamic> json) {
    return Session(
      token: json['token'] as String? ?? '',
      user: User.fromJson(json['user'] as Map<String, dynamic>),
    );
  }

  Session copyWith({
    String? token,
    User? user,
  }) {
    return Session(
      token: token ?? this.token,
      user: user ?? this.user,
    );
  }
}