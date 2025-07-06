
abstract class FirebaseAuthState {}

class FirebasAuthInitialState extends FirebaseAuthState {}

class FirebasePhoneAuthLoadingState extends FirebaseAuthState {}


class FirebasePhoneAuthCodeSendSuccessState extends FirebaseAuthState {}

class FirebasePhoneAuthCodeSendFailureState extends FirebaseAuthState {
  String message;
  FirebasePhoneAuthCodeSendFailureState(this.message);
}

class FirebasePhoneAuthSignUpSuccessState extends FirebaseAuthState {}

class FirebasePhoneAuthSignUpFailureState extends FirebaseAuthState {
  String message;
  FirebasePhoneAuthSignUpFailureState(this.message);
}

 class FirebasePhoneAuthSignInSuccessState extends FirebaseAuthState {}

class FirebasePhoneAuthSignInFailureState extends FirebaseAuthState {
  String message;
  FirebasePhoneAuthSignInFailureState(this.message);
}
