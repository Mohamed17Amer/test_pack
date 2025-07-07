import 'dart:async';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:test_pack/cores/errors/firebase_errors.dart';

class FirebaseServices {
  TextEditingController loginPhoneNumberController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController codeController = TextEditingController();

  static String?
  verificationId; // for verification operation - it is not sms code

  Future<void> verifyPhone({
    required String phoneNumber,
    Function(FirebaseFailure)? onVerificationFailed,
  }) async {
    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNumber,

        verificationFailed: (FirebaseAuthException e) {
          log("showError verificationFailed: ${e.message}");
          onVerificationFailed?.call(
            FirebaseFailure(e.message ?? "Phone verification failed"),
          );
        },
        verificationCompleted: (PhoneAuthCredential credential) async {
          await signInWithCredential(credential);
        },
        codeSent: (String verificationId, int? resendToken) {
          verificationId = verificationId;
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          verificationId = verificationId;
        },
        // Other callbacks...
      );
    } catch (e) {
      // Additional error handling if needed
      onVerificationFailed?.call(FirebaseFailure(e.toString()));
    }
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
    UserCredential userCredential = await FirebaseAuth.instance
        .signInWithCredential(credential);
    return userCredential.user;
  }
}
