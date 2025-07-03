import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:test_pack/cores/utils/hive_services.dart';
import 'package:test_pack/features/posts/data/repo/posts_repo_impl.dart';
import 'package:test_pack/features/posts/data/sources/local_data_source.dart';
import 'package:test_pack/features/posts/data/sources/remote_data_source.dart';


import '../api_service.dart';

final getIt = GetIt.instance;

void setupServiceLocator() {
  getIt.registerSingleton<ApiService>(
    ApiService(
      Dio(),
    ),
  );

  getIt.registerSingleton<PostsRepoImpl>(
   PostsRepoImpl(
    localDataSource:LocalDataSourceImpl(HiveServices()) ,
    remoteDataSource: RemoteDataSourceImpl(getIt.get<ApiService>(),HiveServices()),
    ),
  );
}
