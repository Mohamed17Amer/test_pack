import 'package:dartz/dartz.dart';
import 'package:test_pack/cores/errors/failure.dart';
import 'package:test_pack/features/posts/domain/entities/post_entity.dart';

abstract class PostRepository {
  Future<Either<Failure, List<PostEntity>>> fetchPosts();
  Future<Either<Failure, List<PostEntity>>> deletePost(int id);
  Future<Either<Failure, Unit>> updatePost(PostEntity post);
  Future<Either<Failure, Unit>> addPost(PostEntity post);
}
