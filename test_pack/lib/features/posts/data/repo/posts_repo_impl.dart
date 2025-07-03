import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:test_pack/cores/errors/failure.dart';
import 'package:test_pack/features/posts/data/sources/local_data_source.dart';
import 'package:test_pack/features/posts/data/sources/remote_data_source.dart';

import 'package:test_pack/features/posts/domain/entities/post_entity.dart';
import 'package:test_pack/features/posts/domain/repo/post_repo.dart';

class PostsRepoImpl implements PostRepository {
  final LocalDataSource localDataSource;
  final RemoteDataSource remoteDataSource;

  PostsRepoImpl({
    required this.localDataSource,
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, List<PostEntity>>> fetchPosts() async {
    List<PostEntity> postsList;
    try {
      postsList = localDataSource.fetchPosts();

      if (postsList.isNotEmpty) {
        return right(postsList);
      }

      postsList = await remoteDataSource.fetchPosts();
      return right(postsList);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDiorError(e));
      }
      return left(ServerFailure(e.toString()));
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
      final updatedPost = await remoteDataSource.updatePost(post);
     

      return right(unit);
    } on DioException catch (e) {
      return left(ServerFailure.fromDiorError(e));
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }


 













}
