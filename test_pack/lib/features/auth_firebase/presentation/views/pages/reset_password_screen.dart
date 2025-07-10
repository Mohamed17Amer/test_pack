import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:test_pack/features/auth_firebase/presentation/manager/cubit/firebase_auth_cubit.dart';
import 'package:test_pack/features/auth_firebase/presentation/manager/cubit/firebase_auth_state.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  TextEditingController mailController = TextEditingController();
  TextEditingController passswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Reset Password')),
      body: BlocConsumer<FirebaseAuthCubit, FirebaseAuthState>(
        listener: (context, state) {},
        builder: (context, state) {
          return ModalProgressHUD(
            inAsyncCall: (state is FirebaseAuthLoadingState) ? true : false,
            child: Center(
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
                        const Text('RESET PASSWORD'),
                        TextField(
                          controller: mailController,

                          decoration: const InputDecoration(hintText: 'email'),
                        ),

                        const SizedBox(height: 10),

                        ElevatedButton(
                          onPressed: () async{
                           await context.read<FirebaseAuthCubit>().resetPassword(
                              mailController.text,
                            );
                          },
                          child: const Text(' reset password'),
                        ),
                        const SizedBox(height: 10),

                        TextField(
                          controller: passswordController,

                          decoration: const InputDecoration(
                            hintText: 'new password',
                          ),
                        ),

                        const SizedBox(height: 10),

                        ElevatedButton(
                          onPressed: () async{
                           await context.read<FirebaseAuthCubit>().signInWithEmail(
                              mailController.text,
                              passswordController.text,
                            );
                          },
                          child: const Text(' login'),
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
