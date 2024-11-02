part of 'auth_bloc.dart';
abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthAuthenticated extends AuthState {}

class AuthError extends AuthState {
  final String errorMessage;
  AuthError(this.errorMessage);
}


class GoogleAuthInitial extends AuthState {}

class GoogleAuthLoading extends AuthState {}

class GoogleAuthSuccess extends AuthState {
  final User? user;

  GoogleAuthSuccess(this.user);
}

class GoogleAuthFailure extends AuthState {
  final String message;

  GoogleAuthFailure({required this.message});
}