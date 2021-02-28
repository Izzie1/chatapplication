import 'package:flutter/material.dart';
import 'package:funchat/services/firebase_repository.dart';
import 'package:funchat/ultilities/widget.dart';

class ChatList extends StatefulWidget {
  @override
  _ChatListState createState() => _ChatListState();
}

class _ChatListState extends State<ChatList> {
  static final FirebaseRepository _repository = FirebaseRepository();
  String currentUserId;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _repository.getCurrentUser().then((user) {
      setState(() {
        currentUserId = user.uid;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SafeArea(
                child: Padding(
                  padding: EdgeInsets.only(left: 16, right: 16, top: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("Chats",style: customTextStyle(),),
                      Container()
                    ],
                  ),
                )
            ),
            Padding(
              padding: EdgeInsets.all(16),
              child: TextField(
                decoration: search(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
