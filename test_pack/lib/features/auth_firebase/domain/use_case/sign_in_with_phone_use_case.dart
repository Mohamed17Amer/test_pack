import 'package:dartz/dartz.dart';
import 'package:test_pack/cores/errors/failure.dart';
import 'package:test_pack/features/auth_firebase/domain/repo/auth_with_phone.dart';

class SignInWithPhoneUseCase {
  final AuthWithPhoneRepository repository;
  SignInWithPhoneUseCase(this.repository);

  Future<Either<Failure, Unit>> call(String phoneNumber, String smsCode) async {
    return await repository.signInWithPhone(phoneNumber, smsCode);
  }
}
