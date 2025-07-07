import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FirebaseServices {
  TextEditingController loginPhoneNumberController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController codeController = TextEditingController();

  static String?
  verificationId; // for verification operation - it is not sms code

  Future<void> verifyPhone({@required String? phoneNumber}) async {
    // await FirebaseAuth.instance.verifyPhoneNumber()
    // 6 main common arguments

    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phoneNumber!.trim(),
      timeout: const Duration(seconds: 60),

      verificationCompleted: (PhoneAuthCredential credential) async {
        // Auto-retrieve or instant verification
        // if automatically detected

        await FirebaseAuth.instance.signInWithCredential(credential);
      },

      verificationFailed: (FirebaseAuthException e) {
        // Handle error
        log("showError  verificationFailed  ${e.message}");
      },

      codeSent: (String verId, int? resendToken) {
        // Save verification ID
        verificationId = verId;
        log("showError  codeSent  $verId");
      },

      codeAutoRetrievalTimeout: (String verId) {
        verificationId = verId;
        log("showError  codeAutoRetrievalTimeout  $verId");
      },



      
    );


  }

  Future<void> signInWithCode({@required String? smsCode}) async {
    if (verificationId != null) {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId!,
        smsCode: smsCode!.trim(),
      );
      await signInWithCredential(credential);
    }
  }

  Future<void> signInWithCredential(PhoneAuthCredential credential) async {
    await FirebaseAuth.instance.signInWithCredential(credential);
    // Success
    log('Successfully signed in!   signInWithCredential  ');
  }



  Future<User?> signInWithSmsCode(String verificationId, String smsCode) async {
  // Create a PhoneAuthCredential with the verification ID and the SMS code
  PhoneAuthCredential credential = PhoneAuthProvider.credential(
    verificationId: verificationId,
    smsCode: smsCode,
  );

  // Sign in with the credential
  UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
  return userCredential.user;
}
}
