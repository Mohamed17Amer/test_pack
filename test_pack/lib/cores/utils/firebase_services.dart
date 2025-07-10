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

  Future<String> signUpWithEmail({
    required String email,
    required String password,
  }) async {
    final completer = Completer<String>();

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (!completer.isCompleted) {
        completer.complete("success");
      }
    } on FirebaseAuthException catch (e) {
      if (!completer.isCompleted) {
        completer.completeError(FirebaseFailure(e.code.toString()));
      }
    } catch (e) {
      if (!completer.isCompleted) {
        completer.completeError(FirebaseFailure(e.toString()));
      }
    }

    await verfyEmail();

    return await completer.future.timeout(
      const Duration(seconds: 65),
      onTimeout: () {
        throw FirebaseFailure("Request timed out");
      },
    );
  }

 Future signInWithEmail({
  required String email,
  required String password,
}) async {
  final completer = Completer();

  try {
    final userCredential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);

// to verify the email address
    final user = userCredential.user;

    if (user != null && user.emailVerified) {
      if (!completer.isCompleted) {
        completer.complete("success");
      }
    } else {
      // Email not verified

      await FirebaseAuth.instance.signOut();
      if (!completer.isCompleted) {
        completer.completeError(FirebaseFailure("Email not verified. Please check your inbox."));
      }
    }
  } on FirebaseAuthException catch (e) {
    if (!completer.isCompleted) {
      completer.completeError(FirebaseFailure(e.code.toString()));
    }
  } catch (e) {
    if (!completer.isCompleted) {
      completer.completeError(FirebaseFailure(e.toString()));
    }
  }

  return await completer.future.timeout(
    const Duration(seconds: 65),
    onTimeout: () {
      throw FirebaseFailure("Request timed out");
    },
  );
}


  Future<String> resetPassword({required String email}) async {
    try {
      log(email);
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      log('Password reset email sent');
      return "success";
    } catch (e) {
      log('Password reset email failed');
      return " failed + ${e.toString()}";
    }
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  Future<void> deleteAccount() async {
    User? user = FirebaseAuth.instance.currentUser;

    await user?.delete();
  }

  Future<void> updatePassword() async {
    User? user = FirebaseAuth.instance.currentUser;
    await user?.updatePassword('newPassword');
  }

  Future<void> reauth() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      try {
        // Re-authenticate (for example, using email and password)
        AuthCredential credential = EmailAuthProvider.credential(
          email: user.email!,
          password: 'userCurrentPassword', // Must be entered by user
        );

        await user.reauthenticateWithCredential(credential);

        // Now delete
        await user.delete();

        log('User deleted');
      } catch (e) {
        log('Failed to delete user: $e');
      }
    }
  }

  Future<String> verfyEmail() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        // Send verification email
        await user.sendEmailVerification();
        log('Verification email sent');
        return " sent email verification success";
      } catch (e) {
        log('Failed to send verification email: $e');
        return "Failed to send verification email: $e";
      }
    }
    return "No user found";
  }
}
