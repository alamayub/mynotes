import 'package:flutter/material.dart';
import 'package:mynotes/constans/routes.dart';
import 'package:mynotes/screens/login_screen.dart';
import 'package:mynotes/screens/mynotes.dart';
import 'package:mynotes/screens/register_screen.dart';
import 'package:mynotes/screens/verify_email_screen.dart';
import 'dart:developer' as console show log;

void main() {
  console.log('app initialized successfully!');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Notes',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyNotes(),
      routes: {
        loginRoute: (context) => const LoginScreen(),
        registerRoute: (context) => const RegisterScreen(),
        verifyEmail: (context) => const VerifyEmailScreen(),
        notes: (context) => const MyNotes()
      },
    );
  }
}
