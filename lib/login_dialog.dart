import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginDialog extends StatelessWidget {
  final AuthService authService;

  const LoginDialog({
    Key key,
    this.authService = AuthService.login,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    final errorNotifier = ValueNotifier<String>('');
    final authNotifier = ValueNotifier<AuthService>(authService);
    return ValueListenableBuilder<AuthService>(
      valueListenable: authNotifier,
      builder: (_, authValue, __) {
        return Dialog(
          child: Container(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(authValue == AuthService.login ? 'Login' : 'Sign Up'),
                SizedBox(
                  height: 10,
                ),
                // Email field
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(labelText: 'Email'),
                ),
                SizedBox(
                  height: 10,
                ),
                // Password field
                TextField(
                  controller: passwordController,
                  decoration: InputDecoration(labelText: 'Password'),
                  obscureText: true,
                ),
                SizedBox(
                  height: 30,
                ),
                SizedBox(
                  width: double.infinity,
                  child: FlatButton(
                    child: Text(
                      authValue == AuthService.login ? 'Login' : 'Sign Up',
                      style: TextStyle(color: Colors.white),
                    ),
                    color: Colors.blueAccent,
                    onPressed: () => handleLoginAuth(
                      errorNotifier: errorNotifier,
                      context: context,
                      emailController: emailController,
                      passwordController: passwordController,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () {
                      authNotifier.value = authValue.index.isOdd
                          ? AuthService.login
                          : AuthService.signup;
                    },
                    child: Text(
                      authValue == AuthService.login
                          ? 'Don\'t have an account? Sign up.'
                          : 'Have an account? Login.',
                    ),
                  ),
                ),
                SizedBox(height: 10),
                ValueListenableBuilder<String>(
                  valueListenable: errorNotifier,
                  builder: (context, value, child) {
                    if (value.isEmpty) return SizedBox();
                    return Provider<String>.value(
                      value: value,
                      child: TextError(),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class TextError extends StatelessWidget {
  const TextError({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final value = Provider.of<String>(context);
    return Text(value);
  }
}

void handleLoginAuth({
  @required TextEditingController passwordController,
  @required TextEditingController emailController,
  @required BuildContext context,
  @required ValueNotifier<String> errorNotifier,
}) {
  final email = emailController.text;
  final password = passwordController.text;
  if (email.isEmpty || password.isEmpty) {
    errorNotifier..value = 'Please fill in the empty fields';
    return;
  }
  FirebaseAuth.instance
      .signInWithEmailAndPassword(
        email: email,
        password: password,
      )
      .then((_) => Navigator.of(context).pop())
      .catchError((error) {
    return errorNotifier.value = error.message;
  });
}

enum AuthService { login, signup }
