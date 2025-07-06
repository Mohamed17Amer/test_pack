import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FirebaseServices {
  TextEditingController loginPhoneNumberController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController codeController = TextEditingController();

 static String? verificationId; // for verification operation - it is not sms code

  Future<void> verifyPhone({@ required String? phoneNumber}) async {
    try {
      // await FirebaseAuth.instance.verifyPhoneNumber()
      // 6 main common arguments

      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber:phoneNumber!.trim(),
        timeout: const Duration(seconds: 60),

        verificationCompleted: (PhoneAuthCredential credential) async {
          // Auto-retrieve or instant verification
          // if automatically detected

          await signInWithCredential(credential);
        },

        verificationFailed: (FirebaseAuthException e) {
          // Handle error
          log("showError  verificationFailed  ${e.message}");
        },

        codeSent: (String verId, int? resendToken) {
          // Save verification ID
          verificationId = verId;
        
        },

        codeAutoRetrievalTimeout: (String verId) {
          verificationId = verId;
        },
      );
    } on FirebaseAuthException catch (e) {
      log("showError verifyPhoneNumber ${e.message}");
    }
  }

  Future<void> signInWithCredential(PhoneAuthCredential credential) async {
    try {
      await FirebaseAuth.instance.signInWithCredential(credential);
      // Success
      log('Successfully signed in!   signInWithCredential  ');
    } on FirebaseAuthException catch (e) {
      log("showError   signInWithCredential   ${e.message}");
    }
  }

  Future<void> signInWithCode({@ required String? smsCode}) async {
    if (verificationId != null && smsCode!.isNotEmpty) {
      try {
        PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verificationId!,
          smsCode: smsCode.trim(),
        );
        await signInWithCredential(credential);
      } catch (e) {
        log("showError signInWithCode ${e.toString()}");
      }
    }
  }
}
