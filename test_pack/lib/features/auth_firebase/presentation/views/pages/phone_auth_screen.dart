import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_pack/features/auth_firebase/presentation/manager/cubit/firebase_auth_cubit.dart';
import 'package:test_pack/features/auth_firebase/presentation/manager/cubit/firebase_auth_state.dart';

class PhoneAuthScreen extends StatelessWidget {
  PhoneAuthScreen({super.key});

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
          if (state is FirebasePhoneAuthLoadingState) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is FirebasePhoneAuthFailureState) {
            return Center(child: Text(state.message));
          }
          if (state is FirebasePhoneAuthSuccessState) {
            return Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(flex: 1, child: buildSignUp(context)),
                  const VerticalDivider(
                    color: Colors.white,
                    thickness: 2,
                    endIndent: 20.00,
                    indent: 20.00,
                  ),

                  Expanded(flex: 1, child: buildSignIn()),
                ],
              ),
            );
          }
          return const Center(child: Text('Initial State'));
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
