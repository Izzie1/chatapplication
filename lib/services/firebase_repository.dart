import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:funchat/models/account.dart';
import 'package:funchat/models/message.dart';
import 'package:funchat/provider/image_upload_provider.dart';
import 'package:funchat/services/firebase_methods.dart';

class FirebaseRepository {
  FirebaseMethods _firebaseMethods = FirebaseMethods();

  Future<User> getCurrentUser() => _firebaseMethods.getCurrentUser();

  Future<User> googleSignInMethod() => _firebaseMethods.googleSignInMethod();

  Future<Account> getUserDetails() => _firebaseMethods.getUserDetails();

  Future<bool> authenticateUser(User user) =>
      _firebaseMethods.authenticateUser(user);

  Future<void> addDataToDB(User user) => _firebaseMethods.addDataToDB(user);

  Future<void> signOut() => _firebaseMethods.signOut();

  Future<List<Account>> getAllAccount(User currentUser) =>
      _firebaseMethods.getAllAccount(currentUser);

  Future<void> addMessageToDb(Message message, Account sender, Account receiver) =>
      _firebaseMethods.addMessageToDb(message, sender, receiver);


  void uploadImage({
    @required File image,
    @required String receiverId,
    @required String senderId,
    @required ImageUploadProvider imageUploadProvider
  }) => _firebaseMethods.uploadImage(image, receiverId, senderId, imageUploadProvider);
}