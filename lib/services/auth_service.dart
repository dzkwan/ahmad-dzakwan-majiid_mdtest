import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fan_test/screens/wrapper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthService {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<({FirebaseAuthException? error, User? success})> signInUser({
    required String email,
    required String password,
  }) async {
    try {
      var credential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return (error: null, success: credential.user);
    } on FirebaseAuthException catch (e) {
      return (error: e, success: null);
    }
  }

  Future<({FirebaseAuthException? error, User? success})> signUpUser({
    required String nama,
    required String email,
    required String password,
  }) async {
    try {
      var credential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await FirebaseFirestore.instance
          .collection("users")
          .doc(credential.user?.uid)
          .set({
        "uid": credential.user?.uid,
        "nama": nama,
        "email": email,
        "emailVerified": credential.user?.emailVerified,
      });
      return (error: null, success: credential.user);
    } on FirebaseAuthException catch (e) {
      return (error: e, success: null);
    }
  }

  Future<void> signOut() async {
    var user = _firebaseAuth.currentUser;
    if (user != null) {
      await _firebaseAuth.signOut();
    }
    Get.offAll(() => const WrapperAuth());
  }

  Future<({FirebaseAuthException? error, User? success})>
      sendVerificationEmail() async {
    var user = _firebaseAuth.currentUser;
    if (user == null) {
      return (error: null, success: null);
    }
    try {
      await user.sendEmailVerification();
      return (error: null, success: user);
    } on FirebaseAuthException catch (e) {
      return (error: e, success: null);
    }
  }

  Future<({FirebaseAuthException? error, bool success})> resetPassword(
      String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
      return (error: null, success: true);
    } on FirebaseAuthException catch (e) {
      return (error: e, success: false);
    }
  }

  Future<FirebaseAuthException?> checkEmailVerificationAndUpdate() async {
    User? user = _firebaseAuth.currentUser;

    if (user != null) {
      try {
        await user.reload();

        if (user.emailVerified) {
          await _firestore.collection('users').doc(user.uid).update({
            'emailVerified': true,
          });
        }

        return null;
      } on FirebaseAuthException catch (e) {
        return e;
      }
    }
  }
}
