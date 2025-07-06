import 'package:dartz/dartz.dart';
import 'package:test_pack/cores/errors/failure.dart';

abstract class AuthWithPhoneRepository {
  Future<Either<Failure, Unit>> signUpWithPhone(String phoneNumber);
  Future<Either<Failure, Unit>> signInWithPhone(
    String phoneNumber,
    String smsCode,
  );
}
