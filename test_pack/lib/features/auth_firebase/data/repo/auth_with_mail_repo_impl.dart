
import 'package:dartz/dartz.dart';
import 'package:test_pack/cores/errors/failure.dart';
import 'package:test_pack/cores/errors/firebase_errors.dart';
import 'package:test_pack/features/auth_firebase/data/sources/remote_data_source/remote_data_source_with_mail.dart';
import 'package:test_pack/features/auth_firebase/domain/repo/auth_with_mail.dart';


class AuthWithEmailRepositoryImpl implements AuthWithEmailRepository {
  final AuthWithEmailRemoteDataSourceImpl remoteDataSource;
  AuthWithEmailRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, String>> signUpWithEmail(String email, String password) async {
    try {
      final result = await remoteDataSource.signUpWithEmail(
        email,password
      );
      return Right(result);
    } catch (e) {
      return Left(FirebaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> signInWithEmail(String email, String password) async {
    try {
      final result = await remoteDataSource.signInWithEmail(email, password);
      return Right(result);
    } catch (e) {
      return Left(FirebaseFailure(e.toString()));
    }
  }
}
