import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meta/meta.dart';
import 'package:shope_ease/utils/constants.dart';
import 'package:shope_ease/widgets/shared_preference.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  LoginBloc() : super(LoginInitial()) {
    on<GoogleSignInEvent>(_onGoogleSignIn);
    on<GoogleSignOutEvent>(_onGoogleSignOut);
  }

  Future<void> _onGoogleSignIn(
      GoogleSignInEvent event, Emitter<LoginState> emit) async {
    emit(GoogleAuthLoading());
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        emit(GoogleAuthFailure('Google sign-in aborted'));
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
      emit(GoogleAuthFailure('Sign-in failed: ${e.toString()}'));
    }
  }

  Future<void> _onGoogleSignOut(
      GoogleSignOutEvent event, Emitter<LoginState> emit) async {
    emit(GoogleAuthLoading());
    try {
      await _googleSignIn.signOut();
      await _auth.signOut();
      emit(LoginInitial()); // Reset to initial state
    } catch (e) {
      emit(GoogleAuthFailure('Sign-out failed: ${e.toString()}'));
    }
  }
}
