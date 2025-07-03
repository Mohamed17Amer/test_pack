import 'package:flutter/material.dart';
import 'package:test_pack/features/posts/domain/entities/post_entity.dart';
import 'package:test_pack/features/posts/presentation/views/widgets/build_add_success.dart';

class AddPostsScreen extends StatelessWidget {
 const  AddPostsScreen({super.key, });

  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Posts')),
      body: BuildAddSuccess(),
    );
  }
}
