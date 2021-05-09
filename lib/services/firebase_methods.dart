import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:funchat/enum/user_state.dart';
import 'package:funchat/models/account.dart';
import 'package:funchat/models/contact.dart';
import 'package:funchat/models/message.dart';
import 'package:funchat/provider/image_upload_provider.dart';
import 'package:funchat/ultilities/utils.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  GoogleSignIn _googleSignIn = GoogleSignIn();
  static final FirebaseFirestore fireStore = FirebaseFirestore.instance;
  final CollectionReference messageCollection = fireStore.collection("messages");
  final CollectionReference userCollection = fireStore.collection("users");

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
    QuerySnapshot result = await userCollection
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
        username: Utils.getUsername(currentUser.email),
        groups: []
    );
    userCollection.doc(currentUser.uid)
        .set(account.toMap(account));
  }

  Future<void> signOut() async {
    await _googleSignIn.disconnect();
    await _googleSignIn.signOut();
    return await _auth.signOut();
  }

  Future<List<Account>> getAllAccount(User currentUser) async {
    List<Account> accountList = List<Account>();
    QuerySnapshot querySnapshot = await userCollection.get();
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

    await messageCollection
        .doc(message.senderId)
        .collection(message.receiverId)
        .add(map);

    addToContacts(senderId: message.senderId, receiverId: message.receiverId);

    return await messageCollection
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

    await messageCollection
        .doc(message.senderId)
        .collection(message.receiverId)
        .add(map);

    addToContacts(senderId: message.senderId, receiverId: message.receiverId);

    await messageCollection
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

  Future<Account> getUserDetails() async {
    User currentUser = await getCurrentUser();

    DocumentSnapshot documentSnapshot = await userCollection
        .doc(currentUser.uid).get();

    return Account.fromMap(documentSnapshot.data());
  }

  DocumentReference getContactsDocument({String of, String forContact}) => 
  userCollection.doc(of).collection("contacts").doc(forContact);
  
  addToContacts({String senderId, String receiverId}) async {
    Timestamp currentTime = Timestamp.now();
    await addToSenderContacts(senderId, receiverId, currentTime);
    await addToReceiverContacts(senderId, receiverId, currentTime);
  }

  Future<void> addToSenderContacts(
      String senderId,
      String receiverId,
      currentTime) async {
      DocumentSnapshot senderSnapshot =
      await getContactsDocument(of: senderId, forContact: receiverId).get();
      if (!senderSnapshot.exists) {
        Contact receiverContact = Contact(
          uid: receiverId,
          addedOn: currentTime
        );

        var receiverMap = receiverContact.toMap(receiverContact);

        await getContactsDocument(of: senderId, forContact: receiverId)
            .set(receiverMap);
      }
  }

  Future<void> addToReceiverContacts(
      String senderId,
      String receiverId,
      currentTime) async {
    DocumentSnapshot receiverSnapshot =
    await getContactsDocument(of: receiverId, forContact: senderId).get();

    if (!receiverSnapshot.exists) {
      Contact senderContact = Contact(
        uid: senderId,
        addedOn: currentTime,
      );

      var senderMap = senderContact.toMap(senderContact);

      await getContactsDocument(of: receiverId, forContact: senderId)
          .set(senderMap);
    }
  }

  Stream<QuerySnapshot> fetchContacts({String userId}) => userCollection
      .doc(userId)
      .collection("contacts")
      .snapshots();

  Stream<QuerySnapshot> fetchLastMessageBetween({
    @required String senderId,
    @required String receiverId,
  }) =>
      messageCollection
          .doc(senderId)
          .collection(receiverId)
          .orderBy("timestamp")
          .snapshots();

  Future<Account> getAccountDetailsById(id) async {
    DocumentSnapshot documentSnapshot = await userCollection.doc(id).get();
    return Account.fromMap(documentSnapshot.data());
  }

  void setUserState({@required String userId, @required UserState userState}) {
    int stateNum = Utils.stateToNum(userState);

    userCollection.doc(userId).update({
      "state": stateNum,
    });
  }

  Stream<DocumentSnapshot> getUserStream({@required String uid}) =>
      userCollection.doc(uid).snapshots();
}
