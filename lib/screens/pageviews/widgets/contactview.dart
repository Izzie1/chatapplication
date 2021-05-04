import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:funchat/components/tile.dart';
import 'package:funchat/models/account.dart';
import 'package:funchat/models/contact.dart';
import 'package:funchat/provider/account_provider.dart';
import 'package:funchat/screens/chat/cached_image.dart';
import 'package:funchat/screens/chat/chat.dart';
import 'package:funchat/services/firebase_methods.dart';
import 'package:provider/provider.dart';

class ContactView extends StatelessWidget {
  final Contact contact;
  final FirebaseMethods firebaseMethods = FirebaseMethods();

  ContactView(this.contact);
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Account>(
      future: firebaseMethods.getAccountDetailsById(contact.uid),
      builder: (context, snapshot){
        if(snapshot.hasData) {
          Account account = snapshot.data;
          return ViewLayout(
            contact: account,
          );
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}

class ViewLayout extends StatelessWidget {
  final Account contact;
  final FirebaseMethods firebaseMethods = FirebaseMethods();

  ViewLayout({this.contact});
  @override
  Widget build(BuildContext context) {
    final AccountProvider accountProvider = Provider.of<AccountProvider>(context);
    return Tile(
      mini: false,
      onTap: () => Navigator.push(context, MaterialPageRoute(
          builder: (context)=> Chat(receiver: contact,))),
      title: Text(
        contact?.name ?? ".." ,
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
            CachedImage(
              contact.avatar,
              radius: 50,
              isRound: true,
            ),
            // CircleAvatar(
            //   maxRadius: 50,
            //   backgroundColor: Colors.black,
            //   backgroundImage: AssetImage("images/avatar.png"),
            // ),
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
}

