import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_pack/features/posts/domain/entities/post_entity.dart';
import 'package:test_pack/features/posts/presentation/manager/cubit/posts_cubit.dart';
import 'package:test_pack/features/posts/presentation/views/widgets/build_delete_success.dart';
import 'package:test_pack/features/posts/presentation/views/widgets/build_fetch_success.dart';

class BuildPostsScreenBody extends StatelessWidget {
  BuildPostsScreenBody({super.key});
  List<PostEntity> posts = [];
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PostsCubit, PostsState>(
      listener: (context, state) async{
        if (state is DeletePostFailure) {}
        if (state is DeletePostSuccess) {
          posts.addAll(state.posts);
        }
        if (state is FeaturedPostsFailure) {}
        if (state is FeaturedPostsSuccess) {
          posts.clear();
          posts.addAll(state.posts);
          log( 'posts: ${posts.length}');
          log( 'posts: ${posts[0].title}');
        }
        if (state is UpdatePostSuccess){
           await context.read<PostsCubit>().fetchtPosts();
        }
        if (state is UpdatePostFailure) {}
        if (state is AddPostSuccess){
          await context.read<PostsCubit>().fetchtPosts();
       }
        if (state is AddPostFailure) {}
      },
      builder: (context, state) {
        if (state is FeaturedPostsSuccess) {
          return BuildFetchSuccess(posts: posts);
        } else if (state is FeaturedPostsFailure) {
          return Text(state.errMessage);
        } else if (state is DeletePostSuccess) {
          return BuildDeleteSuccess(posts: posts);
        } else if(state is UpdatePostSuccess) {
          return BuildFetchSuccess(posts: posts);
        }
        else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}
