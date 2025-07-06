import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_pack/features/auth_firebase/domain/use_case/sign_in_with_phone_use_case.dart';
import 'package:test_pack/features/auth_firebase/domain/use_case/sign_up_with_phone_use_case.dart';
import 'package:test_pack/features/auth_firebase/presentation/manager/cubit/firebase_auth_state.dart';

class FirebaseAuthCubit extends Cubit<FirebaseAuthState> {
  FirebaseAuthCubit(this.signUpWithPhoneUseCase, this.signInWithPhoneUseCase)
    : super(FirebasAuthInitialState());

  SignUpWithPhoneUseCase signUpWithPhoneUseCase;
  SignInWithPhoneUseCase signInWithPhoneUseCase;

  Future<void> signUpWithPhoneNumber(String phoneNumber) async {
    emit(FirebasePhoneAuthLoadingState());
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
    emit(FirebasePhoneAuthLoadingState());
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
}
