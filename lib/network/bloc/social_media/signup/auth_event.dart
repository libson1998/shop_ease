part of 'auth_bloc.dart';

abstract class AuthEvent {}

class EmailPasswordLoginRequested extends AuthEvent {
  final String email;
  final String password;

  EmailPasswordLoginRequested(this.email, this.password);
}

class GoogleLoginRequested extends AuthEvent {}

class EmailPasswordSignupRequested extends AuthEvent {
  final String email;
  final String password;

  EmailPasswordSignupRequested(this.email, this.password);
}

class GoogleLoginInEvent extends AuthEvent{}

class GoogleLogOutEvent extends AuthEvent {}