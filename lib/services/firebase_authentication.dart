import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:giphy/const/const.dart';
import 'package:giphy/helpers/CommonMethods.dart';
import 'package:giphy/helpers/shared_pref.dart';
import 'package:giphy/views/screens/onboarding_screens/landing_screen.dart';

class AuthenticationHelper {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  get user => _auth.currentUser;

  Future<UserCredential?> signIn({required String email, required String password}) async {
    try {
      final credential=await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return credential;
    } on FirebaseAuthException catch (e) {
      print("code==>${e.code}");
      if (e.code == 'user-not-found') {
        CommonMethods.errorMsg('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        CommonMethods.errorMsg('Wrong password provided for that user.');
      }else if (e.code == 'invalid-credential') {
        CommonMethods.errorMsg('Invalid-credential.');
      }
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<UserCredential?> signUp({required String email, required String password}) async {
    try {
      final credential=await _auth.createUserWithEmailAndPassword(email: email, password: password);
      return credential;
    } on FirebaseAuthException catch (e) {
      print("code==>${e.code}");
      if (e.code == 'weak-password') {
        CommonMethods.errorMsg('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        CommonMethods.errorMsg('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future signOut() async {
    SharedPref.clear();
    SharedPref.setBool(key: Const.keepLoggedIn, data:false);
    await _auth.signOut();
    CommonMethods.successMsg("Logged-out");
  }
}
