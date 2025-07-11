import 'package:dartz/dartz.dart';
import 'package:test_pack/cores/errors/failure.dart';
import 'package:test_pack/features/posts/domain/entities/post_entity.dart';
import 'package:test_pack/features/posts/domain/repo/post_repo.dart';


class DeletePostUsecase {
  final PostRepository repository;

  DeletePostUsecase(this.repository);

  Future<Either<Failure, List<PostEntity>>> call(int postId) async {
    return await repository.deletePost(postId);
  }
}
