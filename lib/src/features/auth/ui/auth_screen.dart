import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../data/enums/auth_status.dart';
import '../data/providers/auth_provider.dart';
import 'dashboard_screen.dart';
import 'login_form.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({Key? key}) : super(key: key);
  static const route = '/auth';

  @override
  Widget build(BuildContext context) {
    return Consumer(
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
    );
  }
}
