import 'package:dartz/dartz.dart';
import 'package:test_pack/cores/errors/failure.dart';

abstract class AuthWithEmailRepository {
  Future<Either<Failure, String>> signUpWithEmail(String email, String password);
  Future<Either<Failure, String>> signInWithEmail(String email, String password);
}
