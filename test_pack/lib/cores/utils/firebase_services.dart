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



  Future<void> signInWithCredential(PhoneAuthCredential credential) async {
    await FirebaseAuth.instance.signInWithCredential(credential);
    // Success
    log('Successfully signed in!   signInWithCredential  ');
  }

// In your Firebase service, add detailed logging:
Future<String> verifyOtpCode({
  required String smsCode
}) async {
  try {
    log("🔍 Verifying OTP:");
    log("📱 Verification ID: $verificationId");
    log("🔢 SMS Code: $smsCode");
    
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: verificationId!,
      smsCode: smsCode.trim(), // Remove whitespace
    );
    log("v1 : ${credential.verificationId}  ");
    log("v2 : ${verificationId}  ");

    log("✅ Credential created successfully");
    
    UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
    
    log("✅ Sign in successful");
    
    if (userCredential.user != null) {
      return "success";
    } else {
      return "User is null after sign in";
    }
  } catch (e) {
    log("❌ OTP Verification failed: ${e.toString()}");
    
    if (e is FirebaseAuthException) {
      log("❌ Error code: ${e.code}");
      log("❌ Error message: ${e.message}");
      
      switch (e.code) {
        case 'invalid-verification-code':
          return "Invalid verification code. Please try again.";
        case 'user-disabled':
          return "This user account has been disabled.";
        default:
          return e.message ?? "OTP verification failed";
      }
    }
    
    // Handle other types of exceptions
    return "Unexpected error during OTP verification";
  }
}
}
