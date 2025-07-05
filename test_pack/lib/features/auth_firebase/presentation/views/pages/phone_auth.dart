import 'package:flutter/material.dart';

class PhoneAuth extends StatelessWidget {
  const PhoneAuth({super.key});

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
    const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text('Sign Up'),
        TextField(decoration: InputDecoration(hintText: 'Phone Number')),
      ],
    );
  }
}
