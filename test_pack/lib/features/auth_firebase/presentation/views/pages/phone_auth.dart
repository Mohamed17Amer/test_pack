import 'package:flutter/material.dart';

class PhoneAuth extends StatelessWidget {
  PhoneAuth({super.key});

  TextEditingController loginPhoneNumberController = TextEditingController();
  TextEditingController reqisterPhoneNumberController = TextEditingController();
  TextEditingController verificationCodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Phone Auth')),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(flex: 1, child: buildSignUp()),
            const VerticalDivider(
              color: Colors.white,
              thickness: 2,
              endIndent: 20.00,
              indent: 20.00,
            ),

            Expanded(flex: 1, child: buildSignIn()),
          ],
        ),
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

  buildSignUp() {
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
        ElevatedButton(onPressed: () {}, child: const Text('Send Code')),
        const SizedBox(height: 10),
        TextFormField(
          controller: verificationCodeController,
          decoration: const InputDecoration(hintText: 'code'),
        ),
        const SizedBox(height: 10),
        ElevatedButton(onPressed: () {}, child: const Text('Verify Code')),
      ],
    );
  }
}
