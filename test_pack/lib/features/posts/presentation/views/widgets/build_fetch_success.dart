import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_pack/features/posts/presentation/manager/cubit/posts_cubit.dart';
import 'package:test_pack/features/posts/presentation/views/screens/update_posts_screen.dart';

class BuildFetchSuccess extends StatelessWidget {
   const BuildFetchSuccess( {super.key, required this.posts});
  final List? posts;
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: posts!.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => UpdatePostsScreen(post: posts![index]),
              ),
            );
          },
          child: ListTile(
            title: Text(
              posts![index].title,
              style: const TextStyle(color: Colors.red),
            ),
            subtitle: Text(posts![index].body),
            trailing: IconButton(
              onPressed: () {
                context.read<PostsCubit>().deletePost(posts![index].id!);
              },
              icon: const Icon(Icons.delete, color: Colors.red),
            ),
          ),
        );
      },
      separatorBuilder: (context, index) =>
          const Divider(color: Colors.blue, thickness: 3.00),
    );
  }
}
