import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  String senderId;
  String receiverId;
  String type;
  String message;
  Timestamp timestamp;
  String photoUrl;

  Message({this.senderId, this.receiverId, this.type, this.message,
      this.timestamp});


  Message.imageMessage({this.senderId, this.receiverId, this.type, this.message,
      this.timestamp, this.photoUrl});

  Map toMap() {
    var data = Map<String, dynamic>();
    data["senderId"] = this.senderId;
    data["receiveId"] = this.receiverId;
    data["type"] = this.type;
    data["message"] = this.message;
    data["timestamp"] = this.timestamp;
    data["photoUrl"] = this.photoUrl;
    return data;
  }

  Message.fromMap(Map<String, dynamic> mapData) {
    this.senderId = mapData['senderId'];
    this.receiverId = mapData['receiverId'];
    this.type = mapData['type'];
    this.message = mapData['message'];
    this.timestamp = mapData['timestamp'];
  }
}