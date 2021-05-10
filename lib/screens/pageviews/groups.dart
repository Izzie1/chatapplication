import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:funchat/components/sizeconfig.dart';
import 'package:funchat/components/user_avatar.dart';
import 'package:funchat/models/account.dart';
import 'package:funchat/provider/account_provider.dart';
import 'package:funchat/screens/pageviews/widgets/group_view.dart';
import 'package:funchat/screens/search/search_group.dart';
import 'package:funchat/services/firebase_repository.dart';
import 'package:funchat/services/group_methods.dart';
import 'package:provider/provider.dart';

import '../search/search.dart';

// ignore: must_be_immutable
class GroupChat extends StatelessWidget {

  FirebaseRepository repository = new FirebaseRepository();
  AccountProvider accountProvider;
  GroupMethods groupMethods = new GroupMethods();
  String groupName;



  @override
  Widget build(BuildContext context) {
    accountProvider = Provider.of<AccountProvider>(context);
    accountProvider.refreshUser();
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orangeAccent,
        leading: UserAvatar(accountProvider.getAccount.avatar),
        title: Center(
          child: Text("Salut"),
        ),
        actions: <Widget>[
          FloatingActionButton(
            onPressed: () {
              _popupDialog(context);
            },
            child: Icon(Icons.add, color: Colors.white, size: 30.0),
            backgroundColor: Colors.orangeAccent,
            elevation: 0.0,
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
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
                      MaterialPageRoute(builder: (context) => SearchPage()));
                },
              ),
            ),
            groupsList(accountProvider.getAccount),
          ],
        ),
      ),
    );
  }

  Widget groupsList(Account account) {
    if(account.groups.length != 0) {
      return ListView.builder(
          itemCount: account.groups.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            int reqIndex = account.groups.length - index - 1;
            return GroupTile(userName: account.username,
                groupId: _destructureId(account.groups[reqIndex]),
                groupName: _destructureName(account.groups[reqIndex])
            );
          }
      );
    } else return Text("");
  }

  String _destructureId(String res) {
    // print(res.substring(0, res.indexOf('_')));
    return res.substring(0, res.indexOf('_'));
  }


  String _destructureName(String res) {
    // print(res.substring(res.indexOf('_') + 1));
    return res.substring(res.indexOf('_') + 1);
  }

  void _popupDialog(BuildContext context) {
    Widget cancelButton = FlatButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget createButton = FlatButton(
      child: Text("Create"),
      onPressed: () async {
        if (groupName != null) {
          groupMethods.createGroup(accountProvider.getAccount, groupName);
          Navigator.of(context).pop();
        }
      },
    );

    AlertDialog alert = AlertDialog(
      title: Text("Create a group"),
      content: TextField(
          onChanged: (val) {
            groupName = val;
          },
          style: TextStyle(fontSize: 15.0, height: 2.0, color: Colors.black)),
      actions: [
        cancelButton,
        createButton,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
