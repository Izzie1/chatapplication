import 'package:chatapplication/screens/login.dart';
import 'package:chatapplication/screens/signup.dart';
import 'package:flutter/material.dart';

class Authentication extends StatefulWidget {
  @override
  _AuthenticationState createState() => _AuthenticationState();
}

class _AuthenticationState extends State<Authentication> {

  bool isLogin = true;

  void toggleView() {
    setState(() {
      isLogin = !isLogin;
    });
  }

  @override
  Widget build(BuildContext context) {
    if(isLogin){
      return Login(toggleView);
    }else{
      return SignUp(toggleView);
    }
  }
}
