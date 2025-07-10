import 'package:test_pack/cores/utils/firebase_services.dart';

abstract class AuthWithEmailRemoteDataSource {
  Future<String> signUpWithEmail(String email, String password);
  Future<String> signInWithEmail(String email, String password);
}

class AuthWithEmailRemoteDataSourceImpl
    implements AuthWithEmailRemoteDataSource {
  final FirebaseServices firebaseServices;
  AuthWithEmailRemoteDataSourceImpl(this.firebaseServices);

 

    @override
  Future<String> signUpWithEmail(String email, String password)async {
    return await firebaseServices.signUpWithEmail(email: email, password: password);
  }
  
  @override
  Future<String> signInWithEmail(String email, String password) async {
      return await firebaseServices.signInWithEmail(email: email, password: password);

  }
}
