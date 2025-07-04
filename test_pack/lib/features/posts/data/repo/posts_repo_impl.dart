import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:test_pack/cores/errors/failure.dart';
import 'package:test_pack/cores/utils/constants.dart';
import 'package:test_pack/cores/utils/hive_services.dart';
import 'package:test_pack/features/posts/data/sources/local_data_source.dart';
import 'package:test_pack/features/posts/data/sources/remote_data_source.dart';

import 'package:test_pack/features/posts/domain/entities/post_entity.dart';
import 'package:test_pack/features/posts/domain/repo/post_repo.dart';

class PostsRepoImpl implements PostRepository {
  final LocalDataSource localDataSource;
  final RemoteDataSource remoteDataSource;
  final HiveServices hiveServices;

  PostsRepoImpl({
    required this.localDataSource,
    required this.remoteDataSource,
    required this.hiveServices,
  });

  @override
  Future<Either<Failure, List<PostEntity>>> fetchPosts() async {
    // the logic is to fetch the data from the local data source first,
    // if the data is empty, then fetch from the remote data source,
    // if the data is not empty, then return the data from the local data source.

    // it try to fetch data to return (right),
    // else it catches an error, so  return the  (left).

    List<PostEntity> postsList;
    try {
      postsList = localDataSource.fetchPosts();
      if (postsList.isNotEmpty) {
        return right(postsList);
      } else {
        postsList = await remoteDataSource.fetchPosts();
        hiveServices.clearPostsData(postsBox);
        hiveServices.savePostsData(postsList, postsBox);
        return right(postsList);
      }
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDiorError(e));
      } else {
        return left(ServerFailure(e.toString()));
      }
    }
  }

  @override
  Future<Either<Failure, Unit>> addPost(PostEntity post) async {
    try {
      await remoteDataSource.addPost(post);
      return right(unit);
    } on DioException catch (e) {
      return left(ServerFailure.fromDiorError(e));
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<PostEntity>>> deletePost(int id) async {
    try {
      await remoteDataSource.deletePost(id);
      final postsList = await remoteDataSource.fetchPosts();

      return right(postsList);
    } on DioException catch (e) {
      return left(ServerFailure.fromDiorError(e));
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> updatePost(PostEntity post) async {
    try {
      await remoteDataSource.updatePost(post);

      return right(unit);
    } on DioException catch (e) {
      return left(ServerFailure.fromDiorError(e));
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }
}
