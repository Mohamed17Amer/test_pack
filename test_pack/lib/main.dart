import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:test_pack/cores/utils/app_router.dart';
import 'package:test_pack/cores/utils/constants.dart';
import 'package:test_pack/cores/utils/functions/setup_service_locator.dart';
import 'package:test_pack/cores/utils/simple_bloc_observer.dart';
import 'package:test_pack/features/posts/data/repo/posts_repo_impl.dart';
import 'package:test_pack/features/posts/domain/entities/post_entity.dart';
import 'package:test_pack/features/posts/domain/use_cases/add_post.dart';
import 'package:test_pack/features/posts/domain/use_cases/delete_post.dart';
import 'package:test_pack/features/posts/domain/use_cases/get_all_posts.dart';
import 'package:test_pack/features/posts/domain/use_cases/update_post.dart';
import 'package:test_pack/features/posts/presentation/manager/cubit/posts_cubit.dart';
import 'package:test_pack/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(PostEntityAdapter());
  setupServiceLocator();

  await Hive.openBox<PostEntity>(postsBox);
  Bloc.observer = SimpleBlocObserver();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => PostsCubit(
            FetchPostsUsecase(getIt.get<PostsRepoImpl>()),
            DeletePostUsecase(getIt.get<PostsRepoImpl>()),
            UpdatePostUsecase(getIt.get<PostsRepoImpl>()),
            AddPostUsecase(getIt.get<PostsRepoImpl>()),
          )..fetchtPosts(),
        ),
      ],

      child: MaterialApp.router(
        routerConfig: AppRouter.router,
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: Colors.grey.shade900,
          textTheme: GoogleFonts.montserratTextTheme(
            ThemeData.dark().textTheme,
          ),
        ),
      ),
    );
  }
}
