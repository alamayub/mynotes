import 'package:flutter/material.dart';
import 'package:mynotes/constans/routes.dart';
import '../utilities/rounded_submit_button.dart';
import '../utilities/text_form_field.dart';
import 'dart:developer' as console show log;

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('Register'),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormInputField(
              controller: _email,
              hint: 'mynotes@mynotes.com',
              textInputType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 12),
            TextFormInputField(
              controller: _password,
              hint: '******',
              obscure: true,
              textInputType: TextInputType.visiblePassword,
            ),
            const SizedBox(height: 12),
            RoundedSubmitButton(
              text: 'Register',
              function: () => {
                console.log('login clicked'),
              },
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text('Already have account? '),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      loginRoute,
                      (route) => false,
                    );
                  },
                  child: const Text(
                    'Login',
                    style: TextStyle(decoration: TextDecoration.underline),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
