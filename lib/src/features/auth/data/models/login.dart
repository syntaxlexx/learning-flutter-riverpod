class Login {
  final String? email;
  final String? password;

  const Login({
    this.email,
    this.password,
  });

  Login copyWith({
    String? email,
    String? password,
  }) {
    return Login(
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }
}
