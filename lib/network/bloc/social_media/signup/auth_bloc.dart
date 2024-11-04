import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shope_ease/utils/constants.dart';
import 'package:shope_ease/widgets/shared_preference.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  AuthBloc() : super(AuthInitial()) {
    on<EmailPasswordLoginRequested>(_onEmailPasswordLoginRequested);
    on<GoogleLoginInEvent>(_onGoogleSignIn);
    on<GoogleLogOutEvent>(_onGoogleSignOut);
    on<EmailPasswordSignupRequested>(_onEmailPasswordSignupRequested);
  }

  Future<void> _onEmailPasswordLoginRequested(
      EmailPasswordLoginRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: event.email, password: event.password);

      // Success: Store user info if needed
      User? user = userCredential.user;
      if (user != null) {
        // Optional: Store user details in preferences or other storage
        await SharedPreference()
            .putBoolPreference(PreferenceConstants.isLoggedIn, true);
        await SharedPreference().putStringPreference('userId', user.uid);
        await SharedPreference()
            .putStringPreference(PreferenceConstants.strUserEmail, user.email);
      }

      emit(AuthAuthenticated());
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      switch (e.code) {
        case 'user-not-found':
          errorMessage = "No user found for this email.";
          break;
        case 'wrong-password':
          errorMessage = "Incorrect password.";
          break;
        case 'invalid-email':
          errorMessage = "The email address is badly formatted.";
          break;
        default:
          errorMessage = "Login failed. Please try again.";
      }
      emit(AuthError(errorMessage));
    } catch (e) {
      emit(AuthError("An unexpected error occurred: ${e.toString()}"));
    }
  }

  Future<void> _onEmailPasswordSignupRequested(
      EmailPasswordSignupRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
              email: event.email, password: event.password);

      User? user = userCredential.user;
      if (user != null) {
        await user.updateProfile(displayName: event.name);
        await user.reload();
        user = _auth.currentUser;

        // await SharedPreference()
        //     .putStringPreference(PreferenceConstants.strUserName, event.name);
        // await SharedPreference()
        //     .putStringPreference(PreferenceConstants.strUserPhone, event.phone);
        // await SharedPreference()
        //     .putStringPreference(PreferenceConstants.strUserEmail, event.email);
      }

      emit(AuthAuthenticated());
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      switch (e.code) {
        case 'email-already-in-use':
          errorMessage = "This email is already in use.";
          break;
        case 'weak-password':
          errorMessage = "The password provided is too weak.";
          break;
        case 'invalid-email':
          errorMessage = "The email address is badly formatted.";
          break;
        default:
          errorMessage = "Signup failed. Please try again.";
      }
      emit(AuthError(errorMessage));
    } catch (e) {
      emit(AuthError("An unexpected error occurred: ${e.toString()}"));
    }
  }

  Future<void> _onGoogleSignIn(
      GoogleLoginInEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        emit(GoogleAuthFailure(message: 'Google sign-in aborted'));
        return;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential =
          await _auth.signInWithCredential(credential);
      emit(GoogleAuthSuccess(userCredential.user));
      final user = userCredential.user;
      await SharedPreference()
          .putBoolPreference(PreferenceConstants.isLoggedIn, true);
      await SharedPreference().putStringPreference(
          PreferenceConstants.strUserName, user?.displayName.toString() ?? "");
      await SharedPreference()
          .putStringPreference(PreferenceConstants.strUserEmail, user!.email);
      await SharedPreference().putStringPreference(
          PreferenceConstants.strUserPhone, user.phoneNumber);
      await SharedPreference()
          .putStringPreference(PreferenceConstants.imageUrl, user.photoURL);
    } catch (e) {
      emit(GoogleAuthFailure(message: 'Sign-in failed: ${e.toString()}'));
    }
  }

  Future<void> _onGoogleSignOut(
      GoogleLogOutEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      await _googleSignIn.signOut();
      await _auth.signOut();
      emit(AuthInitial()); // Reset to initial state
    } catch (e) {
      emit(GoogleAuthFailure(message: 'Sign-out failed: ${e.toString()}'));
    }
  }
}
