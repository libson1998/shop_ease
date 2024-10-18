import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shope_ease/utils/constants.dart';

part 'profile_event.dart';

part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitial()) {
    on<ProfileInitialFetchEvent>(_fetchProfile);
  }

  FutureOr<void> _fetchProfile(
      ProfileInitialFetchEvent event, Emitter<ProfileState> emit) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String name =
          prefs.getString(PreferenceConstants.strUserName) ?? "";
      final String email =
          prefs.getString(PreferenceConstants.strUserEmail) ?? "";
      final String phone =
          prefs.getString(PreferenceConstants.strUserPhone) ?? "";
      final String image = prefs.getString(PreferenceConstants.imageUrl) ?? "";
      final bool? isLoggedIn = prefs.getBool(PreferenceConstants.isLoggedIn);

      emit(ProfileLoaded(name: name, email: email, phone: phone, image: image, isLoggedIn: isLoggedIn!));
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }

}
