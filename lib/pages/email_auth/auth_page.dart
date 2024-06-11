import 'package:flutter/material.dart';
import 'package:to_do_app/pages/email_auth/email_login_or_register_page.dart';

class Auth extends StatelessWidget {
  const Auth({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'T O  D O',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.yellow[600],
      ),
      backgroundColor: Colors.yellow[200],
      body: const LoginOrRegister(),
    );
  }
}
