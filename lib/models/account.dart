import 'package:flutter/cupertino.dart';

class Account {
  String uid;
  String name;
  String email;
  String username;
  String status;
  int state;
  String avatar;
  var groups;

  Account(
      {this.uid,
      this.name,
      this.email,
      this.username,
      this.status,
      this.state,
      this.avatar,
      this.groups});

  Map toMap(Account account) {
    var data = Map<String, dynamic>();
    data["uid"] = account.uid;
    data["name"] = account.name;
    data["email"] = account.email;
    data["username"] = account.username;
    data["status"] = account.status;
    data["state"] = account.state;
    data["groups"] = account.groups;
    data["avatar"] = account.avatar;
    return data;
  }

  Account.fromMap(Map<String, dynamic> mapData) {
    this.uid = mapData["uid"];
    this.name = mapData["name"];
    this.email = mapData["email"];
    this.username = mapData["username"];
    this.status = mapData["status"];
    this.state = mapData["state"];
    this.groups = mapData["groups"];
    this.avatar = mapData["avatar"];
  }
}
