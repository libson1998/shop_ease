part of 'login_bloc.dart';

@immutable
sealed class LoginState {}

final class LoginInitial extends LoginState {}

class LoginActionState extends LoginState {}

class GoogleAuthInitial extends LoginActionState {}

class GoogleAuthLoading extends LoginActionState {}

class GoogleAuthSuccess extends LoginActionState {
  final User? user;

  GoogleAuthSuccess(this.user);
}

class GoogleAuthFailure extends LoginActionState {
  final String message;

  GoogleAuthFailure(this.message);
}
