import 'package:chatapplication/widgets/widget.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpstate createState() => _SignUpstate();
}

class _SignUpstate extends State<SignUp> {
  TextEditingController userNameTextEditingController =
      new TextEditingController();
  TextEditingController emailTextEditingController =
      new TextEditingController();
  TextEditingController passwordTextEditingController =
      new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
        ),
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height - 50,
            alignment: Alignment.center,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                        child: TextField(
                          decoration: textFieldInputDecoration("First Name"),
                        ),
                      ),
                      Flexible(
                        child: TextField(
                          decoration: textFieldInputDecoration("Last Name"),
                        ),
                      )
                    ],
                  ),
                  TextField(
                    controller: userNameTextEditingController,
                    decoration: textFieldInputDecoration("Username"),
                  ),
                  TextField(
                    controller: emailTextEditingController,
                    decoration: textFieldInputDecoration("Email"),
                  ),
                  TextField(
                    controller: passwordTextEditingController,
                    decoration: textFieldInputDecoration("Password"),
                  ),
                  Container(
                      alignment: Alignment.centerRight,
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 24),
                        child: Text("Forgot Password?"),
                      )),
                  SizedBox(
                    height: 8,
                  ),
                  Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.symmetric(vertical: 20),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        gradient: LinearGradient(colors: [
                          const Color(0xff007EF4),
                          const Color(0xff2A75BC)
                        ])),
                    child: Text(
                      "Sign Up",
                      style: customTextStyle(Colors.white),
                    ),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.symmetric(vertical: 20),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.lightBlueAccent),
                    child: Text(
                      "Log In with Google",
                      style: customTextStyle(Colors.white),
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Already have account? "),
                      Text("Log In now",
                          style:
                              TextStyle(decoration: TextDecoration.underline))
                    ],
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
