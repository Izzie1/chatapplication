import 'package:chatapplication/helper/Authentication.dart';
import 'package:chatapplication/screens/login.dart';
import 'package:chatapplication/service/auth.dart';
import 'package:chatapplication/service/database.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  AuthMethods authMethods = new AuthMethods();
  DatabaseMethods databaseMethods = new DatabaseMethods();
  TextEditingController searchTextEditingController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        actions: [
          GestureDetector(
            onTap: () {
              authMethods.signOut();
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => Authentication()
                  ));
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Icon(Icons.exit_to_app),
            ),
          ),
        ],
      ),
      body: Container(
        child: Column(
          children: [
            Container(
              color: Color(0xff007114),
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Row(
                children: [
                  Expanded(
                      child: TextField(
                          controller: searchTextEditingController,
                          decoration: InputDecoration(
                            hintText: "Search..",
                            hintStyle: TextStyle(color: Colors.white),
                            border: InputBorder.none,
                          )
                      )
                  ),
                  GestureDetector(
                    onTap: () {
                      databaseMethods.getUserByUsername(
                          searchTextEditingController.text);
                    },
                    child: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: [
                                const Color(0x36FFFFFF),
                                const Color(0x0FFFFFFF)
                              ]
                          ),
                          borderRadius: BorderRadius.circular(40)
                      ),
                      padding: EdgeInsets.all(10),
                      child: Image.asset(
                        "assets/icons/search_white.png", color: Colors.blue,),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),

      ),
    );
  }

}
