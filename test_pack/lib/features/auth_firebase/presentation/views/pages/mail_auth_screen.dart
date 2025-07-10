import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_pack/features/auth_firebase/presentation/manager/cubit/firebase_auth_cubit.dart';
import 'package:test_pack/features/auth_firebase/presentation/manager/cubit/firebase_auth_state.dart';

class MailAuthScreen extends StatefulWidget {
  const MailAuthScreen({super.key});

  @override
  State<MailAuthScreen> createState() => _MailAuthScreenState();
}

class _MailAuthScreenState extends State<MailAuthScreen> {
  TextEditingController registerMailController = TextEditingController();

  TextEditingController registerPasswordController = TextEditingController();

  TextEditingController confirmPasswordController = TextEditingController();

  TextEditingController loginrMailController = TextEditingController();

  TextEditingController loginPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mail Auth')),
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
                  child:
                      //sign up
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text('Sign Up'),
                          TextFormField(
                            controller: registerMailController,
                            decoration: const InputDecoration(hintText: 'mail'),
                          ),

                          const SizedBox(height: 10),
                          TextFormField(
                            controller: confirmPasswordController,
                            decoration: const InputDecoration(
                              hintText: 'password',
                            ),
                          ),
                          const SizedBox(height: 10),

                          TextFormField(
                            controller: registerPasswordController,
                            decoration: const InputDecoration(
                              hintText: 'confirm password',
                            ),
                          ),
                          const SizedBox(height: 10),
                          ElevatedButton(
                            onPressed: () async {},
                            child: const Text('sign up '),
                          ),
                          const SizedBox(height: 10),
                        ],
                      ),
                ),
                const VerticalDivider(
                  color: Colors.white,
                  thickness: 2,
                  endIndent: 20.00,
                  indent: 20.00,
                ),

                Expanded(
                  flex: 1,
                  child: //sign in - not used
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text('Sign In'),
                      TextField(
                        controller: loginrMailController,

                        decoration: const InputDecoration(hintText: 'mail'),
                      ),
                      TextFormField(
                        controller: loginPasswordController,
                        decoration: const InputDecoration(hintText: 'password'),
                      ),
                      const SizedBox(height: 10),

                      ElevatedButton(
                        onPressed: () {},
                        child: const Text('login '),
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
