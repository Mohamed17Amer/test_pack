import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_pack/features/posts/domain/entities/post_entity.dart';
import 'package:test_pack/features/posts/presentation/manager/cubit/posts_cubit.dart';
import 'package:test_pack/features/posts/presentation/views/widgets/build_fetch_success.dart';

class BuildPostsScreenBody extends StatelessWidget {
  BuildPostsScreenBody({super.key});
  List<PostEntity> posts = [];
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PostsCubit, PostsState>(
      listener: (context, state) async {
        if (state is FeaturedPostsFailure) {}
        if (state is FeaturedPostsSuccess) {
          posts.clear();
          posts.addAll(state.posts);
        }

        if (state is AddPostFailure) {}
        if (state is AddPostSuccess) {
          posts.clear();
          posts.addAll(state.posts);
        }

        if (state is DeletePostFailure) {}
        if (state is DeletePostSuccess) {
          posts.clear();
          posts.addAll(state.posts);
        }

        if (state is UpdatePostFailure) {}
        if (state is UpdatePostSuccess) {
          posts.clear();
          posts.addAll(state.posts);
        }
      },
      builder: (context, state) {
        if (state is FeaturedPostsSuccess) {
          return BuildFetchSuccess(posts: state.posts);
        } else if (state is AddPostSuccess) {
          return BuildFetchSuccess(posts: state.posts);
        } else if (state is DeletePostSuccess) {
          return BuildFetchSuccess(posts: state.posts);
        } else if (state is UpdatePostSuccess) {
          return BuildFetchSuccess(posts: state.posts);
        } else if (state is UpdatePostFailure) {
          return Center(child: Text(state.message));
        } else if (state is AddPostFailure) {
          return Center(child: Text(state.message));
        } else if (state is DeletePostFailure) {
          return Center(child: Text(state.message));
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}
