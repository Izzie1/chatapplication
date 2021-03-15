import 'package:flutter/material.dart';
import 'package:funchat/components/sizeconfig.dart';
import 'package:funchat/components/tile.dart';
import 'package:funchat/components/user_avatar.dart';
import 'package:funchat/components/widget.dart';
import 'package:funchat/screens/login.dart';
import 'package:funchat/services/firebase_repository.dart';

import '../search.dart';

class ChatList extends StatefulWidget {
  @override
  _ChatListState createState() => _ChatListState();
}

class _ChatListState extends State<ChatList> {
  static final FirebaseRepository _repository = FirebaseRepository();
  String currentUserId;
  String name;
  String photo;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _repository.getCurrentUser().then((user) {
      setState(() {
        currentUserId = user.uid;
        photo = user.photoURL;
        name = user.displayName;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
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
                      UserAvatar(photo),
                      Text(
                        "Chat",
                        style: customTextStyle(),
                      ),
                      Row(
                        children: [
                          IconButton(
                            icon: Icon(
                            Icons.edit,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              )
            ),
            Padding(
              padding: EdgeInsets.all(16),
              child: InkWell(
                borderRadius: BorderRadius.circular(90),
                child: Container(
                  padding:
                      EdgeInsets.only(left: SizeConfig.safeBlockHorizontal * 3),
                  width: SizeConfig.safeBlockHorizontal * 90,
                  height: SizeConfig.safeBlockVertical * 6,
                  child: Row(
                    children: [
                      Icon(Icons.search, size: 16),
                      SizedBox(width: SizeConfig.safeBlockHorizontal * 3),
                      Text("Search...", style: TextStyle(fontSize: 14))
                    ],
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(90),
                      color: Colors.grey.withOpacity(0.2)),
                ),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Search()));
                },
              ),
            ),
            ListView.builder(
                itemCount: 15,
                shrinkWrap: true,
                padding: EdgeInsets.all(12),
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Tile(
                    mini: false,
                    onTap: () {},
                    title: Text(
                      "Dummy Data",
                      style: TextStyle(
                          color: Colors.orangeAccent, fontFamily: "Arial", fontSize: 19),
                    ),
                    subtitle: Text(
                      "Hello",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                      ),
                    ),
                    leading: Container(
                        constraints: BoxConstraints(maxHeight: 50, maxWidth: 50),
                        child: Stack(
                          children: <Widget>[
                            CircleAvatar(
                              maxRadius: 50,
                              backgroundColor: Colors.black,
                              backgroundImage: AssetImage("images/avatar.png"),
                            ),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: Container(
                                height: 14,
                                width: 14,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.green,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                  );
                }
            )
          ],
        ),
      ),
    );
  }
}


