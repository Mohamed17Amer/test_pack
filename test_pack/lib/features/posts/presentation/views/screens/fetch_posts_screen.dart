import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:test_pack/cores/utils/app_router.dart';
import 'package:test_pack/features/posts/presentation/views/widgets/build_screen_body.dart';

class FetchPostsScreen extends StatelessWidget {
 const FetchPostsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Fetch Posts')),
      body:BuildPostsScreenBody(),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.push(AppRouter.kAddView);
        },
        child: const Icon(Icons.add),)
    );
  }
}
