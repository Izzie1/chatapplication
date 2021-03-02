import 'package:flutter/material.dart';
import 'package:funchat/models/account.dart';
import 'package:funchat/ultilities/user_avatar.dart';

class Chat extends StatefulWidget {
  final Account receiver;

  Chat({this.receiver});

  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[
                    Colors.orange.shade400,
                    Colors.orange.shade300,
                    Colors.orangeAccent.shade200,
                  ])
          ),
        ),
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios_sharp,
          )
        ),
        title:  Container(
          child: Row(
            children: [
              UserAvatar(
                widget.receiver.avatar,
              ),
              SizedBox(width: 8,),
              Column(
                children: [
                  Text(widget.receiver.name,
                      style: TextStyle(
                        fontSize: 16
                    ),
                  ),
                  SizedBox(height: 16,)
                ],
              ),
            ],
          ),
        ),
        centerTitle: false,
        actions: <Widget>[
          IconButton(
              onPressed: (){
              },
              icon: Icon(
                Icons.call,
              )
          ),
          IconButton(
              onPressed: (){
              },
              icon: Icon(
                Icons.videocam,
              )
          ),
        ],
      ),
    );
  }
}
