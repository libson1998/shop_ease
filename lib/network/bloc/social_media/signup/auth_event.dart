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
  final String name; // Add name
  final String phone; // Add phone

  EmailPasswordSignupRequested(
      {required this.email,
        required this.password,
        required this.name,
        required this.phone});
}


class GoogleLoginInEvent extends AuthEvent{}

class GoogleLogOutEvent extends AuthEvent {}