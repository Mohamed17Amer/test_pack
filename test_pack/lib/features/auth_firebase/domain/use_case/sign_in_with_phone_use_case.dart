import 'package:dartz/dartz.dart';
import 'package:test_pack/cores/errors/failure.dart';
import 'package:test_pack/features/auth_firebase/domain/repo/auth_with_mail.dart';

class SignInWithEmailUseCase {
  final AuthWithEmailRepository repository;
  SignInWithEmailUseCase(this.repository);

  Future<Either<Failure, String>> call(String email, String password) async {
    return await repository.signInWithEmail(email, password);
  }
}
