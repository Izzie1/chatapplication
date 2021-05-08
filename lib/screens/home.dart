import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:funchat/enum/user_state.dart';
import 'package:funchat/provider/account_provider.dart';
import 'package:funchat/screens/call/pickup/pickup_layout.dart';
import 'package:funchat/screens/pageviews/profilePage.dart';
import 'package:funchat/services/firebase_methods.dart';
import 'package:funchat/services/firebase_repository.dart';
import 'package:provider/provider.dart';

import 'pageviews/chat_list.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with WidgetsBindingObserver {
  final FirebaseMethods firebaseMethods = FirebaseMethods();
  String name;
  String photo;
  AccountProvider accountProvider;
  PageController pageController;
  int _page = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    SchedulerBinding.instance.addPostFrameCallback((_) async{
      accountProvider = Provider.of<AccountProvider>(context, listen: false);
      await accountProvider.refreshUser();

      firebaseMethods.setUserState(
          userId: accountProvider.getAccount.uid,
          userState: UserState.Online
      );
    });

    WidgetsBinding.instance.addObserver(this);

    pageController = PageController();
  }

  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    String currentUserId =
    (accountProvider != null && accountProvider.getAccount != null)
        ? accountProvider.getAccount.uid
        : "";

    super.didChangeAppLifecycleState(state);

    switch (state) {
      case AppLifecycleState.resumed:
        currentUserId != null
            ? firebaseMethods.setUserState(
            userId: currentUserId, userState: UserState.Online)
            : print("resume state");
        break;
      case AppLifecycleState.inactive:
        currentUserId != null
            ? firebaseMethods.setUserState(
            userId: currentUserId, userState: UserState.Offline)
            : print("inactive state");
        break;
      case AppLifecycleState.paused:
        currentUserId != null
            ? firebaseMethods.setUserState(
            userId: currentUserId, userState: UserState.Offline)
            : print("paused state");
        break;
      case AppLifecycleState.detached:
        currentUserId != null
            ? firebaseMethods.setUserState(
            userId: currentUserId, userState: UserState.Offline)
            : print("detached state");
        break;
    }
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
