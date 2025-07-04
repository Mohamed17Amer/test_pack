import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_pack/features/posts/domain/entities/post_entity.dart';
import 'package:test_pack/features/posts/domain/use_cases/add_post.dart';
import 'package:test_pack/features/posts/domain/use_cases/delete_post.dart';
import 'package:test_pack/features/posts/domain/use_cases/get_all_posts.dart';
import 'package:test_pack/features/posts/domain/use_cases/update_post.dart';


part 'posts_state.dart';

class PostsCubit extends Cubit<PostsState> {
  PostsCubit(this.fetchPostsUsecase, this.deletePostUsecase, this.updatePostUsecase, this.addPostUsecase) : super(AddDeleteUpdatePostInitial());
  FetchPostsUsecase  fetchPostsUsecase ;
  DeletePostUsecase deletePostUsecase;
  UpdatePostUsecase updatePostUsecase;
  AddPostUsecase addPostUsecase;

   Future<void> fetchtPosts() async {
    emit(LoadingPostsState());
    var result = await fetchPostsUsecase.call();
    result.fold((failure) {
      emit(FeaturedPostsFailure(failure.message));
    }, (postsList) {
      emit(FeaturedPostsSuccess(postsList));
    });
  }

   Future<void> addPost(PostEntity post) async {
    emit(LoadingPostsState());
   var result=  await addPostUsecase.call(post);
   result.fold((failure) {
      emit(AddPostFailure(failure.message));
    }, (postsList) {
      emit(AddPostSuccess(postsList));
    });
  }

  Future<void> deletePost(int postId) async {
  emit(LoadingPostsState());
  var result = await deletePostUsecase.call(postId);
  result.fold((failure) {
    emit(DeletePostFailure(failure.message));
  }, (postsList) {
    emit(DeletePostSuccess(postsList));
  });
  }

  Future<void> updatePost(PostEntity post) async {
    emit(LoadingPostsState());
   var result=  await updatePostUsecase.call(post);
   result.fold((failure) {
      emit(UpdatePostFailure(failure.message));
    }, (postsList) {
      emit(UpdatePostSuccess());
    });
  }

 












}
    
  




