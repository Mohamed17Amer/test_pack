import 'package:go_router/go_router.dart';
import 'package:test_pack/features/auth_firebase/presentation/views/pages/auth_methods.dart';
import 'package:test_pack/features/auth_firebase/presentation/views/pages/mail_auth_screen.dart';
import 'package:test_pack/features/auth_firebase/presentation/views/pages/phone_auth_screen.dart';
import 'package:test_pack/features/auth_firebase/presentation/views/pages/reset_password_screen.dart';
import 'package:test_pack/features/posts/domain/entities/post_entity.dart';
import 'package:test_pack/features/posts/presentation/views/screens/add_posts_screen.dart';
import 'package:test_pack/features/posts/presentation/views/screens/fetch_posts_screen.dart';
import 'package:test_pack/features/posts/presentation/views/screens/update_posts_screen.dart';
import 'package:test_pack/main_screen.dart';

abstract class AppRouter {

  // k is small not capital 😂😂😂😂😭😭😭
  static const kAllFeaturesView = '/';

  static const kFetchView = '/fetch';
  static const kAddView = '/add';
  static const kUpdateView = '/update';

  static const kFirebaseMethodsView = '/firebase';
  static const kFirebaseAuthenticationMethodsView = '/firebaseAuth';

  static const kFirebasePhoneAuthView = '/firebasePhoneAuth';  
  static const kFirebaseMailAuthView = '/firebaseMailAuth';  
  static const kFirebaseFacebookAuthView = '/firebaseFacebookAuth';
  static const kFirebaseResetPasswordView = '/firebaseResetPassword';

  static final router = GoRouter(
    routes: [
      GoRoute(
        path: kAllFeaturesView,
        builder: (context, state) => const AllFeaturesScreen(),
      ),
      GoRoute(
        path: kFetchView,
        builder: (context, state) => const FetchPostsScreen(),
      ),
      GoRoute(
        path: kAddView,
        builder: (context, state) => const AddPostsScreen(),
      ),
      GoRoute(
        path: kUpdateView,
        builder: (context, state) {
          final post = state.extra as PostEntity;
          return UpdatePostsScreen(post: post);
        },
      ),

      GoRoute(
        path: kFirebaseAuthenticationMethodsView,
        builder: (context, state) => const FirebaseAuthMethod(),
      ),

      GoRoute(
        path: kFirebasePhoneAuthView,
        builder: (context, state) => const PhoneAuthScreen(),
      ),

          GoRoute(
        path: kFirebaseMailAuthView,
        builder: (context, state) => const MailAuthScreen(),
      ),

            GoRoute(
        path: kFirebaseFacebookAuthView,
        builder: (context, state) => const MailAuthScreen(),
      ),
            GoRoute(
        path: kFirebaseResetPasswordView,
        builder: (context, state) => const ResetPasswordScreen(),
      ),
    ],
  );
}
