import 'package:test_pack/cores/errors/failure.dart';
import 'package:test_pack/features/posts/domain/entities/post_entity.dart';
import 'package:test_pack/features/posts/domain/repo/post_repo.dart';

import 'package:dartz/dartz.dart';

class FetchPostsUsecase {
  final PostRepository repository;

  FetchPostsUsecase(this.repository);

  Future<Either<Failure, List<PostEntity>>> call() async {
    return await repository.fetchPosts();
  }
}
