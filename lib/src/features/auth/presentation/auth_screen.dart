import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:validators/validators.dart';

import '../data/enums/auth_status.dart';
import 'dashboard_screen.dart';
import 'auth_screen_controller.dart';
import 'login_form.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({Key? key}) : super(key: key);
  static const route = '/auth';

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Consumer(
        builder: (context, ref, child) {
          final authStatus =
              ref.watch(authNotifierProvider.select((value) => value.status));

          return Container(
            child: authStatus == AuthStatus.unauthenticated
                ? const LoginForm()
                : authStatus == AuthStatus.authenticated
                    ? const DashboardScreen()
                    : const Center(
                        child: CircularProgressIndicator(),
                      ),
          );
        },
      ),
    );
  }
}
