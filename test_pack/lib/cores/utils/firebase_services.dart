import 'dart:async';
import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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

        codeSent: (String verification, int? resendToken) {
          verificationId = verification;
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
      log("catch $e");
      throw FirebaseFailure(e.toString());
    }
  }

  Future<String> verifyOtpCode({@required String? smsCode}) async {
    final Completer<String> completer = Completer<String>();

    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: verificationId!,
      smsCode: smsCode!.trim(),
    );
    try {
      await FirebaseAuth.instance.signInWithCredential(credential);
      if (!completer.isCompleted) {
        completer.complete("VERIFIED");
      }

      return await completer.future.timeout(
        const Duration(seconds: 65),
        onTimeout: () {
          throw FirebaseFailure("Request timed out");
        },
      );
    } catch (e) {
      if (!completer.isCompleted) {
        completer.completeError(FirebaseFailure(e.toString()));
      }
      return await completer.future;
    }
  }

  Future<void> signInWithCredential(PhoneAuthCredential credential) async {
    await FirebaseAuth.instance.signInWithCredential(credential);
    // Success
    log('Successfully signed in!   signInWithCredential  ');
  }
}
