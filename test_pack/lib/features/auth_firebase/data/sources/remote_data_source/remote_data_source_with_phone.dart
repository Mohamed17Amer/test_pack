import 'package:test_pack/cores/utils/firebase_services.dart';

abstract class AuthWithPhoneRemoteDataSource {
  Future<String> signUpWithPhone(String phoneNumber);
  Future<String> signInWithPhone(String smsCode);
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
  Future<String> signInWithPhone(String smsCode) async {
    return await firebaseServices.verifyOtpCode(smsCode: smsCode);
  }
}
