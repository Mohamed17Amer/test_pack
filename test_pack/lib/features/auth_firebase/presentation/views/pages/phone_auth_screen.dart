import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_pack/cores/utils/functions/build_error_snack_bar.dart';
import 'package:test_pack/features/auth_firebase/presentation/manager/cubit/firebase_auth_cubit.dart';
import 'package:test_pack/features/auth_firebase/presentation/manager/cubit/firebase_auth_state.dart';

class PhoneAuthScreen extends StatefulWidget {
  PhoneAuthScreen({super.key});

  @override
  State<PhoneAuthScreen> createState() => _PhoneAuthScreenState();
}

class _PhoneAuthScreenState extends State<PhoneAuthScreen> {
  TextEditingController loginPhoneNumberController = TextEditingController();

  TextEditingController reqisterPhoneNumberController = TextEditingController();

  TextEditingController verificationCodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Phone Auth')),
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
                            controller: reqisterPhoneNumberController,
                            decoration: const InputDecoration(
                              hintText: '+201500422619',
                            ),
                          ),

                          const SizedBox(height: 10),
                          ElevatedButton(
                            onPressed: () async {
                             if (reqisterPhoneNumberController.text.isEmpty) {
                               BuildErrorWidget( errMessage:  'Phone Number is Empty');
                              }
                             else if  (reqisterPhoneNumberController.text.isNotEmpty) {
                              await context
                                  .read<FirebaseAuthCubit>()
                                  .signUpWithPhoneNumber(
                                    reqisterPhoneNumberController.text,
                                  );
                              }
                            },
                            child: const Text('Send Code  - verify '),
                          ),
                          const SizedBox(height: 10),
                          TextFormField(
                            controller: verificationCodeController,
                            decoration: const InputDecoration(hintText: 'code'),
                          ),
                          const SizedBox(height: 10),
                          ElevatedButton(
                            onPressed: () async {
                               if (verificationCodeController.text.isEmpty) {
                              const BuildErrorWidget( errMessage:  'code is Empty');
                              }
                             else if  (verificationCodeController.text.isNotEmpty) {
                              await context
                                  .read<FirebaseAuthCubit>()
                                  .signInWithPhoneNumber(
                                    verificationCodeController.text,
                                  );
                              }
                            },
                            child: const Text('Verify sms Code - login'),
                          ),
                        ],
                      ),
                ),
                const VerticalDivider(
                  color: Colors.white,
                  thickness: 2,
                  endIndent: 20.00,
                  indent: 20.00,
                ),

                const Expanded(
                  flex: 1,
                  child: //sign in
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('Sign In'),
                      TextField(
                        decoration: InputDecoration(hintText: 'Phone Number'),
                      ),
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

  buildSignIn() {
    return
    //sign in
    const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text('Sign In'),
        TextField(decoration: InputDecoration(hintText: 'Phone Number')),
      ],
    );
  }

  buildSignUp(BuildContext context) {
    return
    //sign up
    Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text('Sign Up'),
        TextFormField(
          controller: reqisterPhoneNumberController,
          decoration: const InputDecoration(hintText: '+201011245647'),
        ),

        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: () {
            context.read<FirebaseAuthCubit>().signUpWithPhoneNumber(
              reqisterPhoneNumberController.text,
            );
          },
          child: const Text('Send Code  - verify '),
        ),
        const SizedBox(height: 10),
        TextFormField(
          controller: verificationCodeController,
          decoration: const InputDecoration(hintText: 'code'),
        ),
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: () {
            context.read<FirebaseAuthCubit>().signUpWithPhoneNumber(
              verificationCodeController.text,
            );
          },
          child: const Text('Verify sms Code - login'),
        ),
      ],
    );
  }
}
