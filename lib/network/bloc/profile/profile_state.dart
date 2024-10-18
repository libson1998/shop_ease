part of 'profile_bloc.dart';

@immutable
sealed class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final String name;
  final String email;
  final String phone;
  final String image;
  final bool isLoggedIn;

  ProfileLoaded(
      {required this.name,
      required this.email,
      required this.phone,
      required this.image,
      required this.isLoggedIn});
}

class ProfileError extends ProfileState {
  final String message;

  ProfileError(this.message);
}
