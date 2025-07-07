import 'package:dartz/dartz.dart';
import 'package:test_pack/cores/utils/firebase_services.dart';

abstract class AuthWithPhoneRemoteDataSource {
  Future<String> signUpWithPhone(String phoneNumber);
  Future<Unit> signInWithPhone(String smsCode);
}

class AuthWithPhoneRemoteDataSourceImpl
    implements AuthWithPhoneRemoteDataSource {
  final FirebaseServices firebaseServices;
  AuthWithPhoneRemoteDataSourceImpl(this.firebaseServices);

  @override
  Future<String> signUpWithPhone(String phoneNumber) async {
  return await firebaseServices.verifyPhone(phoneNumber: phoneNumber);
}

  @override

  Future<Unit> signInWithPhone( String smsCode) async {
      await firebaseServices.signInWithCode(smsCode: smsCode);
      return Future.value(unit);

  }
}
