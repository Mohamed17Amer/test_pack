import 'dart:async';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:test_pack/cores/errors/failure.dart';
import 'package:test_pack/cores/errors/firebase_errors.dart';

class FirebaseServices {
  TextEditingController loginPhoneNumberController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController codeController = TextEditingController();

  static String?
  verificationId; // for verification operation - it is not sms code
  Future<String> verifyPhone({required String phoneNumber}) async {
    final Completer<String> completer = Completer<String>();

    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        timeout: const Duration(seconds: 60),

        verificationCompleted: (PhoneAuthCredential credential) async {
          log('verification completed');
          try {
            await FirebaseAuth.instance.signInWithCredential(credential);
            if (!completer.isCompleted) {
              completer.complete("AUTO_VERIFIED");
            }
          } catch (e) {
            if (!completer.isCompleted) {
              completer.completeError(FirebaseFailure(e.toString()));
            }
          }
        },

        verificationFailed: (FirebaseAuthException e) {
          log('verification failed');
          log("🔴 VERIFICATION FAILED: ${e.code}");
          log("🔴 ERROR MESSAGE: ${e.message}");
          log("🔴 PHONE NUMBER WAS: $phoneNumber");
          if (!completer.isCompleted) {
            completer.completeError(
              FirebaseFailure(e.message ?? "Verification failed"),
            );
          }
        },

        codeSent: (String verificationId, int? resendToken) {
          log('code sent');
          if (!completer.isCompleted) {
            completer.complete(verificationId);
          }
        },

        codeAutoRetrievalTimeout: (String verificationId) {
          log('code auto retrieval timeout');
          // Don't complete here, let codeSent handle it
        },
      );

      return await completer.future.timeout(
        const Duration(seconds: 65),
        onTimeout: () {
          throw FirebaseFailure("Request timed out");
        },
      );
    } catch (e) {
      log("catch " + e.toString());
      throw FirebaseFailure(e.toString());
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
