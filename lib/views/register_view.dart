import 'package:flutter/material.dart';
import 'package:mynotes/constans/routes.dart';
import '../services/auth/auth_exceptions.dart';
import '../services/auth/auth_service.dart';
import '../utilities/message_dialog.dart';
import '../utilities/rounded_submit_button.dart';
import '../utilities/text_form_field.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
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
              function: () async {
                final email = _email.text.trim();
                final password = _password.text.trim();
                try {
                  await AuthService.firebase().createUser(
                    email: email,
                    password: password,
                  );
                  final user = AuthService.firebase().currentUser;
                  if (user?.emailVerified ?? false) {
                    // ignore: use_build_context_synchronously
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      notesRoute,
                      (route) => false,
                    );
                  } else {
                    // ignore: use_build_context_synchronously
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      verifyEmailRoute,
                      (route) => false,
                    );
                  }
                } on WeakPasswordAuthException {
                  await showMessageDialog(context, 'Please use a strong password!');
                } on EmailAlreadyInUseAuthException {
                  await showMessageDialog(context, 'This email is already used by another account!');
                } on InvalidEmailAuthException {
                  await showMessageDialog(context, 'Invalid email!');
                } on GenericAuthException {
                  await showMessageDialog(context, 'Authentication Error!');
                }
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
