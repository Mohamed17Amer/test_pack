
abstract class FirebaseAuthState {}

class FirebasAuthInitialState extends FirebaseAuthState {}

class FirebasePhoneAuthLoadingState extends FirebaseAuthState {}

class FirebasePhoneAuthSuccessState extends FirebaseAuthState {}

class FirebasePhoneAuthFailureState extends FirebaseAuthState {
  String message;
  FirebasePhoneAuthFailureState(this.message);
}
