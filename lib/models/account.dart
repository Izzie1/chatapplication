import 'package:flutter/cupertino.dart';

class Account {
  String uid;
  String name;
  String email;
  String username;
  String status;
  int state;
  String avatar;

  Account(
      {@required this.uid,
      @required this.name,
      @required this.email,
      @required this.username,
      @required this.status,
      @required this.state,
      @required this.avatar});

  Map toMap(Account account) {
    var data = Map<String, dynamic>();
    data["uid"] = account.uid;
    data["name"] = account.name;
    data["email"] = account.email;
    data["username"] = account.username;
    data["status"] = account.status;
    data["state"] = account.state;
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
    this.avatar = mapData["avatar"];
  }
}
