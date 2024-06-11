import 'package:flutter/material.dart';

class LoginForm extends StatelessWidget {
  final void Function()? togglePages;
  const LoginForm({super.key, required this.togglePages});

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // login page heading
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Center(
                  child: Text('Login Page',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 30,
                          fontWeight: FontWeight.bold))),
            ),
            // profileIcon
            const Icon(
              Icons.person,
              size: 120,
            ),

            // username input field
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: TextField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                    label: Text('Email'),
                    labelStyle: TextStyle(fontSize: 18),
                    isDense: true,
                    contentPadding: EdgeInsets.all(15.0),
                    floatingLabelBehavior: FloatingLabelBehavior.auto,
                    floatingLabelStyle: TextStyle(
                        fontFamily: 'roboto',
                        fontSize: 20,
                        fontWeight: FontWeight.w600),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      borderSide:
                          BorderSide(width: 3, style: BorderStyle.solid),
                      gapPadding: 10.0,
                    )),
              ),
            ),

            // password input field
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: TextField(
                obscureText: true,
                keyboardType: TextInputType.visiblePassword,
                controller: passwordController,
                decoration: const InputDecoration(
                    label: Text('Password'),
                    labelStyle: TextStyle(fontSize: 18),
                    isDense: true,
                    contentPadding: EdgeInsets.all(15.0),
                    floatingLabelBehavior: FloatingLabelBehavior.auto,
                    floatingLabelStyle: TextStyle(
                        fontFamily: 'roboto',
                        fontSize: 20,
                        fontWeight: FontWeight.w600),
                    suffixIcon: Icon(
                      Icons.remove_red_eye_rounded,
                      size: 20,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      borderSide:
                          BorderSide(width: 3, style: BorderStyle.solid),
                      gapPadding: 5.0,
                    )),
              ),
            ),

            // Submit button
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                  child: ElevatedButton(
                      onPressed: () {
                        print(
                            'Email: ${emailController.text}. Password: ${passwordController.text}');
                      },
                      style: ButtonStyle(
                          backgroundColor:
                              WidgetStateProperty.all(Colors.lightBlue)),
                      child: const Text(
                        'Submit',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ))),
            ),
            // forgot password?
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Center(
                  child: Text(
                'Forgot Password?',
                style: TextStyle(color: Colors.grey, fontSize: 15),
              )),
            ),

            // Don't have an account? sign up.
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Don\'t have an account?',
                    style: TextStyle(color: Colors.grey, fontSize: 15),
                  ),
                  const SizedBox(
                    width: 7,
                  ),
                  GestureDetector(
                    onTap: togglePages,
                    child: const Text(
                      'Login',
                      style: TextStyle(color: Colors.blue, fontSize: 15),
                    ),
                  ),
                ],
              )),
            )
          ],
        ),
      ),
    );
  }
}
