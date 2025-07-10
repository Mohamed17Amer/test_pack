import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_pack/cores/utils/firebase_services.dart';
import 'package:test_pack/features/auth_firebase/domain/use_case/sign_in_with_mail_use_case.dart';
import 'package:test_pack/features/auth_firebase/domain/use_case/sign_in_with_phone_use_case.dart';
import 'package:test_pack/features/auth_firebase/domain/use_case/sign_up_with_mail_use_case.dart';
import 'package:test_pack/features/auth_firebase/domain/use_case/sign_up_with_phone_use_case.dart';
import 'package:test_pack/features/auth_firebase/presentation/manager/cubit/firebase_auth_state.dart';

class FirebaseAuthCubit extends Cubit<FirebaseAuthState> {
  FirebaseAuthCubit(
    this.signUpWithPhoneUseCase,
    this.signInWithPhoneUseCase,
    this.signUpWithEmailUseCase,
    this.signInWithEmailUseCase,
  ) : super(FirebasAuthInitialState());

  SignUpWithPhoneUseCase signUpWithPhoneUseCase;
  SignInWithPhoneUseCase signInWithPhoneUseCase;
  SignUpWithEmailUseCase signUpWithEmailUseCase;
  SignInWithEmailUseCase signInWithEmailUseCase;
  FirebaseServices firebaseServices = FirebaseServices();

  Future<void> signUpWithPhoneNumber(String phoneNumber) async {
    emit(FirebaseAuthLoadingState());
    var result = await signUpWithPhoneUseCase.call(phoneNumber);
    result.fold(
      (failure) {
        emit(FirebasePhoneAuthSignUpFailureState(failure.message));
      },
      (success) {
        emit(FirebasePhoneAuthSignUpSuccessState());
      },
    );
  }

  Future<void> signInWithPhoneNumber(String smsCode) async {
    emit(FirebaseAuthLoadingState());
    var result = await signInWithPhoneUseCase.call(smsCode);
    result.fold(
      (failure) {
        emit(FirebasePhoneAuthSignInFailureState(failure.message));
      },
      (success) {
        emit(FirebasePhoneAuthSignInSuccessState());
      },
    );
  }

  Future<void> signUpWithEmail(String email, String password) async {
    emit(FirebaseAuthLoadingState());
    var result = await signUpWithEmailUseCase.call(email, password);
    result.fold(
      (failure) {
        emit(FirebaseEmailAuthSignUpFailureState(failure.message));
      },
      (success) {
        emit(FirebaseEmailAuthSignUpSuccessState());
      },
    );
  }

  Future<void> signInWithEmail(String email, String password) async {
    emit(FirebaseAuthLoadingState());
    var result = await signInWithEmailUseCase.call(email, password);
    result.fold(
      (failure) {
        emit(FirebaseEmailAuthSignInFailureState(failure.message));
      },
      (success) {
        emit(FirebaseEmailAuthSignInSuccessState());
      },
    );
  }

  Future<void> resetPassword(String email) async {
    emit(FirebaseAuthLoadingState());
    final result = await firebaseServices.resetPassword(email: email);
    if (result == "success") {
      emit((FirebaseResetSuccessState()));
    } else {
      emit((FirebaseFailureFailureState(result)));
    }
  }
}
