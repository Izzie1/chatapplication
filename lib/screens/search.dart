import 'package:flutter/material.dart';
import 'package:funchat/models/account.dart';
import 'package:funchat/services/firebase_repository.dart';
import 'package:funchat/ultilities/sizeconfig.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  FirebaseRepository _repository = new FirebaseRepository();
  List<Account> accountList;
  String query = "";
  TextEditingController searchController = new TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _repository.getCurrentUser().then((user){
      _repository.getAllAccount(user).then((listAccount){
        setState(() {
          accountList = listAccount;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      body: Container(
        width: SizeConfig.screenWidth,
        height: SizeConfig.screenHeight,
        child: Column(
          children: [
            Row(
              children: [
                BackButton(),
                Container(
                  width: SizeConfig.safeBlockHorizontal * 80,
                  child: TextField(
                    controller: searchController,
                    onChanged: (val) {
                      setState(() {
                        query = val;
                      });
                    },
                    autofocus: true,
                    style: TextStyle(fontSize: 18),
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                      hintText: "Search...",
                      hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 18),
                      filled: true,
                      fillColor: Colors.grey.shade100,
                      border: InputBorder.none,
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(
                              color: Colors.grey.shade100
                          )
                      ),
                    ),
                  ),
                )
              ],
            ),
            buildSuggestions(query),
          ],
        ),
      ),
    )
    );
  }

  buildSuggestions(String query) {
    final List<Account> suggestionList = query.isEmpty
        ? []
        : accountList.where((user) {
      String _getUsername = user.username.toLowerCase();
      String _query = query.toLowerCase();
      String _getName = user.name.toLowerCase();
      bool matchesUsername = _getUsername.contains(_query);
      bool matchesName = _getName.contains(_query);

      return (matchesUsername || matchesName);

    }).toList();
    return ListView.builder(
      itemCount: suggestionList.length,
      shrinkWrap: true,
      padding: EdgeInsets.only(top: 0),
      itemBuilder: (context, index) {
          return Text(suggestionList[index].username);
      }
    );
  }
}
