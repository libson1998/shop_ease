part of 'login_bloc.dart';

 abstract class LoginEvent {}

class GoogleSignInEvent extends LoginEvent{}

class GoogleSignOutEvent extends LoginEvent {}