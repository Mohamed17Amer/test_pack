import 'package:dartz/dartz.dart';
import 'package:test_pack/cores/utils/firebase_services.dart';

abstract class AuthWithPhoneRemoteDataSource {
  Future<Unit> signUpWithPhone(String phoneNumber);
  Future<Unit> signInWithPhone(String smsCode);
}

class AuthWithPhoneRemoteDataSourceImpl
    implements AuthWithPhoneRemoteDataSource {
  final FirebaseServices firebaseServices;
  AuthWithPhoneRemoteDataSourceImpl(this.firebaseServices);

  @override
  Future<Unit> signUpWithPhone(String phoneNumber) async {
    await firebaseServices.verifyPhone(phoneNumber: phoneNumber);
    return Future.value(unit);
  }

  @override

  Future<Unit> signInWithPhone( String smsCode) async {
      await firebaseServices.signInWithCode(smsCode: smsCode);
      return Future.value(unit);

  }
}
