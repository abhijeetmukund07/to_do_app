import 'package:flutter/material.dart';
import 'package:to_do_app/pages/email_auth/email_login_form.dart';
import 'package:to_do_app/pages/email_auth/email_signup_form.dart';

class LoginOrRegister extends StatefulWidget {
  const LoginOrRegister({super.key});

  @override
  State<LoginOrRegister> createState() => _LoginOrRegisterState();
}

class _LoginOrRegisterState extends State<LoginOrRegister> {
  bool showLoginPage = true;
  void togglePages() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      return LoginForm(
        togglePages: togglePages,
      );
    } else {
      return SignUpForm(
        togglePages: togglePages,
      );
    }
  }
}
