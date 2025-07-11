import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_pack/features/auth_firebase/presentation/manager/cubit/firebase_auth_cubit.dart';
import 'package:test_pack/features/auth_firebase/presentation/manager/cubit/firebase_auth_state.dart';

class FacebookAuthScreen extends StatefulWidget {
  const FacebookAuthScreen({super.key});

  @override
  State<FacebookAuthScreen> createState() => _FacebookAuthScreenState();
}

class _FacebookAuthScreenState extends State<FacebookAuthScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Facebook Auth')),
      body: BlocConsumer<FirebaseAuthCubit, FirebaseAuthState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 1,
                  child: // reset
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text('Facebook Auth'),

                      const SizedBox(height: 10),

                      ElevatedButton(
                        onPressed: () async {
                          await context
                              .read<FirebaseAuthCubit>()
                              .signInWithFacebook();
                        },
                        child: const Text(' Login with facebook'),
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
