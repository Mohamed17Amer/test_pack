import 'package:firebase_auth/firebase_auth.dart';
import 'package:test_pack/cores/errors/failure.dart';

class FirebaseFailure extends Failure {
  FirebaseFailure(super.message);

  factory FirebaseFailure.fromFirebaseError(Object error) {
    // Typically, Firebase errors are FirebaseException or FirebaseAuthException
    if (error is FirebaseAuthException) {
      return FirebaseFailure._fromAuthError(error);
    } else if (error is FirebaseException) {
      return FirebaseFailure._fromFirestoreError(error);
    } else {
      return FirebaseFailure('An unknown error occurred with Firebase.');
    }
  }

  static FirebaseFailure _fromAuthError(FirebaseAuthException e) {
    switch (e.code) {
      case 'email-already-in-use':
        return FirebaseFailure('The email address is already in use.');
      case 'invalid-email':
        return FirebaseFailure('The email address is invalid.');
      case 'operation-not-allowed':
        return FirebaseFailure('Operation not allowed.');
      case 'weak-password':
        return FirebaseFailure('The password is too weak.');
      case 'user-disabled':
        return FirebaseFailure('This user account has been disabled.');
      case 'user-not-found':
        return FirebaseFailure('No user found with this email.');
      case 'wrong-password':
        return FirebaseFailure('Incorrect password.');
      case 'user-mismatch':
        return FirebaseFailure('The user does not match the credentials.');
      // Add more FirebaseAuth error codes as needed
      default:
        return FirebaseFailure(e.message ?? 'An unknown Authentication error occurred.');
    }
  }

  static FirebaseFailure _fromFirestoreError(FirebaseException e) {
    // You can handle Firestore specific errors here if needed
    switch (e.code) {
      case 'not-found':
        return FirebaseFailure('Document not found.');
      case 'permission-denied':
        return FirebaseFailure('You do not have permission to perform this operation.');
      case 'unavailable':
        return FirebaseFailure('Firestore is currently unavailable.');
      // Add more Firestore error codes as needed
      default:
        return FirebaseFailure(e.message ?? 'An unknown Firestore error occurred.');
    }
  }
}