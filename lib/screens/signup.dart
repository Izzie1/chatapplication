import 'package:chatapplication/screens/home.dart';
import 'package:chatapplication/service/authentication.dart';
import 'package:chatapplication/widgets/widget.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpstate createState() => _SignUpstate();
}

class _SignUpstate extends State<SignUp> {
  final formKey = GlobalKey<FormState>();
  bool isLoading = false;
  AuthenticationMethods authenticationMethods = new AuthenticationMethods();
  TextEditingController userNameTextEditingController =
      new TextEditingController();
  TextEditingController emailTextEditingController =
      new TextEditingController();
  TextEditingController passwordTextEditingController =
      new TextEditingController();

  signUserAccount() {
    if (formKey.currentState.validate()) {
      setState(() {
        isLoading = true;
      });

      authenticationMethods.signUpAccount(emailTextEditingController.text,
      passwordTextEditingController.text).then((value){
        //print("${value.uid}");
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Home()
        ));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
        ),
        body: isLoading ? Container(
          child: Center(child: CircularProgressIndicator(),),
        ) : SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height - 50,
            alignment: Alignment.center,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Form(
                    key: formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          validator: (username) {
                            return username.length < 4 || username.isEmpty
                                ? "Username is invalid"
                                : null;
                          },
                          controller: userNameTextEditingController,
                          decoration: textFieldInputDecoration("Username"),
                        ),
                        TextFormField(
                          validator: (email) {
                            return RegExp(
                                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+"
                                        r"-/=?^_`{|}~]+@[a-zA-Z0-9]+"
                                        r"\.[a-zA-Z]+")
                                    .hasMatch(email)
                                ? null
                                : "Invalid Email";
                          },
                          controller: emailTextEditingController,
                          decoration: textFieldInputDecoration("Email"),
                        ),
                        TextFormField(
                          validator: (password) {
                            return RegExp(r'^(?=.*?[A-Z])' //Minimum 1 Upper case
                            r'(?=.*?[a-z])' //Minimum 1 lowercase
                            r'(?=.*?[0-9])' //Minimum 1 Numeric Number
                            r'(?=.*?[!@#\$&*~]).{8,}$' //Minimum 1 Special Character
                            ).hasMatch(password)
                                ? null : "Invalid Password";
                            //TODO
                          },
                          controller: passwordTextEditingController,
                          decoration: textFieldInputDecoration("Password"),
                        ),
                      ],
                    ),
                  ),
                  Container(
                      alignment: Alignment.centerRight,
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 24),
                        child: Text("Forgot Password?"),
                      )
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  GestureDetector(
                    onTap: () {
                      signUserAccount();
                    },
                    child: Container(
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
        )
    );
  }
}
