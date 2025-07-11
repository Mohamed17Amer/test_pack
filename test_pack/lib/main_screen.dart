import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:test_pack/cores/utils/app_router.dart';

class AllFeaturesScreen extends StatefulWidget {
  const AllFeaturesScreen({super.key});

  @override
  State<AllFeaturesScreen> createState() => _AllFeaturesScreenState();
}

class _AllFeaturesScreenState extends State<AllFeaturesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('All Features')),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                context.push(AppRouter.kFetchView);
              },
              child: const Text('Posts'),
            ),
            ElevatedButton(
              onPressed: () {
                context.push(AppRouter.kFirebaseAuthenticationMethodsView);
              },
              child: const Text("Firebase Auth"),
            ),
          ],
        ),
      ),
    );
  }
}
