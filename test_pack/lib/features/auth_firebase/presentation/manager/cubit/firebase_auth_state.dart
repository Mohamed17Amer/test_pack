// abstract class  and initial state

abstract class FirebaseAuthState {}

class FirebasAuthInitialState extends FirebaseAuthState {}

class FirebaseAuthLoadingState extends FirebaseAuthState {}

// phone auth


class FirebasePhoneAuthSignUpSuccessState extends FirebaseAuthState {}

class FirebasePhoneAuthSignUpFailureState extends FirebaseAuthState {
  String message;
  FirebasePhoneAuthSignUpFailureState(this.message);
}

 class FirebasePhoneAuthSignInSuccessState extends FirebaseAuthState {
   
 }

class FirebasePhoneAuthSignInFailureState extends FirebaseAuthState {
  String message;
  FirebasePhoneAuthSignInFailureState(this.message);
}



class FirebasePhoneAuthCodeSendSuccessState extends FirebaseAuthState {}

class FirebasePhoneAuthCodeSendFailureState extends FirebaseAuthState {
  String message;
  FirebasePhoneAuthCodeSendFailureState(this.message);
}


// email auth

class FirebaseEmailAuthSignUpSuccessState extends FirebaseAuthState {}

class FirebaseEmailAuthSignUpFailureState extends FirebaseAuthState {
  String message;
  FirebaseEmailAuthSignUpFailureState(this.message);
}

class FirebaseEmailAuthSignInSuccessState extends FirebaseAuthState {}

class FirebaseEmailAuthSignInFailureState extends FirebaseAuthState {
  String message;
  FirebaseEmailAuthSignInFailureState(this.message);
}


// reset password

class FirebaseResetSuccessState extends FirebaseAuthState {}

class FirebaseFailureFailureState extends FirebaseAuthState {
  String message;
  FirebaseFailureFailureState(this.message);
}
