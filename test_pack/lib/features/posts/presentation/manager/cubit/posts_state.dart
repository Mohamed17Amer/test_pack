part of 'posts_cubit.dart';

sealed class PostsState {}

class AddDeleteUpdatePostInitial extends PostsState {}

class LoadingPostsState extends PostsState {}

class FeaturedPostsSuccess extends PostsState {
  final List<PostEntity> posts;
  FeaturedPostsSuccess(this.posts);
}

class FeaturedPostsFailure extends PostsState {
  final String errMessage;
  FeaturedPostsFailure(this.errMessage);
}

class AddPostSuccess extends PostsState {
  final List<PostEntity> posts;
  AddPostSuccess(this.posts);
}

class AddPostFailure extends PostsState {
  final String message;
  AddPostFailure(this.message);
}

class DeletePostSuccess extends PostsState {
  final List<PostEntity> posts;
  DeletePostSuccess(this.posts);
}

class DeletePostFailure extends PostsState {
  final String message;
  DeletePostFailure(this.message);
}

class LoadingDeletePostState extends PostsState {}

class UpdatePostSuccess extends PostsState {
  //final List<PostEntity> posts;
  //UpdatePostSuccess(this.posts);
}

class UpdatePostFailure extends PostsState {
  final String message;
  UpdatePostFailure(this.message);
}


