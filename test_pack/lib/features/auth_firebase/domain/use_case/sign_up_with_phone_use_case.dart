import 'package:dartz/dartz.dart';
import 'package:test_pack/cores/errors/failure.dart';
import 'package:test_pack/features/auth_firebase/domain/repo/auth_with_phone.dart';

class SignUpWithPhoneUseCase {
  final AuthWithPhoneRepository repository;
  SignUpWithPhoneUseCase(this.repository);

  Future<Either<Failure, Unit>> call(String phoneNumber) async {
    return await repository.signUpWithPhone(phoneNumber);
  }
}
