import 'package:chatapplication/model/Account.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthMethods {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Account _accountFromFireBase(User user) {
    if (user != null) {
      return Account(user.uid);
    } else
      return null;
  }

  Future logInWithAccount(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;
      return _accountFromFireBase(user);
    } catch (e) {
      print(e.toString());
    }
  }

  Future signUpAccount(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;
      return _accountFromFireBase(user);
    } catch (e) {
      print(e.toString());
    }
  }

  Future resetPassword(String email) async {
    try {
      return await _auth.sendPasswordResetEmail(email: email);
    } catch(e) {
      print(e.toString());
    }
  }

  Future signOut() async {
    try {
      return _auth.signOut();
    } catch (e) {

    }
  }
}
