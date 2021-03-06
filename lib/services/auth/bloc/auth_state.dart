import 'package:flutter/cupertino.dart' show immutable;
import 'package:mynotes/services/auth/auth_user.dart';
import 'package:mynotes/services/auth/bloc/auth_event.dart';
import 'package:equatable/equatable.dart';

@immutable
abstract class AuthState {
  const AuthState();
}

class AuthStateUnitialized extends AuthState {
  const AuthStateUnitialized();
}

class AuthStateRegistering extends AuthEvent {
  final Exception? exception;
  const AuthStateRegistering(this.exception);
}

class AuthStateLoggedIn extends AuthState {
  final AuthUser user;
  const AuthStateLoggedIn(this.user);
}

class AuthStateNeedVerification extends AuthState {
  const AuthStateNeedVerification();
}

class AuthStateLoggedOut extends AuthState with EquatableMixin {
  final Exception? exception;
  final bool isLoading;
  const AuthStateLoggedOut({
    required this.exception,
    required this.isLoading,
  });

  @override
  List<Object?> get props => [exception, isLoading];
}
