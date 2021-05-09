import 'package:flutter/material.dart';
import 'package:funchat/enum/user_state.dart';
import 'package:funchat/provider/account_provider.dart';
import 'package:funchat/screens/login.dart';
import 'package:funchat/screens/pageviews/widgets/info_card.dart';
import 'package:funchat/services/firebase_methods.dart';
import 'package:funchat/services/firebase_repository.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  ProfilePageState createState() => ProfilePageState();

}
class ProfilePageState extends State<ProfilePage>{

  @override
  static final FirebaseRepository _repository = FirebaseRepository();
  static final FirebaseMethods firebaseMethods = FirebaseMethods();
  AccountProvider accountProvider;
  String name;
  String photo;
  String email;
  String phone;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _repository.getCurrentUser().then((user) {
      setState(() {
        photo = user.photoURL;
        name = user.displayName;
        email = user.email;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    accountProvider = Provider.of<AccountProvider>(context, listen: false);
    return  SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children:<Widget> [
          CircleAvatar(
            radius: 50,
            backgroundImage: photo != null ?
            NetworkImage(photo)
                : AssetImage('images/avatar.png'),
          ),
          name != null ? Text(
            name,
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
            ),
          ) : Text(""),
          SizedBox(
            height: 20,
            width: 200,
            child: Divider(
              color: Colors.teal.shade600,
            ),
          ),
          // InfoCard(
          //     phone,
          //     Icons.phone
          // ),

          email != null ? InfoCard(
              email,
              Icons.email
          ) : Text(""),

          SizedBox(
            height: 150,
            width: 200,
          ),
          FlatButton (
            child: Text("SignOut"),
            color: Colors.orangeAccent,
            onPressed: () {
              firebaseMethods.setUserState(userId: accountProvider.getAccount.uid,
                  userState: UserState.Offline);
              _repository.signOut();
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) {
                    return Login();
                  }));
            }
          )
          // InfoCard(url, Icons.web),
          // InfoCard(location, Icons.location_city)
        ],
      ),
    );
  }
}