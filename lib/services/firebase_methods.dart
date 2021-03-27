import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:funchat/models/account.dart';
import 'package:funchat/models/message.dart';
import 'package:funchat/provider/image_upload_provider.dart';
import 'package:funchat/ultilities/utils.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  GoogleSignIn _googleSignIn = GoogleSignIn();
  static final FirebaseFirestore fireStore = FirebaseFirestore.instance;
  Account account;
  FirebaseStorage storage = FirebaseStorage.instance;
  Reference ref;

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
        avatar: currentUser.photoURL,
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

  Future<List<Account>> getAllAccount(User currentUser) async {
    List<Account> accountList = List<Account>();
    QuerySnapshot querySnapshot = await fireStore.collection("users").get();
    for (int i = 0; i < querySnapshot.docs.length; i++){
      if(querySnapshot.docs[i].id != currentUser.uid) {
        accountList.add(Account.fromMap(querySnapshot.docs[i].data()));
      }
    }
    return accountList;
  }

  Future<void> addMessageToDb(
      Message message, Account sender, Account receiver) async {
    var map = message.toMap();

    await fireStore.collection("messages")
        .doc(message.senderId)
        .collection(message.receiverId)
        .add(map);

    return await fireStore.collection("messages")
        .doc(message.receiverId)
        .collection(message.senderId)
        .add(map);
  }

  Future<String> uploadImageToStorage(File image) async {
    try {
      ref = storage.ref().child('${DateTime.now().millisecondsSinceEpoch}');

      UploadTask uploadTask = ref.putFile(image);

      var imageUrl = await (await uploadTask).ref.getDownloadURL();
      return imageUrl;
    } catch (e) {
      return null;
    }
  }

  void setImageMessage(String url, String receiverId, String senderId) async {
    Message message;

    message = Message.imageMessage(
        message: "IMAGE",
        receiverId: receiverId,
        senderId: senderId,
        photoUrl: url,
        timestamp: Timestamp.now(),
        type: 'image'
    );

    var map = message.toImageMap();

    await fireStore.collection("messages")
        .doc(message.senderId)
        .collection(message.receiverId)
        .add(map);

    await fireStore.collection("messages")
        .doc(message.receiverId)
        .collection(message.senderId)
        .add(map);
  }

  void uploadImage(File image, String receiverId,
      String senderId, ImageUploadProvider imageUploadProvider) async {
    imageUploadProvider.setToLoading();
    String url = await uploadImageToStorage(image);
    imageUploadProvider.setToIdle();
    setImageMessage(url, receiverId, senderId);
  }
}
