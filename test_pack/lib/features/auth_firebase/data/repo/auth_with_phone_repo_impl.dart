
import 'package:dartz/dartz.dart';
import 'package:test_pack/cores/errors/failure.dart';
import 'package:test_pack/cores/errors/server_errors.dart';
import 'package:test_pack/features/auth_firebase/data/sources/remote_data_source/remote_data_source.dart';
import 'package:test_pack/features/auth_firebase/domain/repo/auth_with_phone.dart';

class AuthWithPhoneRepositoryImpl implements AuthWithPhoneRepository {
  final AuthWithPhoneRemoteDataSource remoteDataSource;
  AuthWithPhoneRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, Unit>> signUpWithPhone(String phoneNumber) async {
    try {
      await remoteDataSource.signUpWithPhone(phoneNumber);
      return right(unit);
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> signInWithPhone(
    String smsCode,
  ) async{

    try {
      await remoteDataSource.signInWithPhone(smsCode);
      return right(unit);
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
   
  }
}
