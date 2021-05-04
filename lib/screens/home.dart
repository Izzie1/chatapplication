import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:funchat/components/user_avatar.dart';
import 'package:funchat/provider/account_provider.dart';
import 'package:funchat/screens/call/pickup/pickup_layout.dart';
import 'package:funchat/screens/pageviews/profilePage.dart';
import 'package:funchat/services/firebase_repository.dart';
import 'package:provider/provider.dart';

import 'pageviews/chat_list.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  static final FirebaseRepository _repository = FirebaseRepository();
  String currentUserId;
  String name;
  String photo;
  AccountProvider accountProvider;
  PageController pageController;
  int _page = 0;

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
    SchedulerBinding.instance.addPostFrameCallback((_) {
      accountProvider = Provider.of<AccountProvider>(context, listen: false);
      accountProvider.refreshUser();
    });
    pageController = PageController();
  }

  void onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  void navigationTapped(int page) {
    pageController.jumpToPage(page);
  }

  @override
  Widget build(BuildContext context) {
    return PickupLayout(
      scaffold: Scaffold(
        body: PageView(
          children: <Widget>[
            Container(
              child: ChatList(),
            ),
            Center(
                child: Text("Groups", style: TextStyle(color: Colors.black))),
            Center(
              child: ProfilePage(),
              )
          ],
          controller: pageController,
          onPageChanged: onPageChanged,
        ),
        bottomNavigationBar: Container(
          child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: CupertinoTabBar(
                backgroundColor: Colors.white,
                items: <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                      icon: Icon(Icons.chat_rounded,
                          color:
                              (_page == 0) ? Colors.orangeAccent : Colors.grey),
                      title: Text(
                        "Chat",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: (_page == 0)
                                ? Colors.orangeAccent
                                : Colors.grey),
                      )),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.group,
                          color:
                              (_page == 1) ? Colors.orangeAccent : Colors.grey),
                      title: Text(
                        "Groups",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: (_page == 1)
                                ? Colors.orangeAccent
                                : Colors.grey),
                      )),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.account_circle,
                          color:
                              (_page == 2) ? Colors.orangeAccent : Colors.grey),
                      title: Text(
                        "Profile",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: (_page == 2)
                                ? Colors.orangeAccent
                                : Colors.grey),
                      ))
                ],
                onTap: navigationTapped,
                currentIndex: _page,
              )),
        ),
      ),
    );
  }
}
