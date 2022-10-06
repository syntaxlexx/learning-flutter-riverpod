import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../../utils/contants.dart';
import '../enums/auth_status.dart';
import '../exceptions/login_exception.dart';
import '../models/auth_state.dart';
import '../models/user.dart';
import '../repositories/auth_repository.dart';

final authNotifierProvider =
    StateNotifierProvider<AuthStateNotifier, AuthState>((ref) {
  final repo = ref.watch(authRepositoryProvider);
  return AuthStateNotifier(repo);
});

class AuthStateNotifier extends StateNotifier<AuthState> {
  final AuthRepository _repo;

  AuthStateNotifier(this._repo, [AuthState? state])
      : super(state ?? AuthState.initial()) {
    checkAuthStatus();
  }

  Future<void> checkAuthStatus() async {
    // check storage for existing token/user
    final box = Hive.box(Constants.authStorageKey);
    final token = box.get('token');
    final user = box.get('user');

    // if authenticated, update state accordingly
    if ((token != null && token.toString().isNotEmpty) &&
        (user != null && user.toString().isNotEmpty)) {
      state = state.copyWith(
        status: AuthStatus.authenticated,
        user: User.fromJson(user.toString()),
        accessToken: token.toString(),
      );

      return;
    }
    state = state.copyWith(
      status: AuthStatus.unauthenticated,
    );
  }

  Future<void> login({required String email, required String password}) async {
    try {
      state = state.copyWith(
        loading: true,
        errorMessage: '',
      );

      final token = await _repo.login(email: email, password: password);

      final user = User(email: email, name: email.split('@').first);

      final box = Hive.box(Constants.authStorageKey);
      await box.put('token', token);
      await box.put('user', user.toJson());

      state = state.copyWith(
        accessToken: token,
        user: user,
        status: AuthStatus.authenticated,
        errorMessage: '',
      );
    } on DioError catch (e) {
      final exc = LoginException.fromDioError(e);
      state = state.copyWith(
        errorMessage: exc.message,
      );
    } catch (e) {
      state = state.copyWith(
        errorMessage: e.toString(),
      );
    } finally {
      state = state.copyWith(
        loading: false,
      );
    }
  }

  Future<void> logout() async {
    state = state.copyWith(
      loading: true,
      errorMessage: '',
    );

    // do some API stuff
    await Future.delayed(const Duration(milliseconds: 300));

    final box = Hive.box(Constants.authStorageKey);
    await box.delete('token');
    await box.delete('user');

    state = state.copyWith(
      user: null,
      accessToken: null,
      status: AuthStatus.unauthenticated,
      loading: false,
    );
  }
}
