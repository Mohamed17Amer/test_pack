import 'package:dartz/dartz.dart';
import 'package:test_pack/cores/errors/failure.dart';
import 'package:test_pack/features/posts/domain/entities/post_entity.dart';
import 'package:test_pack/features/posts/domain/repo/post_repo.dart';



class UpdatePostUsecase {
  final PostRepository repository;

  UpdatePostUsecase(this.repository);

  Future<Either<Failure, Unit>> call(PostEntity post) async {
    return await repository.updatePost(post);
  }
}
