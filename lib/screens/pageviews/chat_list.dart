import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:funchat/models/contact.dart';
import 'package:funchat/provider/account_provider.dart';
import 'package:funchat/screens/login.dart';
import 'package:funchat/screens/pageviews/widgets/contactview.dart';
import 'package:funchat/services/firebase_methods.dart';
import 'package:funchat/services/firebase_repository.dart';
import 'package:provider/provider.dart';


import '../../components/sizeconfig.dart';
import '../../components/tile.dart';
import '../../components/user_avatar.dart';
import '../search/search.dart';

class ChatList extends StatelessWidget {
  AccountProvider accountProvider;
  FirebaseMethods _firebaseMethods = new FirebaseMethods();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    accountProvider = Provider.of<AccountProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orangeAccent,
        leading: UserAvatar(accountProvider.getAccount.avatar),
        title: Center(
          child: Text("Salut"),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.edit,
              color: Colors.white,
            ),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // SafeArea(
            //     child: Padding(
            //       padding: EdgeInsets.only(left: 16, right: 16, top: 16),
            //       child: Row(
            //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //         children: <Widget>[
            //           UserAvatar(photo),
            //           Text(
            //             "Chat",
            //             style: customTextStyle(),
            //           ),
            //           Row(
            //             children: [
            //               IconButton(
            //                 icon: Icon(
            //                   Icons.edit,
            //                   color: Colors.black,
            //                 ),
            //               ),
            //             ],
            //           )
            //         ],
            //       ),
            //     )
            // ),
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
          StreamBuilder<QuerySnapshot>(
                stream: _firebaseMethods.fetchContacts(
                  userId: accountProvider.getAccount.uid,
                ),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      var docList = snapshot.data.docs;
                      if (docList.isEmpty) {
                        return SizedBox(height: 1, width: 1,);
                      }
                      return ListView.builder(
                        shrinkWrap: true,
                        padding: EdgeInsets.all(12),
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: docList.length,
                        itemBuilder: (context, index) {
                          Contact contact = Contact.fromMap(docList[index].data());

                          return ContactView(contact);
                        },
                      );
                    }
                    return Center(child: CircularProgressIndicator());
                  }
              )
          ],
        ),
      ),
    );
  }
}


