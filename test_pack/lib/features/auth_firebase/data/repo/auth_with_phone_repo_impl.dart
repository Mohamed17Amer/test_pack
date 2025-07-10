import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:test_pack/cores/errors/failure.dart';
import 'package:test_pack/cores/errors/firebase_errors.dart';
import 'package:test_pack/features/auth_firebase/data/sources/remote_data_source/remote_data_source.dart';
import 'package:test_pack/features/auth_firebase/domain/repo/auth_with_phone.dart';

class AuthWithPhoneRepositoryImpl implements AuthWithPhoneRepository {
  final AuthWithPhoneRemoteDataSource remoteDataSource;
  AuthWithPhoneRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, String>> signUpWithPhone(String phoneNumber) async {
    try {
      final verificationId = await remoteDataSource.signUpWithPhone(
        phoneNumber,
      );
      return Right(verificationId);
    } catch (e) {
      return Left(FirebaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> signInWithPhone(String smsCode) async {
    try {
      final result = await remoteDataSource.signInWithPhone(smsCode);
      return Right(result);
    } catch (e) {
      log('error in sign in with phone');
      return Left(FirebaseFailure(e.toString()));
    }
  }
}
