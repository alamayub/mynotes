import 'package:flutter/material.dart';
import 'package:mynotes/services/auth/auth_exceptions.dart';
import 'package:mynotes/services/auth/bloc/auth_bloc.dart';
import 'package:mynotes/services/auth/bloc/auth_event.dart';
import 'package:mynotes/services/auth/bloc/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mynotes/utilities/message_dialog.dart';
import 'package:mynotes/utilities/rounded_submit_button.dart';
import 'package:mynotes/utilities/text_form_field.dart';

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
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) async {
        if (state is AuthStateRegistering) {
          if (state.exception is WeakPasswordAuthException) {
            await showMessageDialog(context, 'User not found!');
          } else if (state.exception is EmailAlreadyInUseAuthException) {
            await showMessageDialog(context, 'Email is already in use!');
          } else if (state.exception is InvalidEmailAuthException) {
            await showMessageDialog(context, 'Invalid email!');
          } else if (state.exception is GenericAuthException) {
            await showMessageDialog(context, 'Failed to register!');
          }
        }
      },
      child: Scaffold(
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
                  context.read<AuthBloc>().add(AuthEventRegister(
                        email,
                        password,
                      ));
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
                      context.read<AuthBloc>().add(const AuthEventLogout());
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
      ),
    );
  }
}
