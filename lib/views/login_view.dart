import 'package:flutter/material.dart';
import 'package:mynotes/services/auth/auth_exceptions.dart';
import 'package:mynotes/services/auth/bloc/auth_bloc.dart';
import 'package:mynotes/services/auth/bloc/auth_event.dart';
import 'package:mynotes/services/auth/bloc/auth_state.dart';
import 'package:mynotes/utilities/dialog/loading_dialog.dart';
import 'package:mynotes/utilities/message_dialog.dart';
import 'package:mynotes/utilities/rounded_submit_button.dart';
import 'package:mynotes/utilities/text_form_field.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final TextEditingController _email;
  late final TextEditingController _password;
  CloseDialog? _closeDialogHandle;

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
        if (state is AuthStateLoggedOut) {
          final closeDialog = _closeDialogHandle;
          if (!state.isLoading && closeDialog != null) {
            closeDialog();
            _closeDialogHandle = null;
          } else if (state.isLoading && closeDialog == null) {
            _closeDialogHandle = showLoadingDialog(
              context: context,
              text: 'Loading...',
            );
          }

          if (state.exception is UserNotFoundAuthException) {
            await showMessageDialog(context, 'User not found!');
          } else if (state.exception is WrongPasswordAuthException) {
            await showMessageDialog(context, 'Wrong credentials!');
          } else if (state.exception is GenericAuthException) {
            await showMessageDialog(context, 'Authentication Error!');
          }
        }
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: const Text('Login'),
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
                text: 'Login',
                function: () async {
                  final email = _email.text.trim();
                  final password = _password.text.trim();
                  context.read<AuthBloc>().add(AuthEventLogin(email, password));
                },
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text('Don\'t have account? '),
                  GestureDetector(
                    onTap: () {
                      context.read<AuthBloc>().add(
                            const AuthEventShouldRegister(),
                          );
                    },
                    child: const Text(
                      'Create One',
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
