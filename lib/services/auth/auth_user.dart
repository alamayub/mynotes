import 'package:firebase_auth/firebase_auth.dart' show User;
import 'package:flutter/cupertino.dart';

@immutable
class AuthUser {
  final String uid;
  final String? name;
  final String? email;
  final bool emailVerified;
  const AuthUser({
    required this.uid,
    required this.name,
    required this.email,
    required this.emailVerified,
  });

  factory AuthUser.fromFirebase(User user) => AuthUser(
        uid: user.uid,
        name: user.displayName,
        email: user.email,
        emailVerified: user.emailVerified,
      );
}
