import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:validators/validators.dart';

import 'auth_screen_controller.dart';

class LoginForm extends StatefulHookConsumerWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginFormState();
}

class _LoginFormState extends ConsumerState<LoginForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final auth = ref.watch(authNotifierProvider);

    final emailCtr = useTextEditingController();
    final passwordCtr = useTextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Center(
              child: Text('Login to your account'),
            ),
            const SizedBox(
              height: 20,
            ),
            Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                children: [
                  TextFormField(
                    controller: emailCtr,
                    keyboardType: TextInputType.emailAddress,
                    autofocus: true,
                    validator: (value) {
                      return isEmail(value.toString())
                          ? null
                          : 'Provide a valid email';
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    controller: passwordCtr,
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: true,
                    validator: (value) {
                      return isLength(value.toString(), 4)
                          ? null
                          : 'Provide a valid password of more than 4 characters';
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          final email = emailCtr.text;
                          final password = passwordCtr.text;
                          ref
                              .read(authNotifierProvider.notifier)
                              .login(email: email, password: password);
                        }
                      },
                      child: Text(auth.loading ? 'Authenticating' : 'Login'),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  auth.hasError
                      ? Column(
                          children: [
                            Container(
                              color: Colors.red.shade300,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 12, horizontal: 20),
                              child: SizedBox(
                                width: double.infinity,
                                child: Text(
                                  '${auth.errorMessage}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(
                                        color: Colors.white,
                                      ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                          ],
                        )
                      : Container(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
