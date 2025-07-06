import 'package:firebase_core/firebase_core.dart';
import 'package:test_pack/cores/utils/firebase_services.dart';

abstract class AuthWithPhoneRemoteDataSource {
  Future<void> signUpWithPhone(String phoneNumber);
  Future<void> signInWithPhone(String phoneNumber, String smsCode);
}

class AuthWithPhoneRemoteDataSourceImpl implements AuthWithPhoneRemoteDataSource {
  final FirebaseServices firebaseServices;
  AuthWithPhoneRemoteDataSourceImpl(this.firebaseServices);

   @override
  Future<void> signUpWithPhone(String phoneNumber) {

  } 


  @override
  Future<void> signInWithPhone(String phoneNumber, String smsCode) async {
    // TODO: implement signInWithPhone
    throw UnimplementedError();
  }
  
 

}
