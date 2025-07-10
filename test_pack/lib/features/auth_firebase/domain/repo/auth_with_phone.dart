import 'package:dartz/dartz.dart';
import 'package:test_pack/cores/errors/failure.dart';

abstract class AuthWithPhoneRepository {
  Future<Either<Failure, String>> signUpWithPhone(String phoneNumber);
  Future<Either<Failure, String>> signInWithPhone(String smsCode);
}
