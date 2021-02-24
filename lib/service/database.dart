import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {

  getUserByUsername(String username) async {
    return await FirebaseFirestore.instance.collection("user")
        .where("name", isEqualTo:  username);
  }

  uploadUserInfo(userMap) {
    FirebaseFirestore.instance.collection("users")
    .add(userMap);
  }
}
