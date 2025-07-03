import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:test_pack/features/posts/presentation/views/screens/add_posts_screen.dart';
import 'package:test_pack/features/posts/presentation/views/screens/fetch_posts_screen.dart';

abstract class AppRouter {
  static const kFetchView = '/';

  static const kAddView = '/add';
  static const kBookDetailsView = '/bookDetailsView';
  static const kSearchView = '/searchView';

  static final router = GoRouter(
    routes: [
      GoRoute(path: kFetchView, builder: (context, state) => const FetchPostsScreen()),
      GoRoute(path: kSearchView, builder: (context, state) => Container()),
      GoRoute(path: kAddView, builder: (context, state) => const AddPostsScreen()),
      GoRoute(path: kBookDetailsView, builder: (context, state) => Container()),
    ],
  );
}
