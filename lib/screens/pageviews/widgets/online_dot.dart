import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:funchat/enum/user_state.dart';
import 'package:funchat/models/account.dart';
import 'package:funchat/services/firebase_methods.dart';
import 'package:funchat/ultilities/utils.dart';

class OnlineDotIndicator extends StatelessWidget {
  final String uid;
  final FirebaseMethods firebaseMethods = FirebaseMethods();

  OnlineDotIndicator({
    @required this.uid,
  });

  @override
  Widget build(BuildContext context) {
    getColor(int state) {
      switch (Utils.numToState(state)) {
        case UserState.Offline:
          return Colors.red;
        case UserState.Online:
          return Colors.green;
        default:
          return Colors.orange;
      }
    }

    return Align(
      alignment: Alignment.topRight,
      child: StreamBuilder<DocumentSnapshot>(
        stream: firebaseMethods.getUserStream(
          uid: uid,
        ),
        builder: (context, snapshot) {
          Account account;

          if (snapshot.hasData && snapshot.data.data() != null) {
            account = Account.fromMap(snapshot.data.data());
          }

          return Align(
            alignment: Alignment.bottomRight,
            child: Container(
              height: 14,
              width: 14,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: getColor(account?.state),
              ),
            ),
          );
        },
      ),
    );
  }
}