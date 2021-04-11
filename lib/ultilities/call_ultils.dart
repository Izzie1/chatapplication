import 'dart:math';

import 'package:flutter/material.dart';
import 'package:funchat/models/account.dart';
import 'package:funchat/models/call.dart';
import 'package:funchat/screens/call/call.dart';
import 'package:funchat/services/call_methods.dart';


class CallUtils {
  static final CallMethods callMethods = CallMethods();

  static dial({Account from, Account to, context}) async {
    Call call = Call(
      callerId: from.uid,
      callerName: from.name,
      callerPic: from.avatar,
      receiverId: to.uid,
      receiverName: to.name,
      receiverPic: to.avatar,
      channelId: Random().nextInt(1000).toString(),
    );

    bool callMade = await callMethods.makeCall(call: call);

    call.hasDialled = true;

    if (callMade) {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CallScreen(call: call),
          ));
    }
  }
}