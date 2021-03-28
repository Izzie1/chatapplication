import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'pageviews/chat_list.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  PageController pageController;
  int _page = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
    return Scaffold(
      backgroundColor: Colors.white,
      body: PageView(
        children: <Widget>[
          Container(
            child: ChatList(),
          ),
          Center(child: Text("Groups", style: TextStyle(color: Colors.black))),
          Center(child: Text("Profile", style: TextStyle(color: Colors.black))),
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
                          color:
                              (_page == 0) ? Colors.orangeAccent : Colors.grey),
                    )),
                BottomNavigationBarItem(
                    icon: Icon(Icons.group,
                        color:
                            (_page == 1) ? Colors.orangeAccent : Colors.grey),
                    title: Text(
                      "Groups",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color:
                              (_page == 1) ? Colors.orangeAccent : Colors.grey),
                    )),
                BottomNavigationBarItem(
                    icon: Icon(Icons.account_circle,
                        color:
                            (_page == 2) ? Colors.orangeAccent : Colors.grey),
                    title: Text(
                      "Profile",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color:
                              (_page == 2) ? Colors.orangeAccent : Colors.grey),
                    ))
              ],
              onTap: navigationTapped,
              currentIndex: _page,
            )),
      ),
    );
  }
}
