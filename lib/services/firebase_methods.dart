import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:funchat/models/account.dart';
import 'file:///D:/app/Flutter/funchat/lib/ultilities/utils.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  GoogleSignIn _googleSignIn = GoogleSignIn();
  static final FirebaseFirestore fireStore = FirebaseFirestore.instance;
  Account account;

  Future<User> getCurrentUser() async {
    User user;
    user = _auth.currentUser;
    return user;
  }

  Future<User> googleSignInMethod() async {
    GoogleSignInAccount _signInAccount = await _googleSignIn.signIn();
    GoogleSignInAuthentication _sigInAuthentication =
        await _signInAccount.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: _sigInAuthentication.accessToken,
        idToken: _sigInAuthentication.idToken);
    UserCredential userCredential =
        await _auth.signInWithCredential(credential);
    return userCredential.user;
  }

  Future<bool> authenticateUser(User user) async {
    QuerySnapshot result = await fireStore
        .collection("users")
        .where("email", isEqualTo: user.email)
        .get();
    return result.size == 0 ? true : false;
  }

  Future<void> addDataToDB(User currentUser) async {
    account = Account(
        uid: currentUser.uid,
        email: currentUser.email,
        name: currentUser.displayName,
        username: Utils.getUsername(currentUser.email));

    fireStore
        .collection("users")
        .doc(currentUser.uid)
        .set(account.toMap(account));
  }

  Future<void> signOut() async {
    await _googleSignIn.disconnect();
    await _googleSignIn.signOut();
    return await _auth.signOut();
  }
}
