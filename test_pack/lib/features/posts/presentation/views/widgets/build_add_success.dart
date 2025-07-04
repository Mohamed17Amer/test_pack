import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:test_pack/cores/utils/app_router.dart';
import 'package:test_pack/features/posts/domain/entities/post_entity.dart';
import 'package:test_pack/features/posts/presentation/manager/cubit/posts_cubit.dart';

class BuildAddSuccess extends StatefulWidget {
   const BuildAddSuccess({super.key});

  @override
  State<BuildAddSuccess> createState() => _BuildAddSuccessState();
}

class _BuildAddSuccessState extends State<BuildAddSuccess> {
  TextEditingController titleController = TextEditingController();

  TextEditingController bodyController = TextEditingController();

  @override
  void initState() {
    super.initState();
    
  }

  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<PostsCubit, PostsState>(
        listener: (context, state) {
          if (state is AddPostSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Post Added successfully')),
            );
          }
        },
        builder: (context, state) {
            return ListTile(
              title: TextFormField(
                controller: titleController,
                style: const TextStyle(color: Colors.red),
                onChanged: (value) {
                 
                },
              ),
              subtitle: TextFormField(
                controller: bodyController,
                onChanged: (value) {
                },
              ),
              trailing: IconButton(
                onPressed: () async {
                   final post = PostEntity(body: bodyController.text, title: titleController.text, id:122);
                  await context.read<PostsCubit>().addPost(post);
                  //await context.read<PostsCubit>().fetchtPosts();
                  context.push(AppRouter.kFetchView);
                },
                icon: const Icon(Icons.add, color: Colors.red),
              ),
            );
          
        },
     
    );
  }
}
