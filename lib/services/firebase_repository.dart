import 'package:firebase_auth/firebase_auth.dart';
import 'package:funchat/services/firebase_methods.dart';

class FirebaseRepository {
  FirebaseMethods _firebaseMethods = FirebaseMethods();

  Future<User> getCurrentUser() => _firebaseMethods.getCurrentUser();

  Future<User> googleSignInMethod() => _firebaseMethods.googleSignInMethod();

  Future<bool> authenticateUser(User user) =>
      _firebaseMethods.authenticateUser(user);

  Future<void> addDataToDB(User user) => _firebaseMethods.addDataToDB(user);

  Future<void> signOut() => _firebaseMethods.signOut();
}