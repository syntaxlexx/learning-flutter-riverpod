// ignore_for_file: public_member_api_docs, sort_constructors_first
import '../enums/auth_status.dart';
import 'user.dart';

class AuthState {
  final String? accessToken;
  final User? user;
  final AuthStatus status;
  final String? errorMessage;
  final bool loading;

  bool get hasError => errorMessage != null && errorMessage!.isNotEmpty;

  AuthState({
    this.accessToken,
    this.user,
    this.status = AuthStatus.unauthenticated,
    this.errorMessage,
    this.loading = false,
  });

  AuthState copyWith({
    String? accessToken,
    User? user,
    AuthStatus? status,
    String? errorMessage,
    bool? loading,
  }) {
    return AuthState(
      accessToken: accessToken ?? this.accessToken,
      user: user ?? this.user,
      status: status ?? this.status,
      loading: loading ?? this.loading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  factory AuthState.initial() {
    return AuthState(
      status: AuthStatus.unauthenticated,
      user: null,
      accessToken: null,
      errorMessage: null,
      loading: false,
    );
  }

  @override
  String toString() =>
      'status $status accessToken $accessToken user ${user.toString()} ';
}
