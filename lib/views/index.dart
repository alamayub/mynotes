import 'package:flutter/material.dart';
import 'package:mynotes/services/auth/auth_service.dart';
import 'package:mynotes/views/login_view.dart';
import 'package:mynotes/views/notes/notes_view.dart';
import 'package:mynotes/views/verify_email_view.dart';

class Index extends StatelessWidget {
  const Index({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: AuthService.firebase().initialize(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            final user = AuthService.firebase().currentUser;
            if (user != null) {
              if (user.emailVerified) {
                return const NotesView();
              } else {
                return const VerifyEmailView();
              }
            } else {
              return const LoginView();
            }
          default:
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
        }
      },
    );
  }
}

// return StreamBuilder(
//             stream: FirebaseAuth.instance.authStateChanges(),
//             builder: (_, snapshot) {
//               if (snapshot.connectionState == ConnectionState.active) {
//                 if (snapshot.data != null) {
//                   return const Authenticate();
//                 } else {
//                   return const LoginScreen();
//                 }
//               }
//               return Scaffold(body: Center(child: loader()));
//             });
