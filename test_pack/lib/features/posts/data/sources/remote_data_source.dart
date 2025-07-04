import 'package:dartz/dartz.dart';
import 'package:test_pack/cores/utils/api_service.dart';
import 'package:test_pack/cores/utils/constants.dart';
import 'package:test_pack/cores/utils/hive_services.dart';
import 'package:test_pack/features/posts/domain/entities/post_entity.dart';

abstract class RemoteDataSource {
  /// Fetches all posts from the remote source.
  Future<List<PostEntity>> fetchPosts();

  /// Deletes a post by its ID from the remote source.
  Future<Unit> deletePost(int id);

  /// Updates a post in the remote source.
  Future<Unit> updatePost(PostEntity post);

  /// Adds a new post to the remote source.
  Future<Unit> addPost(PostEntity post);
}

class RemoteDataSourceImpl implements RemoteDataSource {
  final ApiService apiService;
  final HiveServices hiveServices;
  RemoteDataSourceImpl(this.apiService, this.hiveServices);

  @override
  Future<List<PostEntity>> fetchPosts() async {
    var data = await apiService.get(endPoint: 'posts');
    List<PostEntity> posts = apiService.getDataList(data: data);
    return posts;
  }

  @override
  Future<Unit> addPost(PostEntity post) async {
    await apiService.addPost(post);
    return Future.value(unit);
  }

  @override
  Future<Unit> deletePost(int id) {
    apiService.deletePosst(id);
    hiveServices.clearPostsData(postsBox);

    return Future.value(unit);
  }

  @override
  Future<Unit> updatePost(PostEntity post) async {
    await apiService.updatePost(post);
    hiveServices.clearPostsData(postsBox);
    /*
    var box = Hive.box<PostEntity>(postsBox);
      var postsList = box.values.toList();
      int currentIndex = postsList.indexWhere(
        (element) => element.id == post.id,
      );
      postsList.removeWhere((element) => element.id == post.id);
      postsList.insert(currentIndex, updatedPost);
      */
    //hiveServices.clearPostsData(postsBox);
    // hiveServices.savePostsData(postsList, postsBox);

    return Future.value(unit);
  }


}
