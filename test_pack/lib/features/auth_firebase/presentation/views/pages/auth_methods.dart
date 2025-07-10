import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:test_pack/cores/utils/app_router.dart';

class FirebaseAuthMethod extends StatefulWidget {
  const FirebaseAuthMethod({super.key});

  @override
  State<FirebaseAuthMethod> createState() => FirebaseAuthMethodState();
}

class FirebaseAuthMethodState extends State<FirebaseAuthMethod> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Firebase Auth')),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                context.push(AppRouter.kFirebasePhoneAuthView);
              },
              child: const Text('Phone Auth'),
            ),
            ElevatedButton(
              onPressed: () {
                context.push(AppRouter.kFirebaseMailAuthView);
              },
              child: const Text('Email Auth'),
            ),
          ],
        ),
      ),
    );
  }
}
