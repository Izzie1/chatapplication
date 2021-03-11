import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:funchat/services/firebase_repository.dart';
import 'package:shimmer/shimmer.dart';

import 'home.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  FirebaseRepository _repository = FirebaseRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff19191b),
      body: Center(
        child: Shimmer.fromColors(
          baseColor: Colors.white,
          highlightColor: Color(0xff2b343b),
          child: FlatButton(
            padding: EdgeInsets.all(35),
            child: Text(
              "Login",
              style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1.2),
            ),
            onPressed: performLogin,
          ),
        ),
      ),
    );
  }

  void performLogin() {
    _repository.googleSignInMethod().then((user) {
      if (user != null) {
        authenticateUser(user);
      }
    });
  }

  void authenticateUser(User user) {
    _repository.authenticateUser(user).then((isNewUser) {
      if (mounted) {
        setState(() {
          if (isNewUser) {
            _repository.addDataToDB(user).then((value) {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) {
                return Home();
              }));
            });
          } else {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) {
              return Home();
            }));
          }
        });
      }
    });
  }
}
