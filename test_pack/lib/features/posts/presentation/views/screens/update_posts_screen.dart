import 'package:flutter/material.dart';
import 'package:test_pack/features/posts/domain/entities/post_entity.dart';
import 'package:test_pack/features/posts/presentation/views/widgets/build_update_success.dart';

class UpdatePostsScreen extends StatelessWidget {
  final PostEntity post;
 const  UpdatePostsScreen({super.key, required this.post});

  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Update Posts')),
      body: BuildUpdateSuccess(post: post),
    );
  }
}
