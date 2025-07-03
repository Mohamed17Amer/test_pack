import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:test_pack/cores/utils/app_router.dart';
import 'package:test_pack/features/posts/domain/entities/post_entity.dart';
import 'package:test_pack/features/posts/presentation/manager/cubit/posts_cubit.dart';

class BuildUpdateSuccess extends StatefulWidget {
  const BuildUpdateSuccess({super.key, required this.post});
  final PostEntity post;

  @override
  State<BuildUpdateSuccess> createState() => _BuildUpdateSuccessState();
}

class _BuildUpdateSuccessState extends State<BuildUpdateSuccess> {
  TextEditingController titleController = TextEditingController();

  TextEditingController bodyController = TextEditingController();

  @override
  void initState() {
    super.initState();
    titleController.text = widget.post.title!;
    bodyController.text = widget.post.body!;
  }

  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<PostsCubit, PostsState>(
        listener: (context, state) {
          if (state is UpdatePostSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Post updated successfully')),
            );
          }
        },
        builder: (context, state) {
            return ListTile(
              title: TextFormField(
                controller: titleController,
                style: const TextStyle(color: Colors.red),
                onChanged: (value) {
                  widget.post.title = value;
                },
              ),
              subtitle: TextFormField(
                controller: bodyController,
                onChanged: (value) {
                  widget.post.body = value;
                },
              ),
              trailing: IconButton(
                onPressed: () async {
                  await context.read<PostsCubit>().updatePost(widget.post);
                  //await context.read<PostsCubit>().fetchtPosts();
                  context.push(AppRouter.kFetchView);
                },
                icon: const Icon(Icons.update, color: Colors.red),
              ),
            );
          
        },
    
    );
  }
}
